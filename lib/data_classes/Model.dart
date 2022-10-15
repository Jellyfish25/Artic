import 'package:artic/data_classes/User.dart';
import 'package:flutter/material.dart';
import '../data_classes/DatabaseHandler.dart';
import 'package:sqflite/sqflite.dart';

import 'Plan.dart';

class Model {
  late User _currentUser;
  late Database _db;
  late DatabaseHandler _handler;
  //late List<Plan> _planList;

  Model() {
    _currentUser =
        User("default email", "default fullName", "default password");
    _handler = DatabaseHandler();
    setDB();
  }
  Future<void> setDB() async {
    _db = await _handler.initializeDB();
  }

  Future<List<String>> getCourseHistory() async {
    List<Map<String, Object?>> dbCourseHistory = await _db.rawQuery(
        "SELECT course_prefix, course_num FROM has_taken WHERE email = \'${_currentUser.getEmail()}\'");
    List<Object?> prefixList =
        dbCourseHistory.map((e) => e["course_prefix"]).toList();
    List<Object?> numList =
        dbCourseHistory.map((e) => e["course_num"]).toList();

    List<String> courseHistory = [];

    for (int i = 0; i < numList.length; i++) {
      String course = prefixList[i] as String;
      course += "-";
      course += numList[i] as String;
      courseHistory.add(course);
    }
    return courseHistory;
  }

  Future<void> removeCourseFromHist(String course) async {
    print("BEFORE REMOVE CH: ");
    print(await _db.rawQuery(
        "SELECT * FROM has_taken WHERE email = '${_currentUser.getEmail()}'"));
    await _db.rawQuery(
        "DELETE FROM has_taken WHERE email = '${_currentUser.getEmail()}' AND (course_prefix || \"-\" || course_num) = '$course'");
    print("AFTER REMOVE CH: ");
    print(await _db.rawQuery(
        "SELECT * FROM has_taken WHERE email = '${_currentUser.getEmail()}'"));
  }

  Future<void> addCourseToHist(String courseSchoolID, String selectedCourse) async {
    print("BEFORE ADD CH: ");
    print(await _db.rawQuery(
        "SELECT * FROM has_taken WHERE email = '${_currentUser.getEmail()}'"));
    List<String> course = selectedCourse.split("-");
    await _db.rawQuery(
        "INSERT INTO has_taken (email, school_id, course_prefix, course_num) VALUES ('${_currentUser.getEmail()}', '$courseSchoolID', '${course[0]}', '${course[1]}')");
    print("AFTER ADD CH: ");
    print(await _db.rawQuery(
        "SELECT * FROM has_taken WHERE email = '${_currentUser.getEmail()}'"));
  }

  //User methods
  Future<bool> userIsValid(String email, String password) async {
    List<Map> emailList =
        await _db.rawQuery("SELECT * FROM user WHERE email = '$email'");
    if (emailList.isNotEmpty) {
      String dbPassword = emailList[0]["password"];
      print("userIsValid = true\n");
      return dbPassword == password;
    }
    print("userIsValid = false\n");
    return false;
  }

  String getCurrentUser() {
    return _currentUser.getEmail();
  }

  Future<void> setCurrentUser(String email) async {
    List<Map<String, Object?>> emailList =
        await _db.rawQuery("SELECT * FROM user WHERE email = '$email'");
    //List<Map<String, Object?>> courseTest = await _db.rawQuery("SELECT * FROM course WHERE course_title = 'Software Engineering I'");
    //print(courseTest[0]);
    _currentUser = emailList.map((e) => User.fromMap(e)).toList()[0];
    print(_currentUser.toString());
  }

  void addUser(String email, String fullName, String password) {
    _handler.insertUser(User(email, fullName, password), _db);
  }

  Future<bool> emailIsAvailable(String email) async {
    List<Map> emailList =
        await _db.rawQuery("SELECT * FROM user WHERE email = '$email'");
    return emailList.isEmpty;
  }
  //End of User methods

  //School methods
  Future<List<DropdownMenuItem<String>>> getSchoolNames() async {
    print("starting getSchoolNames()\n");
    List<Map<String, Object?>> schoolList = await _db.rawQuery("SELECT school_id, s_name FROM school");
    //print("contents of schoolNameList: $schoolNameList\n");
    List<Object?> schoolIDs = schoolList.map((e) => e["school_id"]).toList();
    List<Object?> schoolNames = schoolList.map((e) => e["s_name"]).toList();
    List<DropdownMenuItem<String>> colleges = [];
    // for (Object? o in list) {
    //   String name = o as String;
    //   colleges.add(DropdownMenuItem(value: name, child: Text(name))); //TODO: set value to schoolID
    // }
    for (int i = 0; i < schoolIDs.length; i++) {
      String schoolID = schoolIDs[i] as String;
      String schoolName = schoolNames[i] as String;
      colleges.add(DropdownMenuItem(value: schoolID, child: Text(schoolName)));
    }
    print("End of getSchoolNames()\n");
    return colleges;
  }

