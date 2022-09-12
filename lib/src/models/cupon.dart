
import 'package:json_annotation/json_annotation.dart';

part 'cupon.g.dart';

@JsonSerializable()
class Cupon {

  String qr;



  Cupon( this.qr );


  static List<Cupon> getAllToken() {
    return <Cupon>[
      Cupon(""),

    ];
  }

  factory Cupon.fromJson(Map<String, dynamic> json) => _$CuponFromJson(json);
  Map<String, dynamic> toJson() => _$CuponToJson(this);
}