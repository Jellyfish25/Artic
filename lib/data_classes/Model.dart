import 'dart:collection';
import 'package:artic/data_classes/User.dart';
import 'package:flutter/material.dart';
import '../data_classes/DatabaseHandler.dart';
import 'package:sqflite/sqflite.dart';

import 'Plan.dart';

class Model {
  late User _currentUser;
  late Database _db;
  late DatabaseHandler _handler;

  Model() {
    _currentUser =
        User("default email", "default fullName", "default password", -1);
    _handler = DatabaseHandler();
    setDB();
  }

  Future<void> setDB() async {
    _db = await _handler.initializeDB();
  }

  /// Course History Methods
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

  Future<List<String>> getEquivalentCourseHistory(String destSchoolID) async {
    List<Map<String, Object?>> dbCourseHistory = await _db.rawQuery(
        "SELECT school_id, course_prefix, course_num FROM has_taken WHERE email = \'${_currentUser.getEmail()}\'");
    List<Object?> prefixList =
        dbCourseHistory.map((e) => e["course_prefix"]).toList();
    List<Object?> numList =
        dbCourseHistory.map((e) => e["course_num"]).toList();
    List<Object?> schoolIDList =
        dbCourseHistory.map((e) => e["school_id"]).toList();
    List<String> courseHistory = [];
    for (int i = 0; i < numList.length; i++) {
      String course = prefixList[i] as String;
      course += "-";
      course += numList[i] as String;
      courseHistory.add(course);
    }
    Map<String, List<String>> eqCourseMap = {};
    for (int i = 0; i < numList.length; i++) {
      if (schoolIDList[i] as String != destSchoolID) {
        List<Map<String, Object?>> eqCourseObj = await _db.rawQuery(
            "SELECT (dest_course_prefix || \"-\" || dest_course_num) AS dest_course, and_req FROM is_equivalent_to WHERE src_school_id = \'${schoolIDList[i]}\' "
            "AND dest_school_id = \'$destSchoolID\' "
            "AND (src_course_prefix || \"-\" || src_course_num) = '${courseHistory[i]}'");
        print(await _db.rawQuery(
            "SELECT (dest_course_prefix || \"-\" || dest_course_num) AS dest_course, and_req FROM is_equivalent_to WHERE src_school_id = \'${schoolIDList[i]}\' "
            "AND dest_school_id = \'$destSchoolID\' "
            "AND (src_course_prefix || \"-\" || src_course_num) = '${courseHistory[i]}'"));
        List<Object?> eqCourse =
            eqCourseObj.map((e) => e["dest_course"]).toList();
        List<Object?> andReq = eqCourseObj.map((e) => e["and_req"]).toList();
        if (eqCourse.isNotEmpty && (andReq.isEmpty || "${andReq[0]}" == "")) {
          courseHistory[i] = eqCourse[0] as String;
        } else if (eqCourse.isNotEmpty) {
          if (!eqCourseMap.containsKey(eqCourse[0] as String)) {
            eqCourseMap[eqCourse[0] as String] = [];
          }
          eqCourseMap[eqCourse[0] as String]?.add(courseHistory[i]);
          if (eqCourseMap[eqCourse[0]]?.length as int > 1) {
            courseHistory[i] = eqCourse[0] as String;
          } else {
            courseHistory[i] = "";
          }
        } else {
          courseHistory[i] = "";
        }
      }
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

  /// User methods
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
    _currentUser = emailList.map((e) => User.fromMap(e)).toList()[0];
    print(_currentUser.toString());
  }

  void addUser(String email, String fullName, String password) {
    _handler.insertUser(User(email, fullName, password, -1), _db);
  }

  Future<bool> emailIsAvailable(String email) async {
    List<Map> emailList =
        await _db.rawQuery("SELECT * FROM user WHERE email = '$email'");
    return emailList.isEmpty;
  }

  /// School methods
  Future<List<DropdownMenuItem<String>>> getSchoolNames() async {
    print("starting getSchoolNames()\n");
    List<Map<String, Object?>> schoolList =
        await _db.rawQuery("SELECT school_id, s_name FROM school");
    List<Object?> schoolIDs = schoolList.map((e) => e["school_id"]).toList();
    List<Object?> schoolNames = schoolList.map((e) => e["s_name"]).toList();
    List<DropdownMenuItem<String>> colleges = [];
    for (int i = 0; i < schoolIDs.length; i++) {
      String schoolID = schoolIDs[i] as String;
      String schoolName = schoolNames[i] as String;
      colleges.add(DropdownMenuItem(value: schoolID, child: Text(schoolName)));
    }
    print("End of getSchoolNames()\n");
    return colleges;
  }

  Future<List<DropdownMenuItem<String>>> getSchoolDegrees(String schoolID) async {
    print("starting getSchoolDegrees()\n");
    List<Map<String, Object?>> schoolDegreeList = await _db.rawQuery(
        "SELECT deg_name FROM degree JOIN school ON degree.school_id=school.school_id WHERE degree.school_id = '$schoolID'");
    List<Object?> list = schoolDegreeList.map((e) => e["deg_name"]).toList();
    List<DropdownMenuItem<String>> degrees = [];
    for (Object? o in list) {
      String name = o as String;
      degrees.add(DropdownMenuItem(value: name, child: Text(name)));
    }
    print("End of getSchoolDegrees()\n");
    return degrees;
  }

  Future<List<DropdownMenuItem<String>>> getCourses(String collegeID) async {
    print("starting getCourses()\n");
    List<Map<String, Object?>> courseObjects = await _db.rawQuery(
        "SELECT course.school_id, course_prefix, course_num FROM school JOIN course ON school.school_id=course.school_id WHERE course.school_id = \'$collegeID\'");
    List<Object?> prefixList =
        courseObjects.map((e) => e["course_prefix"]).toList();
    List<Object?> numList = courseObjects.map((e) => e["course_num"]).toList();
    List<DropdownMenuItem<String>> courseDropdownMenuItems = [];
    for (int i = 0; i < numList.length; i++) {
      String course = prefixList[i] as String;
      course += "-";
      course += numList[i] as String;
      print(course);
      courseDropdownMenuItems
          .add(DropdownMenuItem(value: course, child: Text(course)));
    }
    print("End of getCourses()\n");
    return courseDropdownMenuItems;
  }

  /// Plans methods
  Future<List<Plan>> getPlans() async {
    final List<Map<String, Object?>> planObjects = await _db.rawQuery(
        "SELECT * FROM plan WHERE owner = '${_currentUser.getEmail()}'");
    return planObjects.map((e) => Plan.fromMap(e)).toList();
  }

  Future<void> addPlan(Plan plan) async {
    print("BEFORE addPlan\n");
    print(await _db.rawQuery(
        "SELECT * FROM plan WHERE owner = '${_currentUser.getEmail()}'"));
    await _db.rawQuery(
        "INSERT INTO plan(date_created, owner, school_id, deg_name) VALUES ('${plan.getDateCreated()}', '${plan.getOwner()}', '${plan.getSchoolID()}', '${plan.getDegName()}')");
    print("AFTER addPlan\n");
    print(await _db.rawQuery(
        "SELECT * FROM plan WHERE owner = '${_currentUser.getEmail()}'"));
  }

  Future<void> removePlan(Plan plan) async {
    print("BEFORE removePlan\n");
    print(await _db.rawQuery(
        "SELECT * FROM plan WHERE owner = '${_currentUser.getEmail()}' AND plan_id = '${plan.getPlanID()}'"));
    await _db.rawQuery(
        "DELETE FROM plan WHERE owner = '${_currentUser.getEmail()}' AND plan_id = '${plan.getPlanID()}'");
    print("AFTER removePlan\n");
    print(await _db.rawQuery(
        "SELECT * FROM plan WHERE owner = '${_currentUser.getEmail()}'"));
  }

  Future<void> setFavePlan(int planID) async {
    await _db.rawQuery(
        "UPDATE user SET fave_plan=$planID WHERE email='${_currentUser.getEmail()}'");
    _currentUser.setFavePlan(planID);
  }

  Future<Plan> getFavePlan() async {
    List<Map<String, Object?>> favePlanQuery = await _db.rawQuery(
        "SELECT plan_id, date_Created, owner, deg_name, school_id FROM plan JOIN user ON owner=email WHERE owner = '${_currentUser.getEmail()}' AND plan_id = fave_plan");
    if (favePlanQuery.isNotEmpty) {
      return favePlanQuery.map((e) => Plan.fromMap(e)).toList()[0];
    }
    return Plan(-1, '', '', '', '');
  }

  Future<int> getFavePlanIndex() async {
    List<Map<String, Object?>> userPlanQuery =
        await _db.rawQuery("SELECT * FROM plan JOIN user ON owner=email "
            "WHERE owner = '${_currentUser.getEmail()}'");
    List<Object?> planIDList = userPlanQuery.map((e) => e["plan_id"]).toList();
    int favePLanIndex = planIDList.indexOf(_currentUser.getFavePlan());
    return favePLanIndex;
  }

  Future<String> getPlanSchoolName(Plan plan) async {
    List<Map<String, Object?>> planSchoolNameMap = await _db.rawQuery(
        "SELECT s_name FROM school WHERE school_id = \'${plan.getSchoolID()}\'");
    List<Object?> planSchoolNameList =
        planSchoolNameMap.map((e) => e["s_name"]).toList();
    return planSchoolNameList[0] as String;
  }

  Future<List<String>> getReqs(Plan plan) async {
    final List<Map<String, Object?>> reqObjects = await _db.rawQuery(
        "SELECT * FROM requires WHERE school_id = '${plan.getSchoolID()}' AND deg_name = '${plan.getDegName()}'");
    List<Object?> prefixList =
    reqObjects.map((e) => e["course_prefix"]).toList();
    List<Object?> numList = reqObjects.map((e) => e["course_num"]).toList();
    List<Object?> categoryList = reqObjects.map((e) => e["category"]).toList();
    List<Object?> catReqList = reqObjects.map((e) => e["cat_req"]).toList();
    List<String> courseList = [];
    for (int i = 0; i < numList.length; i++) {
      String course = prefixList[i] as String;
      course += "-";
      course += numList[i] as String;
      courseList.add(course);
    }
    HashMap<String, int> map = HashMap();
    List<String> reqs = [];
    for (int i = 0; i < numList.length; i++) {
      if ((categoryList[i] as String).isEmpty) {
        reqs.add(courseList[i]);
      } else {
        String category = categoryList[i] as String;
        if (!map.containsKey(category)) {
          map[category] = (catReqList[i] as int) - 1;
          reqs.add(category);
        } else if (map[category]! > 0) {
          map[category] = (map[category]!) - 1;
          reqs.add(category);
        }
      }
    }
    return reqs;
  }

  Future<List<String>> getReqNeeded(Plan plan) async {
    final List<Map<String, Object?>> reqObjects = await _db.rawQuery(
        "SELECT * FROM requires WHERE school_id = '${plan.getSchoolID()}' AND deg_name = '${plan.getDegName()}'");
    List<Object?> prefixList =
        reqObjects.map((e) => e["course_prefix"]).toList();
    List<Object?> numList = reqObjects.map((e) => e["course_num"]).toList();
    List<Object?> categoryList = reqObjects.map((e) => e["category"]).toList();
    List<Object?> catReqList = reqObjects.map((e) => e["cat_req"]).toList();
    List<String> courseList = [];
    for (int i = 0; i < numList.length; i++) {
      String course = prefixList[i] as String;
      course += "-";
      course += numList[i] as String;
      courseList.add(course);
    }
    HashMap<String, int> map = HashMap();
    List<String> reqNeeded = [];
    for (int i = 0; i < numList.length; i++) {
      if ((categoryList[i] as String).isEmpty) {
        reqNeeded.add(courseList[i]);
      } else {
        String category = categoryList[i] as String;
        if (!map.containsKey(category)) {
          map[category] = (catReqList[i] as int) - 1;
          reqNeeded.add(category);
        } else if (map[category]! > 0) {
          map[category] = (map[category]!) - 1;
          reqNeeded.add(category);
        }
      }
    }
    List<String> courseHist =
        await getEquivalentCourseHistory(plan.getSchoolID());
    for (String course in courseHist) {
      if (reqNeeded.contains(course)) {
        reqNeeded.remove(course);
      } else if (courseList.contains(course) &&
          reqNeeded
              .contains(categoryList[courseList.indexOf(course)] as String)) {
        reqNeeded.remove(categoryList[courseList.indexOf(course)] as String);
      }
    }
    return reqNeeded;
  }

  Future<List<String>> getReqMet(Plan plan) async {
    final List<Map<String, Object?>> reqObjects = await _db.rawQuery(
        "SELECT * FROM requires WHERE school_id = '${plan.getSchoolID()}' AND deg_name = '${plan.getDegName()}'");
    List<Object?> prefixList =
        reqObjects.map((e) => e["course_prefix"]).toList();
    List<Object?> numList = reqObjects.map((e) => e["course_num"]).toList();
    List<String> allReqs = [];
    for (int i = 0; i < numList.length; i++) {
      String course = "${prefixList[i] as String}-${numList[i] as String}";
      allReqs.add(course);
    }
    List<String> courseHist = await getCourseHistory();
    List<String> courseEquivHist =
        await getEquivalentCourseHistory(plan.getSchoolID());
    List<String> reqMet = [];
    for (int i = 0; i < courseHist.length; i++) {
      if (allReqs.contains(courseEquivHist[i])) {
        // TODO: make it so this works for AND reqs (multiple courses)
        reqMet.add(courseEquivHist[i]);
      }
    }
    return reqMet;
  }

  /// Explore Majors methods
  Future<List<String>> getPossibleMajors(List<String> schoolIDs, List<String> keywords) async {
    print(schoolIDs);
    print(keywords);
    List<String> majors = [];
    for (String schoolID in schoolIDs) {
      for (String keyword in keywords) {
        List<Map<String, Object?>> objects = await _db.rawQuery(
            "SELECT (s_name || \"-\" || deg_name) AS major FROM degree JOIN school ON degree.school_id=school.school_id WHERE degree.school_id = '$schoolID' AND deg_name LIKE '%$keyword%'");
        List<Object?> majorObjs = objects.map((e) => e["major"]).toList();
        for (Object? o in majorObjs) {
          majors.add(o as String);
        }
      }
    }
    return majors;
  }
}
