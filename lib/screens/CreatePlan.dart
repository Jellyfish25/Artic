import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import 'ViewPlan.dart';

bool agreed = false;

class CreatePlan extends StatefulWidget {
  static const String id = 'CreatePlan';
  const CreatePlan({Key? key}) : super(key: key);

  @override
  State<CreatePlan> createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const KAppBar(title: 'Create Plan'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                  alignment: Alignment.centerLeft, child: Text("Degree:")),
              const SizedBox(height: 10.0),
              TextField(
                textAlign: TextAlign.left,
                onChanged: (value) {},
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Degree Name',
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              const SizedBox(height: 10.0),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Current College/University:")),
              const SizedBox(height: 10.0),
              TextField(
                textAlign: TextAlign.left,
                onChanged: (value) {},
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'College/University',
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              const SizedBox(height: 10.0),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Receive Degree At:")),
              const SizedBox(height: 10.0),
              TextField(
                textAlign: TextAlign.left,
                onChanged: (value) {},
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'College/University',
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              const SizedBox(height: 10.0),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Desired Units Per Term:")),
              const SizedBox(height: 10.0),
              TextField(
                textAlign: TextAlign.left,
                onChanged: (value) {},
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Desired Units',
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              const SizedBox(height: 145.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 10,
                  color: const Color(0xff1375CF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0)),
                  onPressed: () {
                    !agreed
                        ? showAlertDialog(context)
                        : Navigator.pushNamed(context, ViewPlan.id);
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
      drawer: kNavBar,
    );
  }
}

showAlertDialog(BuildContext context) {
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
              Navigator.pushNamed(context, ViewPlan.id);
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
