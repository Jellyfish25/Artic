import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../data_classes/Model.dart';
import '../data_classes/Plan.dart';
import 'CreatePlan.dart';
import 'ViewPlan.dart';

class MyPlans extends StatefulWidget {
  final Model model;
  static const String id = 'myplans';
  const MyPlans({Key? key, required this.model}) : super(key: key);

  @override
  State<MyPlans> createState() => _MyPlansState(model);
}

class _MyPlansState extends State<MyPlans> {
  Model model;
  late List<Plan> plans = [];
  late List<String> planSchool = [];
  late int favoriteIndex;

  int planIndex = -1;
  String favoritePlan = '';

  _MyPlansState(this.model) {
    setData();
  }
  Future<void> setData() async {
    plans = await model.getPlans();
    for (Plan p in plans) {
      print("Plan: ${p.toString()}");
      planSchool.add(await model.getPlanSchoolName(p));
    }

    favoriteIndex = await model.getFavePlanIndex();
    print("FAVE INDEX: $favoriteIndex");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int plansLength = plans.length;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: KAppBar(title: "My Plans", model: model),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: MediaQuery.of(context).size.width + 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFB0E8FA),
                border: Border.all(
                  width: 3,
                  color: const Color(0xFF2194D2),
                ),
              ),
              child: plans.isEmpty
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Tap \"CREATE PLAN\" to generate a plan",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: plansLength,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.transparent,
                          child: ListTile(
                            onTap: () {
                              print(plans[index]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewPlan(
                                          model: model, plan: plans[index])));
                            },
                            leading: IconButton(
                              color: Colors.black,
                              onPressed: () {
                                if (favoriteIndex == index) {
                                  favoriteIndex = -1;
                                  favoritePlan = '';
                                  model.setFavePlan(-1);
                                } else {
                                  favoriteIndex = index;
                                  favoritePlan = plans[index].getDegName();
                                  model.setFavePlan(plans[index].getPlanID());
                                }
                                print('favorite plan: $favoritePlan');
                                print('favorite index: $favoriteIndex');
                                setState(() {});
                              },
                              icon: favoriteIndex == index
                                  ? const Icon(Icons.star,
                                      color: Colors.yellow, size: 30)
                                  : const Icon(Icons.star_border,
                                      //either make it gray, light gray, or white
                                      color: Color(0xD9EEEEEE),
                                      size: 30),
                            ),
                            title: Transform.translate(
                              // adjust offset to change the icon to text spacing
                              offset: const Offset(0, 0),
                              child: Text(
                                '${planSchool[index]} - ${plans[index].getDegName()}',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            trailing: IconButton(
                              //when pressed, delete from list
                              onPressed: () {
                                setState(() {
                                  //print(plans[index]);
                                  //print("removed list");
                                  // implement removePlan in model
                                  model.removePlan(plans[index]);
                                  plans.removeAt(index);
                                  if (index < favoriteIndex) {
                                    favoriteIndex--;
                                  } else if (index == favoriteIndex) {
                                    favoriteIndex = -1;
                                  }
                                });
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 10,
                  color: const Color(0xff1375CF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0)),
                  onPressed: () {
                    Navigator.pushNamed(context, CreatePlan.id);
                  },
                  child: Text(
                    'CREATE PLAN',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
      drawer: getKNavBar(model),
    );
  }
}
