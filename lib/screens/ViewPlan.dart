import 'package:artic/data_classes/Model.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class ViewPlan extends StatefulWidget {
  final Model model;
  static const String id = 'ViewPlan';
  const ViewPlan({Key? key, required this.model}) : super(key: key);

  @override
  State<ViewPlan> createState() => _ViewPlanState(model);
}

class _ViewPlanState extends State<ViewPlan> {
  Model model;

  _ViewPlanState(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(title: 'Plan Name', model: model),
      body: Column(
        children: [],
      ),
      drawer: getKNavBar(model),
    );
  }
}
