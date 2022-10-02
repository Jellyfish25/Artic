class School {
  String schoolID;
  String sName;
  String location;
  String sType;

  School(this.schoolID, this.sName, this.location, this.sType);

  String getSchoolID() {
    return schoolID;
  }

  String getSType() => sType;

  void setSType(String value) {
    sType = value;
  }

  String getLocation() => location;

  void setLocation(String value) {
    location = value;
  }

  String getSName() => sName;

  void setSName(String value) {
    sName = value;
  }

  void setSchoolID(String value) {
    schoolID = value;
  }
  School.fromMap(Map<String, dynamic> res) :
        schoolID = res["school_id"],
        sName = res["s_name"],
        location = res["location"],
        sType = res["s_type"];

  Map<String, Object?> toMap() {
    return {'school_id': schoolID, 's_name': sName, 'location': location,
    's_type': sType};
  }

  @override
  String toString() {
    return 'School{_school_id: $schoolID, _s_name: $sName, _location: $location, _s_type: $sType}';
  }
}