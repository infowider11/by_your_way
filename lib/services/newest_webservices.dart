// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:by_your_way/constants/global_keys.dart';
import 'package:by_your_way/functions/custom_time_functions.dart';
import 'package:by_your_way/functions/showCustomBottomSheet.dart';
import 'package:by_your_way/provider/app_loading_provider.dart';
import 'package:by_your_way/widget/custom_text.dart';
import '../constants/global_data.dart';
import '../functions/print_function.dart';
import '../modal/response_modal.dart';
import '../widget/show_snackbar.dart';

ResponseModal failedResponseModal = ResponseModal(status: 0, message: 'Api Failed in catch', error: {"Api":"Api Failed in catch block"}, data: [],
  fullData: {},);



enum ApiMethod{
  get, post, put, patch, delete
}

class NewestWebServices {




  static Future<ResponseModal> getResponse({
    required String apiUrl,
    required Map<String, dynamic> request,
    bool showSuccessMessage  = false,
    bool showErrorMessage = true,
    Map<String, File>? files,
    bool load  = false,
    bool jsonConversion = true,
    ApiMethod apiMethod = ApiMethod.post,
    Map<String, String>? customHeaders,  // if this is passed then no default headers will be passed
})async{
    var loadingProvider = Provider.of<AppLoadingProvider>(MyGlobalKeys.navigatorKey.currentContext!, listen: false);
    if(load){
      loadingProvider.showLoading();
    }

    // request['lang'] = selectedLanguageNotifier.value['key'];
   try{
     Map<String,String> newHeaders = {};
     newHeaders.addAll(globalHeaders);
     newHeaders['Accept-Language'] = selectedLanguageNotifier.value['key'];
     newHeaders['timezone'] = currentTimezone;
     late http.Response response;
     if(userToken!=null){
       newHeaders['Authorization'] = 'Bearer $userToken';
       print('this is user token $userToken');
     }

     myCustomLogStatements('the request for url $apiUrl with headers ${customHeaders??newHeaders} is $request');
     if(apiMethod==ApiMethod.get){
       apiUrl = getUrlString(request: request,apiUrl: apiUrl);
       myCustomLogStatements('the GET request for url $apiUrl with headers ${customHeaders??newHeaders} is $request');
       response = await http.get(Uri.parse(apiUrl ), headers: customHeaders??newHeaders);
     }else if(apiMethod==ApiMethod.put){
       response = await http.put(Uri.parse(apiUrl ), body: jsonConversion?convert.jsonEncode(request):request, headers: customHeaders??newHeaders);
     }else if(apiMethod==ApiMethod.patch){
       response = await http.patch(Uri.parse(apiUrl ), body: jsonConversion?convert.jsonEncode(request):request, headers: customHeaders??newHeaders);
     }else if(apiMethod==ApiMethod.post){
       response = await http.post(Uri.parse(apiUrl ), body: jsonConversion?convert.jsonEncode(request):request, headers: customHeaders??newHeaders);
     }else if(apiMethod==ApiMethod.delete){
       response = await http.delete(Uri.parse(apiUrl ), body: jsonConversion?convert.jsonEncode(request):request, headers: customHeaders??newHeaders);
     }

     myCustomLogStatements('the response for $apiUrl with status code ${response.statusCode} is ${response.body}');
     if(load){
       loadingProvider.hideLoading();
     }
     var responseModal = ResponseModal.fromHttpResponse(response);
     if (showSuccessMessage) {
       showSnackbar(responseModal.message);
     }
     if(responseModal.status==0){
       if(showErrorMessage){
         showSnackbar(responseModal.message);
       }
     }
     return responseModal;
   } catch(e){

      showSnackbar('sdfkljsdlkf $e');
      myCustomPrintStatement('klrgkledf $e');

      if(e.toString().contains('Failed host lookup')){
        showSnackbar("Internet Connection not available");
        // showCustomBottomSheet(context: context, child: Container(
        //   child: Column(
        //     children: [
        //       SubHeadingText("Internet Connection"),
        //       ParagraphText('Please check that you are connected with internet');
        //     ],
        //   ),
        // ));
      }
      myCustomLogStatements('sdfkljsdlkf $e');
   }




    return failedResponseModal;
  }


  static String getUrlString({required Map<String, dynamic> request, required String apiUrl,}){
    String tempGetRequest = '$apiUrl?';
    request.forEach((key, value) {
      tempGetRequest +=key+'=' + value.toString() + '&';

    });
    tempGetRequest = tempGetRequest.substring(0,tempGetRequest.length-1);
    myCustomPrintStatement('the url issss $tempGetRequest');
    return tempGetRequest;
  }





