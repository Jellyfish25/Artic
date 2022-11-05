import 'package:artic/data_classes/Model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import '../constants.dart';


class Overview extends StatefulWidget {
  final Model model;
  static const String id = 'overview';
  const Overview({Key? key, required this.model}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState(model);
}

class _OverviewState extends State<Overview> {
  Model model;
  List<String> courseList = [
    'Engr 10',
    'Intro to Java',
    'Math 101A',
    'Physics',
  ];
  final int barStatus = 75;

  _OverviewState(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(title: 'Overview', model: model),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'You\'re This Close to Graduating!',
                style: GoogleFonts.roboto(
                  height: 0.7,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              //Image.asset('images/gradBar.png'),
              //*********************** progress bar
              SizedBox(
                height: 40,
                width: 400,
                child: LiquidLinearProgressIndicator(
                  value: (barStatus / 100).toDouble(),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF70C548)),
                  backgroundColor: Colors.white,
                  borderColor: const Color(0xFF022F3B),
                  borderWidth: 3.0,
                  borderRadius: 12.0,
                  direction: Axis.horizontal,
                  center: Text(
                    '$barStatus%',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 24,
                        color: const Color(0xFF000000)),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Text(
                '3/4 Courses Complete for degree:',
                style: GoogleFonts.roboto(
                  height: 0.7,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.underline,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'CMPE - SJSU',
                style: GoogleFonts.roboto(
                  height: 0.7,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 40,
                ),
              ),
              const SizedBox(height: 50),

              //Image.asset('images/inProgressCourses.png'),
              // ******************************************* Course Display List
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
                      'Courses Currently being Taken',
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
            ],
          ),
        ),
      ),
      drawer: getKNavBar(model),
    );
  }
}
