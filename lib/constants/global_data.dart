import 'package:by_your_way/modal/user_modal.dart';
import 'package:by_your_way/pages/auth_module/pre_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';





ValueNotifier<UserModal?> userDataNotifier = ValueNotifier(null);
String? userToken;
late SharedPreferences sharedPreference;
UserTypeData? userType;
String fontFamily="Poppins-Regular";
String cur="\$";
const String defaultCountryCode="91";

Map<String, String> globalHeaders ={
  'Accept':'application/json',
  'Content-Type': 'application/json'
};

List languagesList = [
  {
    'key': 'en',
    'value': 'English'
  },
  {
    'key': 'ar',
    'value': 'Arabic'
  },
];

ValueNotifier<Map<String, dynamic>> selectedLanguageNotifier = ValueNotifier(languagesList[1]);

const double globalHorizontalPadding = 18;
class UserType{
  static const int provider=2;
  static const int user=1;
}




