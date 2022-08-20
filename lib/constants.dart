import 'package:artic/screens/EditAccount.dart';
import 'package:artic/screens/ExploreMajors.dart';
import 'package:artic/screens/Overview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/CompareDegree.dart';
// screens
import 'screens/MyPlans.dart';
import 'screens/WelcomeScreen.dart';


//placeholder until class gets made for list
List<int> indexes = <int>[];
List<String> fruit = [
  'Electrical Engineering',
  'banana',
  'orange',
  'pineapple',
  'B.S. Computer Engineering',
  'potato'
];


// potentially make this the entire button, constant button for confirm?
const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

// copied from Flash Chat App as an example
const kTextFieldDecoration = InputDecoration(
  labelText: '',
  icon: Icon(null),
  isDense: true,
  contentPadding: EdgeInsets.all(8),
  hintText: 'Enter a value',
  hintStyle: TextStyle(fontSize: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF006CD0), width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF006CD0), width: 2.0),
  ),
);

// Navigation bar
SizedBox kNavBar = SizedBox(
  width: 240,
  child: Drawer(
      child: ListView(
    padding: EdgeInsets.zero,
    children: [
      SizedBox(
        height: 90,
        child: DrawerHeader(
          margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: [
              Material(
                borderRadius: BorderRadius.circular(101),
                elevation: 5,
                child: const CircleAvatar(
                  backgroundImage: AssetImage('images/IceCube.png'),
                  radius: 20,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'ARTIC',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 36,
                  color: const Color(0xff1375CF),
                ),
              ),
            ],
          ),
        ),
      ),
      const Divider(
        thickness: 1,
        color: Colors.grey,
      ),
      const SizedBox(height: 5),
      ListTile(
        //note: can decrease spacing by adding density
        // dense: true,
        // visualDensity: const VisualDensity(vertical: -3),
        leading: kHomeIcon,
        title: const KNavBarText(title: 'Overview'),
        onTap: () {
          Get.to(() => Overview());
        },
      ),
      ListTile(
        leading: const ClipRect(
            child: Icon(Icons.compare_arrows, color: Colors.black, size: 40)),
        title: const KNavBarText(title: 'Compare Plans'),
        onTap: () {
          indexes.clear();
          Get.to(() => CompareDegree());
        },
      ),
      ListTile(
        leading: const ClipRect(
            child: Icon(Icons.search, color: Colors.black, size: 40)),
        title: const KNavBarText(title: 'Explore Majors'),
        onTap: () {
          Get.to(() => ExploreMajors());
        },
      ),
      ListTile(
        leading: const ClipRect(
            child: Icon(Icons.task, color: Colors.black, size: 40)),
        title: const KNavBarText(title: 'My Plans'),
        onTap: () {
          Get.to(() => MyPlans());
        },
      ),
      ListTile(
        leading: const ClipRect(
            child: Icon(Icons.history, color: Colors.black, size: 40)),
        title: const KNavBarText(title: 'Course History'),
        onTap: () {},
      ),
      const SizedBox(height: 160),
      ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: -3),
        title: const KNavBarText(
          title: "How do I use this app?",
          fontColor: Color(0xFF007BFF),
          decoration: TextDecoration.underline,
        ),
        onTap: () {},
      ),
      const SizedBox(
        height: 5,
      ),
      const Divider(
        thickness: 1,
        color: Colors.grey,
      ),
      ListTile(
          dense: true,
          visualDensity: const VisualDensity(vertical: -3),
          title: const KNavBarText(title: "Sign Out"),
          onTap: () {
            Get.to(() => const WelcomeScreen());
          }),
      ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: -3),
        title: const KNavBarText(title: "Edit Account"),
        onTap: () {
          Get.to(() => const EditAccountScreen());
        },
      )
    ],
  )),
);

//Helper class for kNavBar
class KNavBarText extends StatelessWidget {
  final String title;
  final Color fontColor;
  final TextDecoration decoration;

  const KNavBarText(
      {super.key,
      required this.title,
      this.fontColor = Colors.black,
      this.decoration = TextDecoration.none});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        height: 0.7,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 20,
        color: fontColor,
        decoration: decoration,
      ),
    );
  }
}

// Home button icon
Container kHomeIcon = Container(
  decoration: BoxDecoration(
    color: Colors.black,
    border: Border.all(
      color: Colors.black,
    ),
    borderRadius: const BorderRadius.all(Radius.circular(5)),
  ),
  child: const Icon(Icons.home, color: Colors.white, size: 30),
);

// App bar constant (top of each page)
class KAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const KAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      toolbarHeight: 60,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Color(0xFF007BFF)),
      title: Text(
        title,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          fontSize: 26,
          color: const Color(0xFF007BFF),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.to(() => Overview());
          },
          child: kHomeIcon,
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: Colors.grey,
          height: 1.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
