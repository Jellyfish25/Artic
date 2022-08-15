import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class MyPlans extends StatefulWidget {
  static const String id = 'myplans';

  @override
  State<MyPlans> createState() => _MyPlansState();
}

class _MyPlansState extends State<MyPlans> {
  List<String> plans = [
    'B.S in CMPE - SJSU',
    'B.S in PHIL - SJSU',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];
  int planIndex = -1;
  int favoriteIndex = -1;
  String favoritePlan = '';

  @override
  Widget build(BuildContext context) {
    int plansLength = plans.length;

    return Scaffold(
      appBar: const KAppBar(title: "My Plans"),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.width + 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFB0E8FA),
              border: Border.all(
                width: 3,
                color: const Color(0xFF2194D2),
              ),
            ),
            child: ListView.builder(
              itemCount: plansLength,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.transparent,

                  //******************* Single tap to favorite (single star)
                  // child: Transform.translate(
                  //   // adjust offset to change the list tile left to right spacing
                  //   offset: const Offset(25, 0),
                  //   child: ListTile(
                  //     onTap: () {
                  //       setState(() {
                  //         planIndex = index;
                  //         favoritePlan = plans[index];
                  //       });
                  //       print('Selected Item index at: $favoritePlan');
                  //     },
                  //     leading: Visibility(
                  //       visible: planIndex == index,
                  //       child: const Icon(
                  //         Icons.star,
                  //         size: 40,
                  //         color: Colors.black,
                  //       ),
                  //     ),

                  //***************** One tap to favorite, one tap to edit
                  child: ListTile(
                    onTap: () {},
                    leading: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          favoriteIndex = index;
                          favoritePlan = plans[index];
                          print('favorite plan: $favoritePlan');
                        });
                      },
                      icon: favoriteIndex == index
                          ? const Icon(Icons.star,
                              color: Colors.yellow, size: 30)
                          : const Icon(Icons.star_border,
                              //either make it gray, light gray, or white
                              color: Color(0xD9EEEEEE),
                              size: 30),
                    ),
                    title: Transform.translate(
                      // adjust offset to change the icon to text spacing
                      offset: const Offset(0, 0),
                      child: Text(
                        plans[index],
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 10,
                color: const Color(0xff1375CF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                onPressed: () {
                  print("you pressed me");
                },
                child: Text(
                  'CREATE PLAN',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
      drawer: kNavBar,
    );
  }
}
