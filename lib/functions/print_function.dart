import 'dart:developer';

import 'package:flutter/foundation.dart';


bool showPrintStatements = true;
bool showLogStatements = true;
void myCustomPrintStatement(Object? data, {bool showPrint = false, bool overrideDebugCondition = true}){
  if(showPrintStatements || showPrint){
    if(kDebugMode || overrideDebugCondition){

      print('${DateTime.now()} : ${data}');
      return;
    }
  }
}

void myCustomLogStatements(Object? data, {bool showLog = false, bool overrideDebugCondition = false}){
  if(showLogStatements || showLog){
    if(kDebugMode || overrideDebugCondition){
      log(data.toString());
      return;
    }
  }

}