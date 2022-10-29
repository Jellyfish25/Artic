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
  late List<String> reqNeeded1 = [];
  late List<String> reqNeeded2 = [];
  late List<String> shared = [];
  late int sharedLength = 0;

  _ComparisonScreenState(this.model, this.plan1, this.plan2) {
    setReqNeeded();
  }

  Future<void> setReqNeeded() async {
    reqNeeded1 = await model.getReqNeeded(plan1);
    reqNeeded2 = await model.getReqNeeded(plan2);

    shared.addAll(reqNeeded1);
    shared.removeWhere((item) => !reqNeeded2.contains(item));

    sharedLength = shared.length;

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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // SizedBox(
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: Text(
            //       'Plans: \n${plan1.degName}\n${plan2.degName}',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 20.0,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 5.0),
            // ListTile(
            //   dense: true,
            //   visualDensity: const VisualDensity(vertical: -3),
            //   title: Align(
            //     alignment: Alignment.center,
            //     child: Text(
            //       plan1.degName,
            //       style: GoogleFonts.roboto(
            //         color: Colors.black,
            //         fontSize: 15.0,
            //         fontWeight: FontWeight.w400,
            //       ),
            //     ),
            //   ),
            // ),
            // ListTile(
            //   dense: true,
            //   visualDensity: const VisualDensity(vertical: -3),
            //   title: Align(
            //     alignment: Alignment.center,
            //     child: Text(
            //       plan2.degName,
            //       style: GoogleFonts.roboto(
            //         color: Colors.black,
            //         fontSize: 15.0,
            //         fontWeight: FontWeight.w400,
            //       ),
            //     ),
            //   ),
            // ),
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
                    const SizedBox(height: 5),
                    const Divider(
                      thickness: 5,
                      color: Color(0xFFC8F1FE),
                    ),
                    //const SizedBox(height: 5),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 5,
                        ),
                        itemCount: sharedLength,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 20.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
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
                      '${plan1.degName} Courses',
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
                    //const SizedBox(height: 5),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 5,
                        ),
                        itemCount: reqNeeded1.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 20.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${index + 1}. ${reqNeeded1[index]}',
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
                      '${plan2.degName} Courses',
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
                    //const SizedBox(height: 5),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 5,
                        ),
                        itemCount: reqNeeded2.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 20.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${index + 1}. ${reqNeeded2[index]}',
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
