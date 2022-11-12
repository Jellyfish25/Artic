/// Class that holds user data.
/// Note: This class and its methods do not validate data before initializing
/// or updating a User's information. The classes that use User will be
/// responsible for this.
class User {
  String email;
  String fullName;
  String password;
  int favePlan;

  /// Constructs a User.
  User(this.email, this.fullName, this.password, this.favePlan);

  /// Gets a User's email.
  String getEmail() {
    return email;
  }

  /// Gets a User's full name.
  String getFullName() {
    return fullName;
  }

  /// Gets a User's password.
  String getPassword() {
    return password;
  }

  int getFavePlan() {
    return favePlan;
  }

  /// Updates a User's email.
  void setEmail(String newEmail) {
    email = newEmail;
  }

  /// Updates a User's full name.
  void setFullName(String newName) {
    fullName = newName;
  }

  /// Updates a User's password.
  void setPassword(String newPassword) {
    password = newPassword;
  }

  void setFavePlan(int newFavePlan) {
    favePlan = newFavePlan;
  }

  User.fromMap(Map<String, dynamic> res)
      : email = res["email"],
        fullName = res["full_name"],
        password = res["password"],
        favePlan = res["fave_plan"];

  Map<String, Object?> toMap() {
    return {'email': email, 'full_name': fullName, 'password': password, 'fave_plan': favePlan};
  }

  @override
  String toString() {
    return 'User{email: $email, full_name: $fullName, password: $password, fave_plan: $favePlan}';
  }
}
