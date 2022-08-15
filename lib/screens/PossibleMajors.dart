import 'package:artic/components/rounded_button.dart';
import 'package:artic/constants.dart';
import 'package:artic/screens/ExploreMajors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:google_fonts/google_fonts.dart';

class PossibleMajors extends StatefulWidget {
  static const String id = 'possible_majors';
  @override
  _PossibleMajorsState createState() => _PossibleMajorsState();
}

class _PossibleMajorsState extends State<PossibleMajors> {
  bool showSpinner = false;

  // Tester data for searchable dropdown
  List<int> selectedColleges = [];
  final List<DropdownMenuItem> colleges = [
    const DropdownMenuItem(
        value: "San Jose State University (SJSU)",
        child: Text("San Jose State University (SJSU)")),
    const DropdownMenuItem(
        value: "University of California San Diego (USCD)",
        child: Text("University of California San Diego (USCD)")),
    const DropdownMenuItem(
        value: "University of California Los Angeles (UCLA)",
        child: Text("University of California Los Angeles (UCLA)")),
    const DropdownMenuItem(
        value: "California State University San Marcos (CSUSM)",
        child: Text("California State University San Marcos (CSUSM)")),
  ];

  List<int> selectedMajors = [];
  final List<DropdownMenuItem> majors = [
    const DropdownMenuItem(
        value: "B.S. Computer Engineering",
        child: Text("B.S. Computer Engineering")),
    const DropdownMenuItem(
        value: "B.A. Business Marketing",
        child: Text("B.A. Business Marketing")),
    const DropdownMenuItem(
        value: "B.S. Software Engineering",
        child: Text("B.S. Software Engineering")),
    const DropdownMenuItem(
        value: "B.A. Philosophy", child: Text("B.A. Philosophy")),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: const KAppBar(title: "Possible Majors"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Here is a list of possible majors:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: 400.0,
                  height: 400.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF52B9CF), width: 2.0),
                    borderRadius: BorderRadius.circular(24.0),
                    color: const Color(0xffB1E4F4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
                    child: Text(
                      '1. B.S. in Software Engineering - SJSU\n\n2. B.S. in Computer Engineering - SJSU\n\n3. BS in Computer Science - SJSU\n\n4. A.S. in Compuiter Science - Ohlone College',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    '*based on your coursework and specified colleges/majors',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                RoundedButton(
                    title: 'Return',
                    color: const Color(0xFF1375CF),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      Get.to(() => ExploreMajors());
                    },
                    height: 50.0,
                    width: 250.0
                ),

              ],
            ),
          ),
        ),
      ),
      drawer: kNavBar,
    );
  }
}