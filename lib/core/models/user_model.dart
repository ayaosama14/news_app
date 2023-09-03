import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? fullName;
  String? email;
  String? password;
  String? phone;
  String? imgUrl;
  String? uId;
  bool? isPhoneVerified;
  UserModel({
    this.fullName,
    this.email,
    this.password,
    this.phone,
    this.imgUrl,
    this.uId,
    this.isPhoneVerified,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fName': fullName,
      'email': email,
      'password': password,
      'phone': phone,
      'imgUrl': imgUrl,
      'uId': uId,
      'isPhoneVerified': isPhoneVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      imgUrl: map['imgUrl'] != null ? map['imgUrl'] as String : null,
      uId: map['uId'] != null ? map['uId'] as String : null,
      isPhoneVerified: map['isPhoneVerified'] != null
          ? map['isPhoneVerified'] as bool
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
