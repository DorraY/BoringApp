import 'package:boring_app/models/base_model.dart';
class ActivityType extends BaseModel{

  String name;

  ActivityType(this.name);

  @override
  bool isValid() {
    return name.isNotEmpty && activityType.contains(name);
  }

  static final List<String> activityType = [
    "education",
    "recreational",
    "social",
    "diy",
    "charity",
    "cooking",
    "relaxation",
    "music",
    "busywork"
  ];

  @override
  List<Object?> get props => [];


}

