import 'package:artic/screens/CompareDegree.dart';
import 'package:artic/screens/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/ComparisonScreen.dart';
import '../screens/CourseHistory.dart';
import '../screens/CreatePlan.dart';
import '../screens/ForgotPassword.dart';
import '../screens/LoginScreen.dart';
import '../screens/MyPlans.dart';
import '../screens/Overview.dart';
import '../screens/SignupPage.dart';
import '../screens/ViewPlan.dart';
import '../screens/WelcomeScreen.dart';

void main() => runApp(const Artic());

class Artic extends StatelessWidget {
  const Artic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ForgotPassword.id: (context) => ForgotPassword(),
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        Overview.id: (context) => Overview(),
        MyPlans.id: (context) => MyPlans(),
        CompareDegree.id: (context) => CompareDegree(),
        ComparisonScreen.id: (context) => ComparisonScreen(),
        CourseHistory.id: (context) => CourseHistory(),
        CreatePlan.id: (context) => CreatePlan(),
        ViewPlan.id: (context) => ViewPlan(),
      },

      //home: HomePage(),
    );
  }
}
