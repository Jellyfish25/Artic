class Plan{
  String _plan_id;
  String _date_created;

  Plan(this._plan_id, this._date_created);

  String getPlanID() => _plan_id;

  String getDateCreated() => _date_created;

  void setDateCreated(String value) {
    _date_created = value;
  }

  void setPlanID(String value) {
    _plan_id = value;
  }

  Plan.fromMap(Map<String, dynamic> res) :
      _plan_id = res["plan_id"],
      _date_created = res["date_created"];

  Map<String, Object?> toMap() {
    return {'plan_id': _plan_id, "date_created": _date_created};
  }

  @override
  String toString() {
    return 'Plan{_plan_id: $_plan_id, _date_created: $_date_created}';
  }
}