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

  String get artistName => _sharedPrefs.getString(keyArtistName) ?? null;

  set artistName(String value) {
    _sharedPrefs.setString(keyArtistName, value);
  }

  removeArtistName() {
    _sharedPrefs.remove(keyArtistName);
  }
}

const String keyUsername = "key_username";
const String keyArtistName = "key_artist_name";
