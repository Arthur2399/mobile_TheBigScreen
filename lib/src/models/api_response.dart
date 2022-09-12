
import 'package:cinema_mobile/src/util/local_object_util.dart';
import 'package:json_annotation/json_annotation.dart';


part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  bool? success;
  String? message;
  dynamic response;

  ApiResponseSource? source;
  bool? requireAction;

  ApiResponse(this.success, this.message, this.response);

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}