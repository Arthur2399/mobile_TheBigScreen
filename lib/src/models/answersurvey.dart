import 'package:json_annotation/json_annotation.dart';

part 'answersurvey.g.dart';

@JsonSerializable()
class AnswerSurvey {
  int answer1;
  int answer2;
  int answer3;
  int answer4;
  String answer5;

  AnswerSurvey(this.answer1,this.answer2,this.answer3,this.answer4,this.answer5,);

  static List<AnswerSurvey> getAllToken() {
    return <AnswerSurvey>[
      AnswerSurvey(1,1,1,1,""),
    ];
  }

  factory AnswerSurvey.fromJson(Map<String, dynamic> json) => _$AnswerSurveyFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerSurveyToJson(this);
}
