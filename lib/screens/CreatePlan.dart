import 'package:artic/data_classes/Model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_choices/search_choices.dart';
import '../constants.dart';
import 'ViewPlan.dart';
import 'package:artic/data_classes/Plan.dart';

bool agreed = false;

class CreatePlan extends StatefulWidget {
  final Model model;
  static const String id = 'CreatePlan';
  const CreatePlan({Key? key, required this.model}) : super(key: key);

  @override
  State<CreatePlan> createState() => _CreatePlanState(model);
}

class _CreatePlanState extends State<CreatePlan> {
  Model model;
  String degreeName = '';
  String currentCollege = '';
  String targetCollege = '';

  List<DropdownMenuItem> degrees = [];
  List<DropdownMenuItem> colleges = [];

  _CreatePlanState(this.model) {
    print("constructor started");
    setColleges();
    print("constructor ended");
  }

  Future<void> setColleges() async {
    colleges = await model.getSchoolNames();
    setState(() {});
  }

  Future<void> setDegrees(String collegeID) async {
    degrees = await model.getSchoolDegrees(collegeID);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: KAppBar(title: 'Create Plan', model: model),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Enter the College currently enrolled in",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                      ),
                    ),
                  )),
              SearchChoices.single(
                value: currentCollege,
                items: colleges,
                //selectedItems: selectedColleges,
                hint: const Text("Current College/University"),
                onChanged: (value) {
                  setState(() {
                    currentCollege = value; //?
                  });
                },
                isExpanded: true,
                searchFn: (keyword, items) {
                  // returns indexes of items that are relevant to the keyword
                  List<int> result = [];
                  for (int i = 0; i < items.length; i++) {
                    if (items[i]
                        .child
                        .toString()
                        .toLowerCase()
                        .contains(keyword.toLowerCase())) {
                      result.add(i);
                    }
                  }
                  return result;
                },
              ),
              const SizedBox(height: 30.0),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Enter the target College for transfer",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                      ),
                    ),
                  )),
              SearchChoices.single(
                value: targetCollege,
                items: colleges,
                //selectedItems: selectedColleges,
                hint: Text("Target College/University"),
                onChanged: (value) {
                  setState(() {
                    targetCollege = value; //?
                    setDegrees(targetCollege);
                  });
                },
                isExpanded: true,
                searchFn: (keyword, items) {
                  // returns indexes of items that are relevant to the keyword
                  List<int> result = [];
                  for (int i = 0; i < items.length; i++) {
                    if (items[i]
                        .child
                        .toString()
                        .toLowerCase()
                        .contains(keyword.toLowerCase())) {
                      result.add(i);
                    }
                  }
                  return result;
                },
              ),
              const SizedBox(height: 30.0),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Enter the Degree Name",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                      ),
                    ),
                  )),
              SearchChoices.single(
                value: degreeName,
                items: degrees,
                hint: Text("Degree Name"),
                onChanged: (value) {
                  setState(() {
                    degreeName = value;
                  });
                },
                isExpanded: true,
              ),
              const SizedBox(height: 120.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 10,
                  color: const Color(0xff1375CF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0)),
                  onPressed: () {
                    print(degreeName);
                    print(currentCollege);
                    print(targetCollege);
                    DateTime today = DateTime.now();
                    Plan currentPlan = Plan(
                        0,
                        "${today.year}-${today.month}-${today.day}", //TODO: address planID issue
                        model.getCurrentUser(),
                        targetCollege,
                        degreeName);
                    model.addPlan(currentPlan);
                    !agreed
                        ? showAlertDialog(context,
                            model: model, plan: currentPlan)
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewPlan(model: model, plan: currentPlan)));
                  },
                  child: Text(
                    'Generate Plan',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle:
                        const TextStyle(color: Colors.blue, fontSize: 20)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
      drawer: getKNavBar(model),
    );
  }
}

showAlertDialog(BuildContext context,
    {required Plan plan, required Model model}) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    title: const Center(
      child: Text(
        "Warning",
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    ),
    content: SizedBox(
        width: 50,
        height: 160,
        child: Column(
          children: const [
            Text(
                "This plan does not comprise a binding transfer agreement, nor does it provide information about transfer elgibility."),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Text(
                "Please consult with your academic advisor for detailed information.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )),
    actions: [
      Row(
        children: [
          TextButton(
            onPressed: () {
              agreed = true;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ViewPlan(model: model, plan: plan)));
            },
            child: const Text("Agree"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Disagree"),
          ),
        ],
      )
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
