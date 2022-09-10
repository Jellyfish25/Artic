import 'package:artic/data_classes/User.dart';

class Model {
  late List<User> _usersList;
  late User _currentUser;

  Model() {
    _usersList = List.empty(growable: true);
    _currentUser =
        User("default email", "default fullName", "default password");
  }

  bool emailIsUsed(String email) {
    for (User user in _usersList) {
      if (user.getEmail() == email) {
        return true;
      }
    }
    return false;
  }

  User? searchForUser(String email, String password) {
    for (User user in _usersList) {
      if (user.getEmail() == email && user.getPassword() == password) {
        return user;
      }
    }
    return null;
  }

  User getCurrentUser() {
    return _currentUser;
  }

  void addUser(User user) {
    _usersList.add(user);
  }

  void setCurrentUser(User user) {
    _currentUser = user;
  }

  void initializeWithTestData() {
    User dimitar =
        User("dimitar.dimitrov@sjsu.edu", "Dimitar Dimitrov", "passwordD");
    User leon = User("leon.gallardo@sjsu.edu", "Leon Gallardo", "passwordL");
    User edin = User("edin.schneider@sjsu.edu", "Edin Schneider", "passwordE");
    User viola = User("viola.yasuda@sjsu.edu", "Viola Yasuda", "passwordV");
    _usersList.add(dimitar);
    _usersList.add(leon);
    _usersList.add(edin);
    _usersList.add(viola);
  }
}
