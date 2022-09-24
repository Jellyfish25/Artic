class School {
  String _school_id;
  String _s_name;
  String _location;
  String _s_type;

  School(this._school_id, this._s_name, this._location, this._s_type);

  String getSchoolID() {
    return _school_id;
  }

  String getSType() => _s_type;

  void setSType(String value) {
    _s_type = value;
  }

  String getLocation() => _location;

  void setLocation(String value) {
    _location = value;
  }

  String getSName() => _s_name;

  void setSName(String value) {
    _s_name = value;
  }

  void setSchoolID(String value) {
    _school_id = value;
  }
  School.fromMap(Map<String, dynamic> res) :
        _school_id = res["school_id"],
        _s_name = res["s_name"],
        _location = res["location"],
        _s_type = res["s_type"];
  Map<String, Object?> toMap() {
    return {'school_id': _school_id, 's_name': _s_name, 'location': _location,
    's_type': _s_type};
  }

  @override
  String toString() {
    return 'School{_school_id: $_school_id, _s_name: $_s_name, _location: $_location, _s_type: $_s_type}';
  }
}