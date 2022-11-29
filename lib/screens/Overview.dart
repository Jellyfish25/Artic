import 'package:artic/data_classes/Model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import '../data_classes/Plan.dart';
import '../constants.dart';
import '../data_classes/User.dart';

class Overview extends StatefulWidget {
  final Model model;
  static const String id = 'overview';
  const Overview({Key? key, required this.model}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState(model);
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xff1375CF),
        )
      )
    );
  }
}

class _OverviewState extends State<Overview> {
  bool isLoading = true;
  Model model;

  String planSchool = "";
  String planDegName = "";
  int numReqMet = 0;
  int totalReq = 0;

  _OverviewState(this.model) {
    setData();
  }

  Future<void> setData() async {
    isLoading = true;
    Plan favePlan = await model.getFavePlan();
    if(favePlan.planID != -1) {
      planDegName = favePlan.getDegName();
      List<String> reqMet = await model.getReqMet(favePlan);
      numReqMet = reqMet.length;
      List<String> reqNeeded = await model.getReqNeeded(favePlan);
      totalReq = numReqMet + reqNeeded.length;
      planSchool = await model.getPlanSchoolName(favePlan);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => isLoading ?
  const LoadingPage()
  : Scaffold(
      appBar: KAppBar(title: 'Overview', model: model),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Hi ${model.getUserName()}, You\'re This Close to Graduating!',
                style: GoogleFonts.roboto(
                  height: 1.0,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                width: 400,
                child: LiquidLinearProgressIndicator(
                  value: totalReq == 0 ? 0.0 : (numReqMet / totalReq).toDouble(),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF70C548)),
                  backgroundColor: Colors.white,
                  borderColor: const Color(0xFF022F3B),
                  borderWidth: 3.0,
                  borderRadius: 12.0,
                  direction: Axis.horizontal,
                  center: Text(
                    totalReq == 0 ? '0%' : '${(100 * numReqMet / totalReq).toStringAsFixed(2)}%',
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
                '$numReqMet/$totalReq Courses Complete for degree:',
                style: GoogleFonts.roboto(
                  height: 0.7,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.underline,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(
                  totalReq == 0 ? '-' : '$planDegName\nat\n$planSchool',
                  style: GoogleFonts.roboto(
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              Container(
                // adjust container width/height to fit box better
                width: 380,
                height: 225,
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
                      'How To Get Started',
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
                      child: Text(
                        '1. Enter Course History\n'
                            '2. Create Plan(s)\n'
                            '3. Compare Plans\n'
                            '4. Favorite a Plan\n'
                            '5. See Your Progress!',
                        style: GoogleFonts.roboto(
                          height: 1.4,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        ),
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
