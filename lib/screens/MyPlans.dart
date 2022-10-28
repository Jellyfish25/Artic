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
  int planIndex = -1;
  int favoriteIndex = -1;
  String favoritePlan = '';

  _MyPlansState(this.model) {
    setPlans();
  }
  Future<void> setPlans() async {
    plans = await model.getPlans();
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
              child: ListView.builder(
                itemCount: plansLength,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.transparent,

                    //******************* Single tap to favorite (single star)
                    // child: Transform.translate(
                    //   // adjust offset to change the list tile left to right spacing
                    //   offset: const Offset(25, 0),
                    //   child: ListTile(
                    //     onTap: () {
                    //       setState(() {
                    //         planIndex = index;
                    //         favoritePlan = plans[index];
                    //       });
                    //       print('Selected Item index at: $favoritePlan');
                    //     },
                    //     leading: Visibility(
                    //       visible: planIndex == index,
                    //       child: const Icon(
                    //         Icons.star,
                    //         size: 40,
                    //         color: Colors.black,
                    //       ),
                    //     ),

                    //***************** One tap to favorite, one tap to edit
                    child: ListTile(
                      onTap: () {
                        print(plans[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewPlan(model: model, plan: plans[index])));
                      },
                      leading: IconButton(
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            favoriteIndex = index;
                            favoritePlan = plans[index].getDegName();
                            print('favorite plan: $favoritePlan');
                          });
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
                          '${model.getPlanSchoolName(plans[index])} - ${plans[index].getDegName()}',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 24,
                          ),
                        ),
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
