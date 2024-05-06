import 'package:by_your_way/modal/user_modal.dart';
import 'package:by_your_way/pages/auth_module/pre_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_keys.dart';





ValueNotifier<UserModal?> userDataNotifier = ValueNotifier(null);
String? userToken;
late SharedPreferences sharedPreference;
// int? userType;
// UserTypeData? userType;
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
    'value': 'عربي'
  },
];

// ValueNotifier<Map<String, dynamic>> selectedLanguageNotifier = ValueNotifier(languagesList[1]);




List globalCategoriesList = [];
List globalSubCategoriesList = [];


const double globalHorizontalPadding = 18;
const double globalBorderRadius = 15;






List getSubCatetoriesList(categoryId){
  print('the select cat value  $categoryId');
  List temp = [];
  for (int i = 0; i < globalSubCategoriesList.length; i++) {

    print('the select cat value ${categoryId ==
        globalSubCategoriesList[i][ApiKeys.type_id]} id is ${globalSubCategoriesList[i][ApiKeys.type_id]} comparing to $categoryId');
    if (categoryId ==
        globalSubCategoriesList[i][ApiKeys.type_id]) {

      Map dd = globalSubCategoriesList[i];
      print('sdflks $dd');
      dd['isSelect'] = ValueNotifier(false);
      temp.add(dd);
    }
  }
  return temp;
}


Map? getSubCategory(id){
  print('the su is comparing to $id ...with totl length : ${globalSubCategoriesList.length}');
  for (int i = 0; i < globalSubCategoriesList.length; i++) {

    if (id ==
        globalSubCategoriesList[i][ApiKeys.type_id]) {

      Map dd = globalSubCategoriesList[i];
      print('sdflks $dd');
      dd['isSelect'] = ValueNotifier(false);
      return dd;
    }
  }

}