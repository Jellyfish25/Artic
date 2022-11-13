import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../data_classes/Model.dart';

class PossibleMajors extends StatefulWidget {
  final Model model;
  final List<String> schoolIDs;
  final List<String> keywords;
  const PossibleMajors(
      {Key? key, required this.schoolIDs, required this.keywords, required this.model})
      : super(key: key);

  @override
  State<PossibleMajors> createState() =>
      _PossibleMajorsState(schoolIDs, keywords, model);
}

class _PossibleMajorsState extends State<PossibleMajors> {
  Model model;
  List<String> schoolIDs;
  List<String> keywords;
  late List<String> possibleMajors = [];

  _PossibleMajorsState(this.schoolIDs, this.keywords, this.model) {
    setPossibleMajors();
  }

  Future<void> setPossibleMajors() async {
    possibleMajors = await model.getPossibleMajors(schoolIDs, keywords);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: KAppBar(title: "Possible Majors", model: model),
        body: SingleChildScrollView(
            child: Center(
              child: Column(children: [
          const SizedBox(height: 20),
          Container(
              // adjust container width/height to fit box better
              width: 380,
              height: 550,
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
                  'Possible Majors',
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
                  child: possibleMajors.isEmpty ?
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text("Sorry, there were no relevant degrees for the "
                        "colleges and majors/keywords you gave.\n\n"
                        "Please try a new combination of colleges and majors"
                        " or use more generalized majors/keywords.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 20)),
                  ) :
                  ListView.builder(
                    itemCount: possibleMajors.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Transform.translate(
                        // adjust offset to change the list tile left to right spacing
                        offset: const Offset(10, 0),
                        child: ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -3),
                          title: Text(
                            '${index + 1}. ${possibleMajors[index]}',
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
        ]),),),
      drawer: getKNavBar(model),
    );
  }
}
