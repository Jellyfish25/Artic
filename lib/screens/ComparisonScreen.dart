import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../data_classes/Model.dart';
import '../data_classes/Plan.dart';

class ComparisonScreen extends StatefulWidget {
  final Model model;
  final Plan plan1;
  final Plan plan2;

  const ComparisonScreen(
      {Key? key, required this.model, required this.plan1, required this.plan2})
      : super(key: key);

  @override
  State<ComparisonScreen> createState() =>
      _ComparisonScreenState(model, plan1, plan2);
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  Model model;
  Plan plan1;
  Plan plan2;
  late List<String> req1 = [];
  late List<String> req2 = [];
  late List<String> shared = [];
  late int completedShared = -1, completed1 = -1, completed2 = -1;


  _ComparisonScreenState(this.model, this.plan1, this.plan2) {
    setReqNeeded();
  }

  Future<void> setReqNeeded() async {
    req1 = await model.getReqs(plan1);
    req2 = await model.getReqs(plan2);
    shared.addAll(req1);
    shared.removeWhere((item) => !req2.contains(item));
    req1.removeWhere((item) => shared.contains(item));
    req2.removeWhere((item) => shared.contains(item));

    List<String> courseEquivHist1 = await model.getEquivalentCourseHistory(plan1.getSchoolID());
    List<String> courseEquivHist2 = await model.getEquivalentCourseHistory(plan2.getSchoolID());
    completedShared = 0;
    completed1 = 0;
    completed2 = 0;
    for (String course in courseEquivHist1) {
      if (shared.contains(course)) {
        completedShared++;
      }
      else if (req1.contains(course)) {
        completed1++;
      }
    }
    for (String course in courseEquivHist2) {
      if (req2.contains(course)) {
        completed2++;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        title: 'Compare Plans',
        model: model,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
            top: 15.0, bottom: 15.0, left: 5.0, right: 5.0),
        child: Column(
          children: [
            Center(
              child: Container(
                // adjust container width/height to fit box better
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  border: Border.all(
                    width: 3,
                    color: const Color(0xFF2194D2),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Shared Courses',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: const Color(0xFF1375CF),
                        fontSize: 20,
                      ),
                    ),
                    const Divider(
                      thickness: 5,
                      color: Color(0xFFC8F1FE),
                    ),
                    //const SizedBox(height: 5),
                    Expanded(
                      child: shared.isEmpty ?
                      Text("No courses belong to both ${plan1.degName} and ${plan2.degName}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        )) :
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 5,
                        ),
                        itemCount: shared.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${index + 1}. ${shared[index]}',
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(
                      thickness: 4,
                      color: Color(0xFFC8F1FE),
                    ),
                    Text(
                      'Completed: $completedShared                                       Uncompleted: ${shared.length - completedShared}',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: const Color(0xFF1375CF),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Container(
                // adjust container width/height to fit box better
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  border: Border.all(
                    width: 3,
                    color: const Color(0xFF2194D2),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Just ${plan1.degName} Courses',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: const Color(0xFF1375CF),
                        fontSize: 20,
                      ),
                    ),
                    const Divider(
                      thickness: 5,
                      color: Color(0xFFC8F1FE),
                    ),
                    //const SizedBox(height: 5),
                    Expanded(
                      child: req1.isEmpty ?
                      Text("No courses belong only to ${plan1.degName}\nThey are all shared with the other plan being compared.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        )) :
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 5,
                        ),
                        itemCount: req1.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${index + 1}. ${req1[index]}',
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                const Divider(
                  thickness: 4,
                  color: Color(0xFFC8F1FE),
                ),
                Text(
                  'Completed: $completed1                                       Uncompleted: ${req1.length - completed1}',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: const Color(0xFF1375CF),
                    fontSize: 12,
                  ),)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Container(
                // adjust container width/height to fit box better
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  border: Border.all(
                    width: 3,
                    color: const Color(0xFF2194D2),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Just ${plan2.degName} Courses',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: const Color(0xFF1375CF),
                        fontSize: 20,
                      ),
                    ),
                    const Divider(
                      thickness: 5,
                      color: Color(0xFFC8F1FE),
                    ),
                    //const SizedBox(height: 5),
                    Expanded(
                      child: req2.isEmpty ?
                      Text("No courses belong only to ${plan2.degName}\nThey are all shared with the other plan being compared.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ))  :
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 5,
                        ),
                        itemCount: req2.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${index + 1}. ${req2[index]}',
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                const Divider(
                  thickness: 4,
                  color: Color(0xFFC8F1FE),
                ),
                Text(
                  'Completed: $completed2                                       Uncompleted: ${req2.length - completed2}',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: const Color(0xFF1375CF),
                    fontSize: 12,
                  ),)
                  ],
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
