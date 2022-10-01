import 'package:artic/components/rounded_button.dart';
import 'package:artic/constants.dart';
import 'package:artic/data_classes/Model.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:search_choices/search_choices.dart';

import 'Overview.dart';

class ExploreMajors extends StatefulWidget {
  final Model model;
  static const String id = 'explore_majors';

  const ExploreMajors({Key? key, required this.model}) : super(key: key);

  @override
  _ExploreMajorsState createState() => _ExploreMajorsState(model);
}

class _ExploreMajorsState extends State<ExploreMajors> {
  Model model;
  bool showSpinner = false;

  _ExploreMajorsState(this.model);

  // Tester data for searchable dropdown
  List<int> selectedColleges = [];
  final List<DropdownMenuItem> colleges = [
    const DropdownMenuItem(
        value: "San Jose State University (SJSU)",
        child: Text("San Jose State University (SJSU)")),
    const DropdownMenuItem(
        value: "University of California San Diego (USCD)",
        child: Text("University of California San Diego (USCD)")),
    const DropdownMenuItem(
        value: "University of California Los Angeles (UCLA)",
        child: Text("University of California Los Angeles (UCLA)")),
    const DropdownMenuItem(
        value: "California State University San Marcos (CSUSM)",
        child: Text("California State University San Marcos (CSUSM)")),
  ];

  List<int> selectedMajors = [];
  final List<DropdownMenuItem> majors = [
    const DropdownMenuItem(
        value: "B.S. Computer Engineering",
        child: Text("B.S. Computer Engineering")),
    const DropdownMenuItem(
        value: "B.A. Business Marketing",
        child: Text("B.A. Business Marketing")),
    const DropdownMenuItem(
        value: "B.S. Software Engineering",
        child: Text("B.S. Software Engineering")),
    const DropdownMenuItem(
        value: "B.A. Philosophy", child: Text("B.A. Philosophy")),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: KAppBar(title: "Explore Majors", model: model),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Specify College(s)',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SearchChoices.multiple(
                  items: colleges,
                  selectedItems: selectedColleges,
                  hint: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Select any"),
                  ),
                  searchHint: "Select any",
                  onChanged: (value) {
                    setState(() {
                      selectedColleges = value;
                    });
                  },
                  closeButton: (selectedColleges) {
                    return (selectedColleges.isNotEmpty
                        ? "Save ${selectedColleges.length == 1 ? '"' + colleges[selectedColleges.first].value.toString() + '"' : '(' + selectedColleges.length.toString() + ')'}"
                        : "Save without selection");
                  },
                  isExpanded: true,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Specify Major(s)',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SearchChoices.multiple(
                  items: majors,
                  selectedItems: selectedMajors,
                  hint: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Select any"),
                  ),
                  searchHint: "Select any",
                  onChanged: (value) {
                    setState(() {
                      selectedMajors = value;
                    });
                  },
                  closeButton: (selectedMajors) {
                    return (selectedMajors.isNotEmpty
                        ? "Save ${selectedMajors.length == 1 ? '"' + majors[selectedMajors.first].value.toString() + '"' : '(' + selectedMajors.length.toString() + ')'}"
                        : "Save without selection");
                  },
                  isExpanded: true,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                RoundedButton(
                    title: 'Explore',
                    color: const Color(0xFF1375CF),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });

                      try {
                        final user = null; // filler code until DB is set up
                        /*
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                       */
                        if (user != '') {
                          Navigator.pushNamed(context, Overview.id);
                        }

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    height: 50.0,
                    width: 250.0),
              ],
            ),
          ),
        ),
      ),
      drawer: getKNavBar(model),
    );
  }
}
