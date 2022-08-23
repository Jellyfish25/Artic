import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_choices/search_choices.dart';

import '../constants.dart';

class CourseHistory extends StatefulWidget {
  static const String id = 'courseHistory';
  const CourseHistory({Key? key}) : super(key: key);

  @override
  State createState() => _CourseHistoryState();
}

class _CourseHistoryState extends State<CourseHistory> {
  List<String> courseList = [
    'Engr 10',
    'Intro to Java',
    'Math 101A',
    'Physics',
    'butt',
    'gho',
    'bifenifr',
    'fre',
    'fre'
  ];
  String selectedCollege = "";
  String selectedCourse = "";
  final List<DropdownMenuItem> colleges = [
    const DropdownMenuItem(
        value: "SJSU", child: Text("San Jose State University (SJSU)")),
    const DropdownMenuItem(
        value: "UCSD",
        child: Text("University of California San Diego (UCSD)")),
    const DropdownMenuItem(
        value: "UCLA",
        child: Text("University of California Los Angeles (UCLA)")),
    const DropdownMenuItem(
        value: "CSUSM",
        child: Text("California State University San Marcos (CSUSM)")),
  ];
  final Map<String, List<DropdownMenuItem>> courses = {
    "SJSU": [
      const DropdownMenuItem(
          value: "sjsuCourse1", child: Text("SJSU Course 1")),
      const DropdownMenuItem(
          value: "sjsuCourse2", child: Text("SJSU Course 2")),
    ],
    "UCSD": [
      const DropdownMenuItem(
          value: "ucsdCourse3", child: Text("UCSD Course 3")),
      const DropdownMenuItem(
          value: "ucsdCourse4", child: Text("UCSD Course 4")),
    ],
    "UCLA": [
      const DropdownMenuItem(
          value: "uclaCourse5", child: Text("UCLA Course 5")),
      const DropdownMenuItem(
          value: "uclaCourse6", child: Text("UCLA Course 6")),
    ],
    "CSUSM": [
      const DropdownMenuItem(
          value: "csusmCourse7", child: Text("CSUSM Course 7")),
      const DropdownMenuItem(
          value: "csusmCourse8", child: Text("CSUSM Course 8")),
    ],
    "": []
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KAppBar(title: 'Course History'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              // adjust container width/height to fit box better
              width: 380,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFB0E8FA),
                border: Border.all(
                  width: 3,
                  color: const Color(0xFF2194D2),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Course List',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      color: const Color(0xFF1375CF),
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(
                    thickness: 5,
                    color: Color(0xFFC8F1FE),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                      itemCount: courseList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Transform.translate(
                          // adjust offset to change the list tile left to right spacing
                          offset: const Offset(60, 0),
                          child: ListTile(
                            dense: true,
                            visualDensity: const VisualDensity(vertical: -3),
                            title: Text(
                              '${index + 1}. ${courseList[index]}',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Search for classes to add',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            SearchChoices.single(
              value: selectedCollege,
              items: colleges,
              //selectedItems: selectedColleges,
              hint: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Specify college"),
              ),
              onChanged: (value) {
                setState(() {
                  selectedCollege = value; //?
                });
              },
              isExpanded: true,
            ),
            const SizedBox(height: 15.0),
            SearchChoices.single(
              value: selectedCourse,
              items: courses[selectedCollege],
              hint: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Specify course number"),
              ),
              onChanged: (value) {
                setState(() {
                  selectedCourse = value; //?
                });
              },
              isExpanded: true,
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.height / 15,
              color: const Color(0xff1375CF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              onPressed: () {},
              child: Text(
                'Submit',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: kNavBar,
    );
  }
}