  static Future<http.Response> globalApisGetResponse({
    required String apiUrl,
    required Map<String, dynamic> request,
    bool showSuccessMessage  = false,
    bool showErrorMessage = true,
    Map<String, File>? files,
    bool load  = false,
    bool jsonConversion = true,
    ApiMethod apiMethod = ApiMethod.post,
    Map<String, String>? customHeaders,  // if this is passed then no default headers will be passed
  })async{
    var loadingProvider = Provider.of<AppLoadingProvider>(MyGlobalKeys.navigatorKey.currentContext!, listen: false);
    if(load){
      loadingProvider.showLoading();
    }

    // request['lang'] = selectedLanguageNotifier.value['key'];
    try{
      Map<String,String> newHeaders = {};
      newHeaders.addAll(globalHeaders);
      newHeaders['Accept-Language'] = selectedLanguageNotifier.value['key'];
      late http.Response response;
      if(userToken!=null){
        newHeaders['Authorization'] = 'Bearer $userToken';
        print('this is user token $userToken');
      }

      myCustomLogStatements('the request for url $apiUrl with headers ${customHeaders??newHeaders} is $request');
      if(apiMethod==ApiMethod.get){
        apiUrl = getUrlString(request: request,apiUrl: apiUrl);
        myCustomLogStatements('the GET request for url $apiUrl with headers ${customHeaders??newHeaders} is $request');
        response = await http.get(Uri.parse(apiUrl ), headers: customHeaders??newHeaders);
      }else if(apiMethod==ApiMethod.put){
        response = await http.put(Uri.parse(apiUrl ), body: jsonConversion?convert.jsonEncode(request):request, headers: customHeaders??newHeaders);
      }else if(apiMethod==ApiMethod.patch){
        response = await http.patch(Uri.parse(apiUrl ), body: jsonConversion?convert.jsonEncode(request):request, headers: customHeaders??newHeaders);
      }else if(apiMethod==ApiMethod.post){
        response = await http.post(Uri.parse(apiUrl ), body: jsonConversion?convert.jsonEncode(request):request, headers: customHeaders??newHeaders);
      }else if(apiMethod==ApiMethod.delete){
        response = await http.delete(Uri.parse(apiUrl ), body: jsonConversion?convert.jsonEncode(request):request, headers: customHeaders??newHeaders);
      }

      myCustomLogStatements('the response for $apiUrl with status code ${response.statusCode} is ${response.body}');
      if(load){
        loadingProvider.hideLoading();
      }

      return response;
    } catch(e){

      showSnackbar('sdfkljsdlkf $e');
      myCustomPrintStatement('klrgkledf $e');

      if(e.toString().contains('Failed host lookup')){
        showSnackbar("Internet Connection not available");
        // showCustomBottomSheet(context: context, child: Container(
        //   child: Column(
        //     children: [
        //       SubHeadingText("Internet Connection"),
        //       ParagraphText('Please check that you are connected with internet');
        //     ],
        //   ),
        // ));
      }
      myCustomLogStatements('sdfkljsdlkf $e');
    }




    return http.Response('{}', 1001);
  }



  static Future<ResponseModal<dynamic>> postDataWithImageFunction({
    required Map<String, dynamic> body,
    required Map<String, dynamic> files,
    required String apiUrl,
    ApiMethod apiMethod = ApiMethod.post,
    bool showSuccessMessage = false,
    bool errorAlert = true,
  }) async {
    // body['lang'] = selectedLanguageNotifier.value['key'];

    Map<String, String> newHeaders = {};
    newHeaders.addAll(globalHeaders);
    if (userToken != null) {
      newHeaders['Authorization'] = 'Bearer $userToken';
    }
    newHeaders['lang'] = selectedLanguageNotifier.value['key'];
    myCustomPrintStatement(
        'the request for url : $apiUrl is $body with headers $newHeaders');
    myCustomPrintStatement('the file request is $files');

    var url = Uri.parse(apiUrl);
    //
    myCustomLogStatements(apiUrl);
    try {
      var request = http.MultipartRequest("${apiMethod.name.toUpperCase()}", url);
      body.forEach((key, value) {
        request.fields[key] = value;
        // log(value2);
      });
      request.headers.addAll(newHeaders);
      (files).forEach((key, value) async {
        request.files.add(await http.MultipartFile.fromPath(key, value.path));
      });

      myCustomLogStatements(request.fields.toString());
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      myCustomLogStatements(
          'the response for url : $apiUrl with status code ${response.statusCode} is ${response.body} with headers $newHeaders');
      var responseModal = ResponseModal.fromHttpResponse(response);
      if (responseModal.status==1) {
        if (showSuccessMessage) {
          showSnackbar(responseModal.message);
        }
      } else {
        if (errorAlert) {
          try {

            showSnackbar(responseModal.message);
          } catch (e) {
            myCustomPrintStatement('Error in catch block 62365 $e');
            showSnackbar('Error in catch block 62365 $e');
          }
        }
      }
      return responseModal;
      // return response;
    } catch (e) {
      myCustomPrintStatement(e);


      showSnackbar('Error in catch block ECODE: 32');
      // try {
      //   var response = await http.post(url, body: body, headers: newHeaders);
      //   if (response.statusCode == 200) {
      //     var jsonResponse = convert.jsonDecode(response.body);
      //     var responseModal = ResponseModal.fromJson(jsonResponse);
      //     return responseModal;
      //   }
      // } catch (error) {
      //   myCustomPrintStatement('inside double catch block $error');
      //   return failedResponseModal;
      // }
      return failedResponseModal;
      // return null;
    }
  }

}
