/// Class that holds user data.
/// Note: This class and its methods do not validate data before initializing
/// or updating a User's information. The classes that use User will be
/// responsible for this.
class User {
  String _email;
  String _fullName;
  String _password;

  /// Constructs a User.
  User(this._email, this._fullName, this._password);

  /// Gets a User's email.
  String getEmail() {
    return _email;
  }

  /// Gets a User's full name.
  String getFullName() {
    return _fullName;
  }

  /// Gets a User's password.
  String getPassword() {
    return _password;
  }

  /// Updates a User's email.
  void setEmail(String newEmail) {
    _email = newEmail;
  }

  /// Updates a User's full name.
  void setFullName(String newName) {
    _fullName = newName;
  }

  /// Updates a User's password.
  void setPassword(String newPassword) {
    _password = newPassword;
  }
}
