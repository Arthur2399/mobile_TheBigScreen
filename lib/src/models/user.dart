
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {

  int? id;
  String? first_name;
  String? last_name;
  String? username;
  String? email;
  String? password;
  String? image;
  String? qrprofile;
  int? credit;
  int? count_movies;
  int? count_survey;


  User(this.id, this.first_name, this.last_name, this.username, this.email, this.password, this.image, this.qrprofile, this.credit, this.count_movies, this.count_survey,);

  static User getDefaultUser() {
    return User(0,'', '', '', '', '','',  '',0,0,0);
  }

  static List<User> getAllUsers() {
    return <User>[
      User(1, "Cristiano", '', '', '','', '','',0,0,0),
      User(2, "Lionel", '', '', '', '','','',0,0,0),
      User(3, "Carlos", '', '', '', '','','',0,0,0)
    ];
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}