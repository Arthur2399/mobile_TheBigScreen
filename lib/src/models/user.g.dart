// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int?,
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['username'] as String?,
      json['email'] as String?,
      json['password'] as String?,
      json['image'] as String?,
      json['qrprofile'] as String?,
      json['credit'] as int?,
      json['count_movies'] as int?,
      json['count_survey'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'image': instance.image,
      'qrprofile': instance.qrprofile,
      'credit': instance.credit,
      'count_movies': instance.count_movies,
      'count_survey': instance.count_survey,
    };
