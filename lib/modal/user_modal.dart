

import 'package:by_your_way/constants/api_keys.dart';
import 'package:by_your_way/extensions/capitalise_first_letter.dart';

import '../services/api_urls.dart';


class UserModal {
  int id;
  String? firstName;
  String? lastName;
  String email;
  String phoneCode;
  String phone;
  int status;
  String? profileImage;
  int? userType;
  int verification_status;
  String? userName;



  UserModal({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneCode,
    required this.phone,
    required this.status,
    required this.profileImage,
    required this.userType,
    required this.verification_status,
  });

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
      firstName: json[ApiKeys.firstName],
      lastName: json[ApiKeys.lastName],
      userName:json[ApiKeys.firstName]==null?null: '${json[ApiKeys.firstName]} ${json[ApiKeys.lastName]}',
      email: json[ApiKeys.email],
      phoneCode: json[ApiKeys.phoneCode],
      phone: json[ApiKeys.phone],
      status: json[ApiKeys.status],
      profileImage:  json[ApiKeys.profileImage]==null?null:ApiUrls.baseImageUrl + json[ApiKeys.profileImage],
      userType: json[ApiKeys.userType],
      // verification_status: 0,
      verification_status: json[ApiKeys.verification_status],
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
