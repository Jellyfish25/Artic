class Degree {

  String schoolID;
  String degName;
  String degType;
  double totalUnits;

  Degree(this.schoolID, this.degName, this.degType, this.totalUnits);

  String getDegID() {
    return schoolID;
  }
  String getMajor() {
    return degName;
  }
  String getDegType() {
    return degType;
  }
  double getTotalUnits() {
    return totalUnits;
  }
  void setDegID(String id) {
    schoolID = id;
  }
  void setMajor(String maj) {
    degName = maj;
  }
  void setDegType(String type) {
    degType = type;
  }
  void setTotalUnits(double units) {
    totalUnits = units;
  }

  Degree.fromMap(Map<String, dynamic> res)
    : schoolID = res["deg_id"],
      degName = res["major"],
      degType = res["deg_type"],
      totalUnits = res["total_units"];

  Map<String, Object?> toMap() {
      return {'deg_id': schoolID,
              'major': degName,
              'deg_type': degType,
              'total_units': totalUnits};
  }

  @override
  String toString() {
    return 'Degree{deg_id: $schoolID, major: $degName, deg_type: $degType, total_units: $totalUnits}';
  }
}