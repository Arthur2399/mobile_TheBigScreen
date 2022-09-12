// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

List<Movie> movieFromJson(String str) => List<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));

String movieToJson(List<Movie> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movie {
    Movie({
        this.id,
        this.categoryMovie,
        this.actorMovie,
        this.premiere,
        this.photoMovie,
        this.nameMovie,
        this.descriptionMovie,
        this.durationMovie,
        this.premiereDateMovie,
        this.departureDateMovie,
    });

    int? id;
    List<String>? categoryMovie;
    List<String>? actorMovie;
    bool? premiere;
    String? photoMovie;
    String? nameMovie;
    String? descriptionMovie;
    String? durationMovie;
    String? premiereDateMovie;
    String? departureDateMovie;

    factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        categoryMovie: List<String>.from(json["category_movie"].map((x) => x)),
        actorMovie: List<String>.from(json["actor_movie"].map((x) => x)),
        premiere: json["premiere"],
        photoMovie: json["photo_movie"],
        nameMovie: json["name_movie"],
        descriptionMovie: json["description_movie"],
        durationMovie: json["duration_movie"],
        premiereDateMovie: json["premiere_date_movie"],
        departureDateMovie: json["departure_date_movie"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_movie": List<dynamic>.from(categoryMovie!.map((x) => x)),
        "actor_movie": List<dynamic>.from(actorMovie!.map((x) => x)),
        "premiere": premiere,
        "photo_movie": photoMovie,
        "name_movie": nameMovie,
        "description_movie": descriptionMovie,
        "duration_movie": durationMovie,
        "premiere_date_movie": premiereDateMovie,
        "departure_date_movie": departureDateMovie,
    };
      static List<Movie> getAllMovies() {
    return <Movie>[
        Movie()
    ];
  }

}
