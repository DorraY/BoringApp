import 'dart:async';

import 'package:boring_app/activities/models/activity.dart';
import 'package:boring_app/activities/services/base_service.dart';


class ActivitiesService extends BaseService {

  Activity parseActivityData(dynamic data) {
    return Activity.fromJson(data);

  }

  Future<Activity> getActivity() async{
    final result = await dio.get('/');
    return parseActivityData(result);

  }

}
