import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import 'ComparisonScreen.dart';

class CompareDegree extends StatefulWidget {
  @override
  _CompareDegreeState createState() => _CompareDegreeState();
  static const String id = 'CompareDegree';
}

class _CompareDegreeState extends State<CompareDegree> {
  List<int> _selectedItems = <int>[];

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KAppBar(
        title: 'Compare Degrees',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Container(
                // adjust container width/height to fit box better
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.75,
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
                      'Degree list',
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
                        itemCount: fruit.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: (_selectedItems.contains(index))
                                ? Colors.blue.withOpacity(0.5)
                                : Colors.transparent,
                            child: ListTile(
                              onTap: () {
                                if (!_selectedItems.contains(index)) {
                                  if (count != 2) {
                                    setState(() {
                                      _selectedItems.add(index);
                                      indexes.add(index);
                                      count++;
                                    });
                                  }
                                } else if (_selectedItems.contains(index)) {
                                  setState(() {
                                    _selectedItems
                                        .removeWhere((val) => val == index);
                                    indexes.removeWhere((val) => val == index);
                                    count--;
                                  });
                                }
                              },
                              onLongPress: () {
                                print('Selected Item index at: $indexes');
                                //idk what we want this to do yet
                              },
                              title: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  fruit[index],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
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
            const SizedBox(height: 50.0),
            Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 10,
                color: const Color(0xff1375CF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                onPressed: () {
                  count == 2
                      ? Get.to(() => ComparisonScreen())
                      : showAlertDialog(context);
                },
                child: Text(
                  'Compare Plans',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: kNavBar,
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Please select 2 degree plans"),
    actions: [
      okButton,
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
