class Degree {
  String school_id;
  String deg_name;
  String deg_type;
  double total_units;

  Degree(this.school_id, this.deg_name, this.deg_type, this.total_units);

  String getDegID() {
    return school_id;
  }
  String getMajor() {
    return deg_name;
  }
  String getDegType() {
    return deg_type;
  }
  double getTotalUnits() {
    return total_units;
  }
  void setDegID(String id) {
    school_id = id;
  }
  void setMajor(String maj) {
    deg_name = maj;
  }
  void setDegType(String type) {
    deg_type = type;
  }
  void setTotalUnits(double units) {
    total_units = units;
  }

  Degree.fromMap(Map<String, dynamic> res)
    : school_id = res["deg_id"],
      deg_name = res["major"],
      deg_type = res["deg_type"],
      total_units = res["total_units"];

  Map<String, Object?> toMap() {
      return {'deg_id': school_id,
              'major': deg_name,
              'deg_type': deg_type,
              'total_units': total_units};
  }

  @override
  String toString() {
    return 'Degree{deg_id: $school_id, major: $deg_name, deg_type: $deg_type, total_units: $total_units}';
  }
}