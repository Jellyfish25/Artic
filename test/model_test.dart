// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:artic/data_classes/DatabaseHandler.dart';
import 'package:artic/data_classes/Model.dart';
import 'package:artic/data_classes/Plan.dart';
import 'package:artic/data_classes/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:collection/collection.dart';

/*
To begin testing:
1. Start android emulator
2. Type the following command in terminal: flutter run test/model_test.dart
3. Helpful commands while running:
    shift + R: to to reload tests
    c: clear terminal
    q: to quit
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DatabaseHandler handler = DatabaseHandler();
  // Database db = await handler.initializeDB();
  // handler.insertUser(User("email1@email.com", "user1", "password1", -1), db);
  // handler.insertUser(User("email2@email.com", "user2", "password2", -1), db);
  // handler.insertUser(User("email3@email.com", "user3", "password3", -1), db);
  // Model model = Model();

  // variables need to be late (to be initialized then used later on)
  DatabaseHandler handler = DatabaseHandler();
  Model model = Model();
  Database db = await handler.initializeDB();
  DateTime today = DateTime.now();
  // setUpAll() is a function that runs once before all the tests run. You can think of it as the initState() method.
  setUpAll() async {
    await handler.deleteUser("email1@email.com", db);
    await handler.deleteUser("email2@email.com", db);
    await handler.deleteUser("email3@email.com", db);
    await handler.insertUser(
        User("email1@email.com", "user1", "password1", -1, "trumpet1"), db);
    await handler.insertUser(
        User("email2@email.com", "user2", "password2", -1, "trumpet2"), db);
    await handler.insertUser(
        User("email3@email.com", "user3", "password3", -1, "trumpet3"), db);
    await model.removeAllPlans();
  }

  //await setUpAll();

  // EXAMPLE OF TEST CASE:
  /*
      test('value should be incremented', () {
      final counter = Counter();
      counter.increment();
      expect(counter.value, 1);
    });
   */

  // if model needs to be updated, do it inside group (not inside test)
  group('getCourseHistory tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getEquivalentCourseHistory tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('userIsValid tests', () {
    test(
        'User with a registered email and its associated password should be valid.',
        () async {
      await setUpAll();
      expect(await model.userIsValid("email1@email.com", "password1"), true);
    });
    test(
        'User with a registered email but the wrong password should not be valid.',
        () async {
      await setUpAll();
      expect(await model.userIsValid("email3@email.com", "password3!"), false);
    });
    test(
        'User without a registered email but with a password associated with a registered email should not be valid.',
        () async {
      await setUpAll();
      expect(await model.userIsValid("email3@email.com!", "password3"), false);
    });
    test(
        'User without a registered email or a correct password should not be valid.',
        () async {
      await setUpAll();
      expect(await model.userIsValid("email3@email.com!", "password3!"), false);
    });
  });
  group('checkSecurityAnswer tests', () {
    model.setCurrentUser("email1@email.com");
    test(
        'A securityAnswer that equals the current user\'s security answer should pass.',
        () async {
      await setUpAll();
      expect(model.checkSecurityAnswer("trumpet1"), true);
    });
    test(
        'A securityAnswer that DNE the current user\'s security answer shouldn\'t pass.',
        () async {
      await setUpAll();
      expect(model.checkSecurityAnswer("trumpet2"), false);
    });
  });
  group('emailIsAvailable tests', () {
    test('An email not already in the database should be available', () async {
      await setUpAll();
      expect(await model.emailIsAvailable("email4@email.com"), true);
    });
    test('An email already in the database should not be available.', () async {
      await setUpAll();
      expect(await model.emailIsAvailable("email1@email.com"), false);
    });
  });
  group('getPlans tests', () {
    model.setCurrentUser("email1@email.com");
    test('Testing without any plans saved.', () async {
      List<Plan> plans = await model.getPlans();
      expect(plans, []);
    });
    test('Testing with three existing plans.', () async {
      Plan plan1 = Plan(1, "${today.year}-${today.month}-${today.day}",
          "email1@email.com", "school", "deg1");
      Plan plan2 = Plan(2, "${today.year}-${today.month}-${today.day}",
          "email1@email.com", "school", "deg2");
      Plan plan3 = Plan(3, "${today.year}-${today.month}-${today.day}",
          "email1@email.com", "school", "deg3");
      List<Plan> expectedPlans = <Plan>[];
      expectedPlans.add(plan1);
      expectedPlans.add(plan2);
      expectedPlans.add(plan3);

      await model.addPlan(plan1);
      await model.addPlan(plan2);
      await model.addPlan(plan3);
      List<Plan> plans = await model.getPlans();
      await model.removeAllPlans();

      expect(plans[0].planID, expectedPlans[0].planID);
      expect(plans[0].dateCreated, expectedPlans[0].dateCreated);
      expect(plans[0].owner, expectedPlans[0].owner);
      expect(plans[0].schoolID, expectedPlans[0].schoolID);
      expect(plans[0].degName, expectedPlans[0].degName);

      expect(plans[1].planID, expectedPlans[1].planID);
      expect(plans[1].dateCreated, expectedPlans[1].dateCreated);
      expect(plans[1].owner, expectedPlans[1].owner);
      expect(plans[1].schoolID, expectedPlans[1].schoolID);
      expect(plans[1].degName, expectedPlans[1].degName);

      expect(plans[2].planID, expectedPlans[2].planID);
      expect(plans[2].dateCreated, expectedPlans[2].dateCreated);
      expect(plans[2].owner, expectedPlans[2].owner);
      expect(plans[2].schoolID, expectedPlans[2].schoolID);
      expect(plans[2].degName, expectedPlans[2].degName);
    });
    // //test('', () {});
  });
  group('getFavePlan tests', () {
    model.setCurrentUser("email1@email.com");
    Plan plan1 = Plan(1, "${today.year}-${today.month}-${today.day}",
        "email1@email.com", "school", "deg1");
    Plan plan2 = Plan(2, "${today.year}-${today.month}-${today.day}",
        "email1@email.com", "school", "deg2");
    Plan plan3 = Plan(3, "${today.year}-${today.month}-${today.day}",
        "email1@email.com", "school", "deg3");

    test('Testing with no favorite plans', () async {
      Plan favoritePlan = await model.getFavePlan();
      expect(favoritePlan.planID, -1);
      expect(favoritePlan.dateCreated, '');
      expect(favoritePlan.schoolID, '');
      expect(favoritePlan.degName, '');
    });
    test('Testing with one favorite plan', () async {
      await model.addPlan(plan1);
      await model.addPlan(plan2);
      await model.addPlan(plan3);
      await model.setFavePlan(1);
      Plan favoritePlan = await model.getFavePlan();
      await model.removeAllPlans();
      expect(favoritePlan.planID, plan1.planID);
      expect(favoritePlan.dateCreated, plan1.dateCreated);
      expect(favoritePlan.schoolID, plan1.schoolID);
      expect(favoritePlan.degName, plan1.degName);
    });
    //test('', () {});
  });
  group('getFavePlanIndex tests', () {
    model.setCurrentUser("email1@email.com");
    Plan plan1 = Plan(1, "${today.year}-${today.month}-${today.day}",
        "email1@email.com", "school", "deg1");
    Plan plan2 = Plan(2, "${today.year}-${today.month}-${today.day}",
        "email1@email.com", "school", "deg2");
    Plan plan3 = Plan(3, "${today.year}-${today.month}-${today.day}",
        "email1@email.com", "school", "deg3");

    test('Testing with no favorite plans', () async {
      expect(await model.getFavePlanIndex(), -1);
    });
    test('Testing with a valid favorite plan', () async {
      await model.addPlan(plan1);
      await model.addPlan(plan2);
      await model.addPlan(plan3);
      await model.setFavePlan(1);
      int planIndex = await model.getFavePlanIndex();
      await model.removePlan(plan1);
      await model.removePlan(plan2);
      await model.removePlan(plan3);
      expect(planIndex, 0);
    });
    //test('', () {});
  });
  group('getReqs tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getReqNeeded tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getReqMet tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getPossibleMajors tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  handler.deleteUser("email1@email.com", db);
  handler.deleteUser("email2@email.com", db);
  handler.deleteUser("email3@email.com", db);
}
