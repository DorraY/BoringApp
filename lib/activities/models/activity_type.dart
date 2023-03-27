import 'package:boring_app/activities/models/base_model.dart';
class ActivityType extends BaseModel{

  String image;
  String name;

  ActivityType(this.image, this.name);

  @override
  bool isValid() {
    return name.isNotEmpty && image.isNotEmpty;
  }

  @override
  List<Object?> get props => [];


}

