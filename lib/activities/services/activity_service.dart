import 'dart:async';

import 'package:boring_app/activities/models/activity.dart';
import 'package:boring_app/activities/models/activity_search_criteria.dart';
import 'package:boring_app/activities/services/base_service.dart';


class ActivityService extends BaseService {

  Activity parseActivityData(dynamic data) {
    return Activity.fromJson(data);

  }

  Future<Activity> getActivity() async{
    final result = await dio.get('/');
    return parseActivityData(result.data);
  }


  Future<Activity> getActivityByFilter(
      ActivitySearchCriteria activitySearchCriteria) async{
    final result = await dio.get('?participants=${activitySearchCriteria.numberOfParticipants?? ""}&minprice=${activitySearchCriteria.priceMin ?? ""}&maxprice=${activitySearchCriteria.priceMax ?? ""}&type=${activitySearchCriteria.type ?? ""}&minaccessibility=${activitySearchCriteria.accessibilityMin ?? ""}&maxaccessibility=${activitySearchCriteria.accessibilityMax ?? ""}');
    return parseActivityData(result.data);
  }

}
