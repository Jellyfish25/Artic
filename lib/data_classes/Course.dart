/// Class that holds course data.
/// Note: This class and its methods do not validate data before initializing
/// or updating a Course's information. The classes that use Course will be
/// responsible for this.
class Course {
  String institution_code;
  String course_prefix;
  String course_number;
  String begin_term;
  String end_term;
  String course_title;
  double course_units_min;
  double course_units_max;
  String unit_type;

  /// Constructs a Course.
  Course(this.institution_code, this.course_prefix, this.course_number, this.begin_term, this.end_term, this.course_title, this.course_units_min, this.course_units_max, this.unit_type);

  String getInstitutionCode() {
    return institution_code;
  }
  String getCourseID() {
    return course_prefix + course_number;
  }
  String getBeginTerm() {
    return begin_term;
  }
  String getEndTerm() {
    return end_term;
  }
  String getCourseTitle() {
    return course_title;
  }
  double getCourseUnitsMin() {
    return course_units_min;
  }
  double getCourseUnitsMax() {
    return course_units_max;
  }
  String getUnitType() {
    return unit_type;
  }
  void setInstitutionCode(String code) {
    institution_code = code;
  }

  void setCourseID(String coursePrefix, String courseNumber) {
    course_prefix = coursePrefix;
    course_number = courseNumber;
  }
  void setBeginTerm(String term) {
    begin_term = term;
  }
  void setEndTerm(String term) {
    end_term = term;
  }
  void setCourseTitle(String title) {
    course_title = title;
  }
  void setCourseUnitsMin(double min) {
    course_units_min = min;
  }
  void setCourseUnitsMax(double max) {
    course_units_max = max;
  }
  void setUnitType(String type) {
    unit_type = type;
  }

  Course.fromMap(Map<String, dynamic> res)
      : institution_code = res["institution_code"],
        course_prefix = res["course_prefix"],
        course_number = res["course_number"],
        begin_term = res["begin_term"],
        end_term = res["end_term"],
        course_title = res["course_title"],
        course_units_min = res["course_units_min"],
        course_units_max = res["course_units_max"],
        unit_type = res["unit_type"];

  Map<String, Object?> toMap() {
    return {'institution_code': institution_code,
            'course_prefix': course_prefix,
            'course_number': course_number,
            'begin_term': begin_term,
            'end_term': end_term,
            'course_title': course_title,
            'course_units_min': course_units_min,
            'course_units_max': course_units_max,
            'unit_type': unit_type};
  }

  @override
  String toString() {
    return 'Course{institution_code: $institution_code, '
        'course_ID: $course_prefix$course_number, '
        'begin_term: $begin_term, '
        'end_term: $end_term, '
        'course_title: $course_title, '
        'course_units_min: $course_units_min, '
        'course_units_max: $course_units_max, '
        'unit_type: $unit_type}';
  }
}
