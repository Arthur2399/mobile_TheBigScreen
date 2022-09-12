
import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {

  String token;



  Token( this.token );


  static List<Token> getAllToken() {
    return <Token>[
      Token(""),

    ];
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}