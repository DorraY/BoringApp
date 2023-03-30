part of 'activity_bloc.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object> get props => [];
}

class ActivityLoading extends ActivityState {}

class ActivityListLoaded extends ActivityState {
  const ActivityListLoaded(this.activityList);

  final List<Activity> activityList;

  @override
  List<Object> get props => [activityList];
}

class ActivityListError extends ActivityState {}

class ActivitySearchIdle extends ActivityState {}

class ActivitySearchLoaded extends ActivityState {
  const ActivitySearchLoaded(this.activity);

  final Activity activity;

  @override
  List<Object> get props => [activity];
}

class ActivitySearchError extends ActivityState {}
