// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movies _$MoviesFromJson(Map<String, dynamic> json) => Movies(
      json['id'] as int,
      json['category_movie'] as String,
      json['actor_movie'] as String,
      json['premiere'] as bool,
      json['photo_movie'] as String,
      json['name_movie'] as String,
      json['description_movie'] as String,
      json['duration_movie'] as String,
      json['premiere_date_movie'] as String,
      json['departure_date_movie'] as String,
    );

Map<String, dynamic> _$MoviesToJson(Movies instance) => <String, dynamic>{
      'id': instance.id,
      'category_movie': instance.category_movie,
      'actor_movie': instance.actor_movie,
      'premiere': instance.premiere,
      'photo_movie': instance.photo_movie,
      'name_movie': instance.name_movie,
      'description_movie': instance.description_movie,
      'duration_movie': instance.duration_movie,
      'premiere_date_movie': instance.premiere_date_movie,
      'departure_date_movie': instance.departure_date_movie,
    };
