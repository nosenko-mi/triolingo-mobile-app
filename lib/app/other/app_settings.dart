// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';


const String EMAIL_SHARED_PREFERENCES_KEY = 'email';

const String PASSWORD_SHARED_PREFERENCES_KEY = 'password';

final appSettings = AppSettings();

class AppSettings {

  Future<SharedPreferences> get sharedPreferences async => await SharedPreferences.getInstance();

  void setUserEmail({required String email}) => sharedPreferences.then((pref) {
    pref.setString(EMAIL_SHARED_PREFERENCES_KEY, email);
  });

  Future<String?> getUserEmail() async {
    return (await sharedPreferences).getString(EMAIL_SHARED_PREFERENCES_KEY);
  } 

  void setUserPassword({required String password}) => sharedPreferences.then((pref) {
    pref.setString(PASSWORD_SHARED_PREFERENCES_KEY, password);
  });

  Future<String?> getUserPassword() async {
    return (await sharedPreferences).getString(PASSWORD_SHARED_PREFERENCES_KEY);
  } 

  Future<void> truncate() async {
    (await sharedPreferences).clear();
  }
  
}