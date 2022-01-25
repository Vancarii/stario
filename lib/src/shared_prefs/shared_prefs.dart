import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String get username => _sharedPrefs.getString(keyUsername) ?? null;

  set username(String value) {
    _sharedPrefs.setString(keyUsername, value);
  }

  removeUsername() {
    _sharedPrefs.remove(keyUsername);
  }
}

const String keyUsername = "key_username";
