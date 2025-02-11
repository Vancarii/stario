import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  static final SharedPrefs instance = SharedPrefs._internal();

  SharedPrefs._internal();

  /// Ensures `_sharedPrefs` is initialized before use
  static Future<void> init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  /// Returns stored username (or an empty string if not set)
  String get username => _sharedPrefs?.getString(keyUsername) ?? '';

  set username(String value) {
    _sharedPrefs?.setString(keyUsername, value);
  }

  void removeUsername() {
    _sharedPrefs?.remove(keyUsername);
  }

  /// Returns stored artist name (or an empty string if not set)
  String get artistName => _sharedPrefs?.getString(keyArtistName) ?? '';

  set artistName(String value) {
    _sharedPrefs?.setString(keyArtistName, value);
  }

  void removeArtistName() {
    _sharedPrefs?.remove(keyArtistName);
  }
}

const String keyUsername = "key_username";
const String keyArtistName = "key_artist_name";
