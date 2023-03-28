import 'package:bloc/bloc.dart';
import 'package:boring_app/activities/models/activity.dart';
import 'package:boring_app/activities/models/activity_search_criteria.dart';
import 'package:boring_app/activities/services/activity_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/activity_type.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc({required this.activityService}) : super(ActivityLoading()) {
    on<ActivityListStarted>(_onStarted);
    on<ActivitySearchStarted>(_onActivitySearch);
    
  }

  final ActivityService activityService;

  Future<void> _onStarted(
      ActivityListStarted event,
      Emitter<ActivityState> emit,
      ) async {
    emit(ActivityLoading());
    try {
      List<Activity> activityList = [];
      final List<Future<Activity>> activityFuturesList = [];
      for (int i=0;i<50;i++) {
        Future<Activity> newFutureActivity=activityService.getActivity();
        activityFuturesList.add(newFutureActivity);
      }
      activityList = await Future.wait(activityFuturesList);
      final List<Activity> activityListWithoutDuplicates = activityList.toSet().toList();
      emit(ActivityListLoaded(activityListWithoutDuplicates));
    } catch (_) {
      debugPrint(_.toString());
      emit(ActivityListError());
    }
  }
  
  Future<void> _onActivitySearch(
      ActivitySearchStarted event,
      Emitter<ActivityState> emit,
      )  async {
    emit(ActivityLoading());
    try {
      final result =await activityService.getActivityByFilter(event.type);
      debugPrint(result.activityTitle);
      emit(ActivitySearchLoaded(result));

    } catch (_) {
      debugPrint(_.toString());
      emit(ActivitySearchError());
    }
  }
}
