class Degree {
  String degID;
  String major;
  String degType;
  double totalUnits;

  Degree(this.degID, this.major, this.degType, this.totalUnits);

  String getDegID() {
    return degID;
  }
  String getMajor() {
    return major;
  }
  String getDegType() {
    return degType;
  }
  double getTotalUnits() {
    return totalUnits;
  }
  void setDegID(String id) {
    degID = id;
  }
  void setMajor(String maj) {
    major = maj;
  }
  void setDegType(String type) {
    degType = type;
  }
  void setTotalUnits(double units) {
    totalUnits = units;
  }

  Degree.fromMap(Map<String, dynamic> res)
    : degID = res["deg_id"],
      major = res["major"],
      degType = res["deg_type"],
      totalUnits = res["total_units"];

  Map<String, Object?> toMap() {
      return {'deg_id': degID,
              'major': major,
              'deg_type': degType,
              'total_units': totalUnits};
  }

  @override
  String toString() {
    return 'Degree{deg_id: $degID, major: $major, deg_type: $degType, total_units: $totalUnits}';
  }
}