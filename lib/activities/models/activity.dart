import 'activity_type.dart';

class Activity  {

  ActivityType type;
  String activityTitle;
  int numberOfParticipants;
  double accessibility;
  double price;
  String link;
  String key;

  Activity(this.type,this.activityTitle, this.numberOfParticipants, this.accessibility, this.price,
      this.link, this.key);

  factory Activity.fromJson(Map<String,dynamic> json) => Activity(
    ActivityType(json["activity"] ?? "",json["activity"] ?? ""),
    json["activity"] ?? 0.0,
    json["participants"] ?? 0.0,
    json["accessibility"] ?? 0.0,
    json["price"] ?? 0.0,
    json["link"] ?? "",
    json["key"] ?? ""
  );

}