  Future<List<DropdownMenuItem<String>>> getSchoolDegrees(
      String schoolID) async {
    print("starting getSchoolDegrees()\n");
    List<Map<String, Object?>> schoolDegreeList = await _db.rawQuery(
        "SELECT deg_name FROM degree JOIN school ON degree.school_id=school.school_id WHERE degree.school_id = '$schoolID'");
    //print("contents of schoolNameList: $schoolNameList\n");
    List<Object?> list = schoolDegreeList.map((e) => e["deg_name"]).toList();
    List<DropdownMenuItem<String>> degrees = [];
    for (Object? o in list) {
      String name = o as String;
      degrees.add(DropdownMenuItem(value: name, child: Text(name)));
    }
    print("End of getSchoolDegrees()\n");
    return degrees;
  }

  Future<List<DropdownMenuItem<String>>> getCourses(
      String collegeID) async {
    print("starting getCourses()\n");
    List<Map<String, Object?>> courseObjects = await _db.rawQuery(
        "SELECT course.school_id, course_prefix, course_num FROM school JOIN course ON school.school_id=course.school_id WHERE course.school_id = \'$collegeID\'");
    List<Object?> prefixList = courseObjects.map((e) => e["course_prefix"]).toList();
    List<Object?> numList = courseObjects.map((e) => e["course_num"]).toList();
    //selectedCollegeID = courseObjects[0]['school_id'].toString();
    List<DropdownMenuItem<String>> courseDropdownMenuItems = [];
    for (int i = 0; i < numList.length; i++) {
      String course = prefixList[i] as String;
      course += "-";
      course += numList[i] as String;
      print(course);
      courseDropdownMenuItems.add(DropdownMenuItem(value: course, child: Text(course)));
    }
    print("End of getCourses()\n");
    return courseDropdownMenuItems;
  }
  //End of School methods

  //Plans methods

  Future<List<Plan>> getPlans() async {
    print("START OF getPlans");
    final List<Map<String, Object?>> planObjects = await _db.rawQuery("SELECT * FROM plan WHERE owner = '${_currentUser.getEmail()}'");
    print(await _db.rawQuery("SELECT * FROM plan WHERE owner = '${_currentUser.getEmail()}'"));
    print("END OF getPlans");
    return planObjects.map((e) => Plan.fromMap(e)).toList();
  }

  Future<void> addPlan(Plan plan) async {
    print("BEFORE addPlan\n");
    print(await _db.rawQuery("SELECT * FROM plan WHERE owner = '${_currentUser.getEmail()}'"));
    await _db.rawQuery("INSERT INTO plan(date_created, owner, school_id, deg_name) VALUES ('${plan.getDateCreated()}', '${plan.getOwner()}', '${plan.getSchoolID()}', '${plan.getDegName()}')");
    print("AFTER addPlan\n");
    print(await _db.rawQuery("SELECT * FROM plan WHERE owner = '${_currentUser.getEmail()}'"));
  }

  Future<List<String>> getReqNeeded(Plan plan) async {
    print("START OF getReqNeeded");
    final List<Map<String, Object?>> reqObjects = await _db.rawQuery("SELECT * FROM requires WHERE school_id = '${plan.getSchoolID()}' AND deg_name = '${plan.getDegName()}'");
    List<Object?> prefixList = reqObjects.map((e) => e["course_prefix"]).toList();
    List<Object?> numList = reqObjects.map((e) => e["course_num"]).toList();
    List<String> reqNeeded = [];
    for (int i = 0; i < numList.length; i++) {
      String course = prefixList[i] as String;
      course += "-";
      course += numList[i] as String;
      reqNeeded.add(course);
    }
    List<String> courseHist = await getCourseHistory();
    //TODO change getCourseHistory to return a List<Course>
    for (String course in courseHist) {
      if (reqNeeded.contains(course)) {
        reqNeeded.remove(course);
      }
    }
    print("END OF getReqNeeded");
    return reqNeeded;
  }

  Future<List<String>> getReqMet(Plan plan) async {
    print("START OF getReqMet");
    final List<Map<String, Object?>> reqObjects = await _db.rawQuery("SELECT * FROM requires WHERE school_id = '${plan.getSchoolID()}' AND deg_name = '${plan.getDegName()}'");
    List<Object?> prefixList = reqObjects.map((e) => e["course_prefix"]).toList();
    List<Object?> numList = reqObjects.map((e) => e["course_num"]).toList();
    List<String> allReqs = [];
    for (int i = 0; i < numList.length; i++) {
      String course = prefixList[i] as String;
      course += "-";
      course += numList[i] as String;
      allReqs.add(course);
    }
    List<String> courseHist = await getCourseHistory();
    List<String> reqMet = [];
    print("reqMet before removing non-relevant courses: $reqMet");
    for (String course in courseHist) {
      if (allReqs.contains(course)) {
        reqMet.add(course);
      }
    }
    print("reqMet after adding courses: $reqMet\nEND OF getReqMet");
    return reqMet;
  }


}
