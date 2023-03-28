import 'package:boring_app/activities/models/base_model.dart';

import 'activity_type.dart';

class Activity  extends BaseModel{

  ActivityType type;
  String activityTitle;
  int numberOfParticipants;
  Accessibility accessibility;
  Price price;
  String link;
  String key;

  Activity(this.type,this.activityTitle, this.numberOfParticipants, this.accessibility, this.price,
      this.link, this.key);

  factory Activity.empty() => Activity(ActivityType("",""), "", 2, Accessibility.easy, Price.expensive, "", "");

  factory Activity.fromJson(Map<String,dynamic> json) => Activity(
    ActivityType(json["type"] ?? "",json["type"] ?? ""),
    json["activity"] ?? "",
    json["participants"] ?? 0,
    mapAccessibility(json["accessibility"] ?? 0.0),
    mapPrice(json["price"] ?? 0.0),
    json["link"] ?? "",
    json["key"] ?? ""
  );

  @override
  bool isValid() {
   return activityTitle.isNotEmpty  && key.isNotEmpty && type.isValid() ;
  }

  @override
  List<Object?> get props => [key];
}

Accessibility mapAccessibility(num value) {
  if (value == 0) {
    return Accessibility.open;
  } else if (value <= 0.4 && value> 0.0) {
    return Accessibility.easy;
  } else if (value <= 0.7 && value >0.4) {
    return Accessibility.medium;
  } else if (value <= 1.0 && value>0.7) {
    return Accessibility.hard;
  } else {
    throw ArgumentError('Value must be between 0 and 1');
  }  }

Price mapPrice(num value) {
  if (value == 0) {
    return Price.free;
  } else if (value <= 0.4 && value> 0.0) {
    return Price.cheap;
  } else if (value <= 0.7 && value >0.4) {
    return Price.affordable;
  } else if (value <= 1.0 && value>0.7) {
    return Price.expensive;
  } else {
    throw ArgumentError('Value must be between 0 and 1');
  }  }


enum Accessibility {
  open,
  easy,
  medium,
  hard
}

extension AccessibilityExtension on Accessibility {
  static const values = {
    Accessibility.open: 'Open for everyone',
    Accessibility.easy: 'Easy to achieve',
    Accessibility.medium: 'Requires some effort',
    Accessibility.hard: 'Challenging',
  };}


enum Price {
  free,
  cheap,
  affordable,
  expensive
}

extension PriceExtension on Price {
  static const values = {
    Price.free: 'Free',
    Price.cheap: 'Cheap',
    Price.affordable: 'Affordable',
    Price.expensive: 'Expensive',
  };}
