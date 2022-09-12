// To parse this JSON data, do
//
//     final top5Movies = top5MoviesFromJson(jsonString);

import 'dart:convert';

List<Top5Movies> top5MoviesFromJson(String str) => List<Top5Movies>.from(json.decode(str).map((x) => Top5Movies.fromJson(x)));

String top5MoviesToJson(List<Top5Movies> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Top5Movies {
    Top5Movies({
        this.nameMovie,
        this.photoMovie,
        this.stars,
        this.numbers,
    });

    String? nameMovie;
    String? photoMovie;
    double? stars;
    int? numbers;

    factory Top5Movies.fromJson(Map<String, dynamic> json) => Top5Movies(
        nameMovie: json["name_movie"],
        photoMovie: json["photo_movie"],
        stars: json["stars"].toDouble(),
        numbers: json["numbers"],
    );

    Map<String, dynamic> toJson() => {
        "name_movie": nameMovie,
        "photo_movie": photoMovie,
        "stars": stars,
        "numbers": numbers,
    };
}
