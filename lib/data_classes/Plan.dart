class Plan{
  int planID;
  String dateCreated;
  String owner;
  String schoolID;
  String degName;

  Plan(this.planID, this.dateCreated, this.owner, this.schoolID, this.degName);

  int getPlanID() => planID;

  String getDateCreated() => dateCreated;

  String getOwner() => owner;

  String getSchoolID() => schoolID;

  String getDegName() => degName;

  void setDateCreated(String value) {
    dateCreated = value;
  }

  void setPlanID(int value) {
    planID = value;
  }

  void setOwner(String value) {
    owner = value;
  }

  void setSchoolID(String value) {
    schoolID = value;
  }

  void getPlanDegName(String value) {
    degName = value;
  }

  Plan.fromMap(Map<String, dynamic> res) :
      planID = res["plan_id"],
      dateCreated = res["date_created"],
      owner = res["owner"],
      schoolID = res["school_id"],
      degName = res["deg_name"];

  Map<String, Object?> toMap() {
    return {'plan_id': planID, "date_created": dateCreated, 'owner': owner, 'school_id': schoolID, 'deg_name': degName};
  }

  @override
  String toString() {
    return 'Plan{_plan_id: $planID, _date_created: $dateCreated, _owner: $owner, _school_id: $schoolID, _deg_name: $degName}';

  }
}