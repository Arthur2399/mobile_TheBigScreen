// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userRegister.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

userRegister _$userRegisterFromJson(Map<String, dynamic> json) => userRegister(
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['username'] as String?,
      json['email'] as String?,
      json['password'] as String?,
    )..image = json['image'] as String?;

Map<String, dynamic> _$userRegisterToJson(userRegister instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'image': instance.image,
    };
