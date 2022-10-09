import 'package:artic/data_classes/Model.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artic/components/rounded_button.dart';

class ViewPlan extends StatefulWidget {
  final Model model;
  static const String id = 'ViewPlan';
  const ViewPlan({Key? key, required this.model}) : super(key: key);

  @override
  State<ViewPlan> createState() => _ViewPlanState(model);
}

class _ViewPlanState extends State<ViewPlan> {
  Model model;

  _ViewPlanState(this.model);

  List<String> reqNeeded = [
    'Engr 10',
    'Intro to Java',
    'Math 101A',
    'Physics',
  ];

  List<String> reqMet = [
    'Engr 10',
    'Intro to Java',
    'Math 101A',
    'Physics',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(title: 'View Plan', model: model),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'B.S. Computer Engineering, SJSU',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              // adjust container width/height to fit box better
              width: 350,
              height: 250,
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
                    'Requirements Needed',
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
                      itemCount: reqNeeded.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Transform.translate(
                          // adjust offset to change the list tile left to right spacing
                          offset: const Offset(20, 0),
                          child: ListTile(
                            dense: true,
                            visualDensity: const VisualDensity(vertical: -3),
                            title: Text(
                              '${index + 1}. ${reqNeeded[index]}',
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
            )
            ,
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              // adjust container width/height to fit box better
              width: 350,
              height: 250,
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
                    'Requirements Met',
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
                      itemCount: reqMet.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Transform.translate(
                          // adjust offset to change the list tile left to right spacing
                          offset: const Offset(20, 0),
                          child: ListTile(
                            dense: true,
                            visualDensity: const VisualDensity(vertical: -3),
                            title: Text(
                              '${index + 1}. ${reqMet[index]}',
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
            )
            ,
          ),
        ],
      )
      ,
      drawer: getKNavBar(model),
    );
  }
}
