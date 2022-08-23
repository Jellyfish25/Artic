import 'package:flutter/material.dart';
import '../constants.dart';

class ViewPlan extends StatefulWidget {
  static const String id = 'ViewPlan';
  const ViewPlan({Key? key}) : super(key: key);

  @override
  State<ViewPlan> createState() => _ViewPlanState();
}

class _ViewPlanState extends State<ViewPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KAppBar(title: 'Plan Name'),
      body: Column(
        children: [],
      ),
      drawer: kNavBar,
    );
  }
}
