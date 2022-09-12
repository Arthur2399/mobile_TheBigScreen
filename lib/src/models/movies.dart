
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'movies.g.dart';

@JsonSerializable()
class Movies {

  int id;
  String category_movie;
  String actor_movie;
  bool premiere;
  String photo_movie;
  String name_movie;
  String description_movie;
  String duration_movie;

  String premiere_date_movie;
  String departure_date_movie;
  


  Movies(this.id, this.category_movie, this.actor_movie, this.premiere, this.photo_movie, this.name_movie, this.description_movie, this.duration_movie, this.premiere_date_movie, this.departure_date_movie);

  static Movies getDefaultMovie() {
    return Movies(0,'', '', false, '', '','',  '','','');
  }

  static List<Movies> getAllMovies() {
    return <Movies>[
      Movies(1, "", '', false, '','', '','','',''),
      Movies(2, "", '', false, '', '','','','',''),
      Movies(3, "", '', false, '', '','','','','')
    ];
  }


  factory Movies.fromJson(Map<String, dynamic> json) => _$MoviesFromJson(json);
  Map<String, dynamic> toJson() => _$MoviesToJson(this);
}