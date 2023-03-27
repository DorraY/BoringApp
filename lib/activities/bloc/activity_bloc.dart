import 'package:bloc/bloc.dart';
import 'package:boring_app/activities/models/activity.dart';
import 'package:boring_app/activities/services/activity_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/activity_type.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc({required this.activityService}) : super(ActivityLoading()) {
    on<ActivityStarted>(_onStarted);
  }

  final ActivityService activityService;

  Future<void> _onStarted(
      ActivityStarted event,
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
      emit(ActivityLoaded(activityListWithoutDuplicates));
    } catch (_) {
      debugPrint(_.toString());
      emit(ActivityError());
    }
  }
}
