// To parse this JSON data, do
//
//     final surveys = surveysFromJson(jsonString);

import 'dart:convert';

List<Surveys> surveysFromJson(String str) => List<Surveys>.from(json.decode(str).map((x) => Surveys.fromJson(x)));

String surveysToJson(List<Surveys> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Surveys {
    Surveys({
        this.id,
        this.movies,
        this.question1,
        this.question2,
        this.question3,
        this.question4,
        this.question5,
        this.date,
        this.answer1,
        this.answer2,
        this.answer3,
        this.answer4,
        this.answer5,
        this.status,
        this.suerveyTemplate,
        this.userId,
        this.branch,
    });

    int? id;
    String? movies;
    String? question1;
    String? question2;
    String? question3;
    String? question4;
    String? question5;
    String? date;
    int? answer1;
    int? answer2;
    int? answer3;
    int? answer4;
    String? answer5;
    int? status;
    int? suerveyTemplate;
    int? userId;
    int? branch;

    factory Surveys.fromJson(Map<String, dynamic> json) => Surveys(
        id: json["id"],
        movies: json["movies"],
        question1: json["question1"],
        question2: json["question2"],
        question3: json["question3"],
        question4: json["question4"],
        question5: json["question5"],
        date:  json["date"],
        answer1: json["answer1"],
        answer2: json["answer2"],
        answer3: json["answer3"],
        answer4: json["answer4"],
        answer5: json["answer5"],
        status: json["status"],
        suerveyTemplate: json["suervey_template"],
        userId: json["user_id"],
        branch: json["branch"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "movies": movies,
        "question1": question1,
        "question2": question2,
        "question3": question3,
        "question4": question4,
        "question5": question5,
        "date": date,
        "answer1": answer1,
        "answer2": answer2,
        "answer3": answer3,
        "answer4": answer4,
        "answer5": answer5,
        "status": status,
        "suervey_template": suerveyTemplate,
        "user_id": userId,
        "branch": branch,
    };
}
