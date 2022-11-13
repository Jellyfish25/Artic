import 'package:artic/data_classes/Model.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data_classes/Plan.dart';

class ViewPlan extends StatefulWidget {
  final Model model;
  final Plan plan;
  static const String id = 'ViewPlan';
  const ViewPlan({Key? key, required this.model, required this.plan})
      : super(key: key);

  @override
  State<ViewPlan> createState() => _ViewPlanState(model, plan);
}

class _ViewPlanState extends State<ViewPlan> {
  Model model;
  Plan plan;
  late List<String> reqNeeded = [];
  late List<String> reqMet = [];

  _ViewPlanState(this.model, this.plan) {
    setReqNeeded();
    setReqMet();
  }

  Future<void> setReqNeeded() async {
    reqNeeded = await model.getReqNeeded(plan);
    setState(() {});
  }
  Future<void> setReqMet() async {
    reqMet = await model.getReqMet(plan);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(title: 'View Plan', model: model),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            plan.getDegName(),
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
                    child: reqNeeded.isEmpty ?
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Text("Congrats, it seems that you've completed all the requirements needed for this degree!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                          )),
                    ) : ListView.builder(
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
                    child: reqMet.isEmpty ?
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Text("It appears that you haven't met any of this degree's requirements.\n\nDoes this seem right? If not, update your Course History with all the courses you've completed.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                      )),
                    ) :
                    ListView.builder(
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
            ),
          ),
        ],
      ),
      drawer: getKNavBar(model),
    );
  }
}
