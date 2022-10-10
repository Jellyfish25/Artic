import 'package:artic/data_classes/Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_choices/search_choices.dart';

import '../constants.dart';

class CourseHistory extends StatefulWidget {
  final Model model;
  static const String id = 'courseHistory';
  const CourseHistory({Key? key, required this.model}) : super(key: key);

  @override
  State createState() => _CourseHistoryState(model);
}

class _CourseHistoryState extends State<CourseHistory> {
  late Model model;
  late List<String> courseList = [];
  String selectedCollege = "";
  String selectedCourse = "";

  List<DropdownMenuItem> colleges = [];
  List<DropdownMenuItem> courseDropdownMenuItems = [];
  List<Map<String, Object?>> courseObjects = [];
  String selectedCollegeID = "";

  _CourseHistoryState(this.model) {
    print("constructor started");
    setColleges();
    //courseList = model.getCourseHistory();
    setCourseList();
    print("constructor ended");
  }

  Future<void> setColleges() async {
    colleges = await model.getSchoolNames();
    setState(() {});
  }

  Future<void> setCourseList() async {
    courseList = await model.getCourseHistory();
    setState(() {});
  }

  Future<void> setCourses(String collegeName) async {
    courseObjects = await model.getCourses(collegeName);
    List<Object?> prefixList =
    courseObjects.map((e) => e["course_prefix"]).toList();
    List<Object?> numList = courseObjects.map((e) => e["course_num"]).toList();

    selectedCollegeID = courseObjects[0]['school_id'].toString();

    courseDropdownMenuItems = [];

    for (int i = 0; i < numList.length; i++) {
      String course = prefixList[i] as String;
      course += "-";
      course += numList[i] as String;
      print(course);
      courseDropdownMenuItems.add(DropdownMenuItem(value: course, child: Text(course)));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("build started");
    return Scaffold(
      appBar: KAppBar(title: 'Course History', model: model),
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
                          offset: const Offset(20, 0),
                          child: ListTile(
                            trailing: IconButton(
                              color: const Color(0xFF2194D2),
                              onPressed: () {
                                setState(() {
                                  model.removeCourseFromHist(courseList[index]);
                                  courseList.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.close),
                            ),
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
                  setCourses(selectedCollege);
                });
              },
              isExpanded: true,
            ),
            const SizedBox(height: 15.0),
            SearchChoices.single(
              value: selectedCourse,
              items: courseDropdownMenuItems,
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
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.height / 15,
              color: const Color(0xff1375CF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              onPressed: () {
                if (selectedCollege != "" &&
                    selectedCourse != "" &&
                    !courseList.contains(selectedCourse)) {
                  setState(() {
                    model.addCourseToHist(selectedCollegeID, selectedCourse);
                    courseList.add(selectedCourse);
                    selectedCourse = "";
                  });
                }
              },
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
      drawer: getKNavBar(model),
    );
  }
}
