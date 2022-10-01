class Plan{
  String planID;
  String dateCreated;

  Plan(this.planID, this.dateCreated);

  String getPlanID() => planID;

  String getDateCreated() => dateCreated;

  void setDateCreated(String value) {
    dateCreated = value;
  }

  void setPlanID(String value) {
    planID = value;
  }

  Plan.fromMap(Map<String, dynamic> res) :
        planID = res["plan_id"],
        dateCreated = res["date_created"];

  Map<String, Object?> toMap() {
    return {'plan_id': planID, "date_created": dateCreated};
  }

  @override
  String toString() {
    return 'Plan{_plan_id: $planID, _date_created: $dateCreated}';
  }
}