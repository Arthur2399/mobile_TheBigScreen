// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      json['success'] as bool?,
      json['message'] as String?,
      json['response'],
    )
      ..source = $enumDecodeNullable(_$ApiResponseSourceEnumMap, json['source'])
      ..requireAction = json['requireAction'] as bool?;

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'response': instance.response,
      'source': _$ApiResponseSourceEnumMap[instance.source],
      'requireAction': instance.requireAction,
    };

const _$ApiResponseSourceEnumMap = {
  ApiResponseSource.remote: 'remote',
  ApiResponseSource.local: 'local',
};
