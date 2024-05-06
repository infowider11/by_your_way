

import 'package:by_your_way/constants/api_keys.dart';
import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/extensions/capitalise_first_letter.dart';

import '../constants/types/user_type.dart';
import '../functions/getRatingCount.dart';
import '../services/api_urls.dart';


class UserModal {
  int id;
  String firstName;
  String lastName;
  String email;
  String phoneCode;
  String phone;
  int status;
  String? profileImage;
  int userType;
  int verification_status;
  String fullName;
  int ratingCount;
  double averageRating;



  UserModal({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.phoneCode,
    required this.phone,
    required this.status,
    required this.profileImage,
    required this.userType,
    required this.verification_status,
    required this.ratingCount,
    required this.averageRating,

  });


  String getRatingString(){
    // '${widget.providerModal.providerDetail!.avgRating} ${getRatingCount(widget.providerModal.providerDetail!.ratingCount)}',
    return '$averageRating ${getRatingCount(ratingCount)}';
  }

  factory UserModal.fromJson(Map json) {
    String fullName = '';
    List temp = [];
    if(json[ApiKeys.firstName]!=null){
      temp.add(json[ApiKeys.firstName].toString().capitalizeFirstLettersAsCapital());
    }
    if(json[ApiKeys.lastName]!=null){
      temp.add(json[ApiKeys.lastName].toString().capitalizeFirstLettersAsCapital());
    }
    fullName = temp.join(" ");
    return UserModal(
      id: json[ApiKeys.id],
      firstName: json[ApiKeys.firstName]??'',
      lastName: json[ApiKeys.lastName]??'',
      fullName:json[ApiKeys.firstName]==null?'':'${json[ApiKeys.firstName]} ${json[ApiKeys.lastName]}',
      email: json[ApiKeys.email],
      phoneCode: json[ApiKeys.phoneCode],
      phone: json[ApiKeys.phone],
      status: json[ApiKeys.user_status]??json[ApiKeys.status],
      profileImage:  json[ApiKeys.profileImage]==null?null:ApiUrls.baseImageUrl + json[ApiKeys.profileImage],
      userType: json[ApiKeys.userType]??UserType.user,
      // verification_status: 0,
      verification_status: json[ApiKeys.user_status]??json[ApiKeys.status],
      ratingCount: json[ApiKeys.ratingCount]??0,
      averageRating: double.tryParse(json[ApiKeys.averageRating].toString())??0,
    );
  }

// UserModal(
  //     {required this.userEmailId,
  //     required this.userName,
  //     required this.phone,
  //     required this.userType,
  //     });
  // factory UserModal.fromJson(Map json) {
  //   return UserModal(
  //       userEmailId: json['email'],
  //       userName: json['name'],
  //     phone: json['phone'],
  //     userType: json['userType'],
  //   );
  // }
}
