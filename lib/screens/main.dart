import 'package:artic/data_classes/Model.dart';
import 'package:artic/screens/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/CourseHistory.dart';
import '../screens/CreatePlan.dart';
import '../screens/ForgotPassword.dart';
import '../screens/LoginScreen.dart';
import '../screens/MyPlans.dart';
import '../screens/Overview.dart';
import '../screens/SignupPage.dart';
import '../screens/WelcomeScreen.dart';
import '../screens/EditAccount.dart';
import '../screens/HowDoIUseThisApp.dart';

void main() => runApp(const Artic());

class Artic extends StatelessWidget {
  const Artic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Model model = Model();
    return GetMaterialApp(
      home: const WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        ForgotPassword.id: (context) => ForgotPassword(model: model),
        LoginScreen.id: (context) => LoginScreen(model: model),
        SignupScreen.id: (context) => SignupScreen(model: model),
        Overview.id: (context) => Overview(model: model),
        MyPlans.id: (context) => MyPlans(model: model),
        CourseHistory.id: (context) => CourseHistory(model: model),
        CreatePlan.id: (context) => CreatePlan(model: model),
        EditAcc.id: (context) => EditAcc(model: model),
        HowDoIUseThisApp.id: (context) => const HowDoIUseThisApp(),
      },
    );
  }
}
