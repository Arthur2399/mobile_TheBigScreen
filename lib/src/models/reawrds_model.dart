// To parse this JSON data, do
//
//     final reward = rewardFromJson(jsonString);

import 'dart:convert';

List<Reward> rewardFromJson(String str) => List<Reward>.from(json.decode(str).map((x) => Reward.fromJson(x)));

String rewardToJson(List<Reward> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reward {
    Reward({
        this.id,
        this.photoAward,
        this.nameAward,
        this.numberAward,
    });

    int? id;
    String? photoAward;
    String? nameAward;
    int? numberAward;

    factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        id: json["id"],
        photoAward: json["photo_award"],
        nameAward: json["name_award"],
        numberAward: json["number_award"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "photo_award": photoAward,
        "name_award": nameAward,
        "number_award": numberAward,
    };

     static List<Reward> getAllRewards() {
    return <Reward>[
      Reward(id: 1,photoAward: "",nameAward: '',numberAward: 1),
      Reward(id: 2,photoAward: "",nameAward: '',numberAward: 1),
       Reward(id: 3,photoAward: "",nameAward: '',numberAward: 1),
    ];
  }

}
