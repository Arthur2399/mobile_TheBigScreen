
// ignore_for_file: camel_case_types, non_constant_identifier_names, file_names

import 'package:json_annotation/json_annotation.dart';

part 'userRegister.g.dart';

@JsonSerializable()
class userRegister {

  String? first_name;
  String? last_name;
  String? username;
  String? email;
  String? password;
  String? image;


  userRegister( this.first_name, this.last_name, this.username, this.email, this.password);

  static userRegister getDefaultUser() {
    return userRegister('', '', '', '', '');
  }

  static List<userRegister> getAllUsers() {
    return <userRegister>[
      userRegister( "Cristiano", '', '', '',''),
      userRegister( "Lionel", '', '', '', ''),
      userRegister( "Carlos", '', '', '', '')
    ];
  }

  factory userRegister.fromJson(Map<String, dynamic> json) => _$userRegisterFromJson(json);
  Map<String, dynamic> toJson() => _$userRegisterToJson(this);
}