import 'package:artic/components/rounded_button.dart';
import 'package:artic/constants.dart';
import 'package:artic/data_classes/Model.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:search_choices/search_choices.dart';
import 'package:textfield_tags/textfield_tags.dart';
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
  TextfieldTagsController _controller = TextfieldTagsController();

  // Tester data for searchable dropdown
  List<int> selectedColleges = [];
  late List<DropdownMenuItem> colleges = [];

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

  _ExploreMajorsState(this.model) {
    setColleges();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> setColleges() async {
    colleges = await model.getSchoolNames();
    setState(() {});
  }

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
                        ? 'Save ${selectedColleges.length} College(s)'
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
                TextFieldTags(
                  textfieldTagsController: _controller,
                  initialTags: const [
                    'Software Engineering',
                    'Computer Engineering',
                  ],
                  textSeparators: const [','],
                  letterCase: LetterCase.normal,
                  validator: (String tag) {
                    if (tag == 'php') {
                      return 'No, please just no';
                    } else if (_controller.getTags!.contains(tag)) {
                      return 'Major is already included';
                    }
                    return null;
                  },
                  inputfieldBuilder:
                      (context, tec, fn, error, onChanged, onSubmitted) {
                    return ((context, sc, tags, onTagDelete) {
                      return TextField(
                        controller: tec,
                        focusNode: fn,
                        decoration: InputDecoration(
                          isDense: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF1375CF),
                              width: 3.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF1375CF),
                              width: 3.0,
                            ),
                          ),
                          hintText: _controller.hasTags
                              ? ''
                              : "Type any then a comma",
                          errorText: error,
                          prefixIconConstraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width),
                          prefixIcon: tags.isNotEmpty
                              ? SingleChildScrollView(
                                  controller: sc,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: tags.map((String tag) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                        color: Color(0xFF1375CF),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Text(
                                              tag,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onTap: () {
                                              print("$tag selected");
                                            },
                                          ),
                                          const SizedBox(width: 4.0),
                                          InkWell(
                                            child: const Icon(
                                              Icons.cancel,
                                              size: 14.0,
                                              color: Color.fromARGB(
                                                  255, 233, 233, 233),
                                            ),
                                            onTap: () {
                                              onTagDelete(tag);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()),
                                )
                              : null,
                        ),
                        onChanged: onChanged,
                        onSubmitted: onSubmitted,
                      );
                    });
                  },
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
