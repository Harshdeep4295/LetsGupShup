import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  late SharedPreferences _preferences;

  static final AppPreferences _instance = AppPreferences._internal();

  AppPreferences._internal() {
    SharedPreferences.getInstance().then(
      (preference) => _preferences = preference,
    );
  }

  factory AppPreferences() => _instance;

  Future<String?> _getValue({@required key}) async =>
      _preferences.getString(key);
  Future<bool> _getBoolValue({@required key}) async =>
      _preferences.getBool(key) ?? false;

  void setValue({
    @required key,
    @required value,
  }) {
    if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is String) {
      _preferences.setString(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    }
  }

  static const String NAME = "name";
  static const String EMAIL = "email";
  static const String ID = "id";
  static const String STATUS = "status";
  static const String LOGGED_IN_STATUS = "user_logged_in";

  void setName(String value) => setValue(key: NAME, value: value);
  void setEmail(String value) => setValue(key: EMAIL, value: value);
  void setId(String value) => setValue(key: ID, value: value);
  void setStatus(String value) => setValue(key: STATUS, value: value);
  void setLoggedIn(bool value) => setValue(key: LOGGED_IN_STATUS, value: value);

  Future<String?> get name => _getValue(key: NAME);
  Future<String?> get email => _getValue(key: EMAIL);
  Future<String?> get id => _getValue(key: ID);
  Future<String?> get status => _getValue(key: STATUS);
  Future<bool> get isUserLoggedIn => _getBoolValue(key: LOGGED_IN_STATUS);

  Future<void> clearAll() async {
    await _preferences.clear();
  }
}
