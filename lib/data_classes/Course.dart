/// Class that holds course data.
/// Note: This class and its methods do not validate data before initializing
/// or updating a Course's information. The classes that use Course will be
/// responsible for this.
class Course {
  String institutionCode;
  String coursePrefix;
  String courseNumber;
  String beginTerm;
  String endTerm;
  String courseTitle;
  double courseUnitsMin;
  double courseUnitsMax;
  String unitType;

  /// Constructs a Course.
  Course(this.institutionCode, this.coursePrefix, this.courseNumber, this.beginTerm, this.endTerm, this.courseTitle, this.courseUnitsMin, this.courseUnitsMax, this.unitType);

  String getInstitutionCode() {
    return institutionCode;
  }
  String getCourseID() {
    return coursePrefix + courseNumber;
  }
  String getBeginTerm() {
    return beginTerm;
  }
  String getEndTerm() {
    return endTerm;
  }
  String getCourseTitle() {
    return courseTitle;
  }
  double getCourseUnitsMin() {
    return courseUnitsMin;
  }
  double getCourseUnitsMax() {
    return courseUnitsMax;
  }
  String getUnitType() {
    return unitType;
  }
  void setInstitutionCode(String code) {
    institutionCode = code;
  }

  void setCourseID(String coursePrefix, String courseNumber) {
    this.coursePrefix = coursePrefix;
    this.courseNumber = courseNumber;
  }
  void setBeginTerm(String term) {
    beginTerm = term;
  }
  void setEndTerm(String term) {
    endTerm = term;
  }
  void setCourseTitle(String title) {
    courseTitle = title;
  }
  void setCourseUnitsMin(double min) {
    courseUnitsMin = min;
  }
  void setCourseUnitsMax(double max) {
    courseUnitsMax = max;
  }
  void setUnitType(String type) {
    unitType = type;
  }

  Course.fromMap(Map<String, dynamic> res)
      : institutionCode = res["institution_code"],
        coursePrefix = res["course_prefix"],
        courseNumber = res["course_number"],
        beginTerm = res["begin_term"],
        endTerm = res["end_term"],
        courseTitle = res["course_title"],
        courseUnitsMin = res["course_units_min"],
        courseUnitsMax = res["course_units_max"],
        unitType = res["unit_type"];

  Map<String, Object?> toMap() {
    return {'institution_code': institutionCode,
            'course_prefix': coursePrefix,
            'course_number': courseNumber,
            'begin_term': beginTerm,
            'end_term': endTerm,
            'course_title': courseTitle,
            'course_units_min': courseUnitsMin,
            'course_units_max': courseUnitsMax,
            'unit_type': unitType};
  }

  @override
  String toString() {
    return 'Course{institutionCode: $institutionCode, '
        'courseID: $coursePrefix$courseNumber, '
        'beginTerm: $beginTerm, '
        'endTerm: $endTerm, '
        'courseTitle: $courseTitle, '
        'courseUnitsMin: $courseUnitsMin, '
        'courseUnitsMax: $courseUnitsMax, '
        'unitType: $unitType}';
  }
}
