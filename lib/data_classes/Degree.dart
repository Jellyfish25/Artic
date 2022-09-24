class Degree {
  String deg_id;
  String major;
  String deg_type;
  double total_units;

  Degree(this.deg_id, this.major, this.deg_type, this.total_units);

  String getDegID() {
    return deg_id;
  }
  String getMajor() {
    return major;
  }
  String getDegType() {
    return deg_type;
  }
  double getTotalUnits() {
    return total_units;
  }
  void setDegID(String id) {
    deg_id = id;
  }
  void setMajor(String maj) {
    major = maj;
  }
  void setDegType(String type) {
    deg_type = type;
  }
  void setTotalUnits(double units) {
    total_units = units;
  }

  Degree.fromMap(Map<String, dynamic> res)
    : deg_id = res["deg_id"],
      major = res["major"],
      deg_type = res["deg_type"],
      total_units = res["total_units"];

  Map<String, Object?> toMap() {
      return {'deg_id': deg_id,
              'major': major,
              'deg_type': deg_type,
              'total_units': total_units};
  }

  @override
  String toString() {
    return 'Degree{deg_id: $deg_id, major: $major, deg_type: $deg_type, total_units: $total_units}';
  }
}