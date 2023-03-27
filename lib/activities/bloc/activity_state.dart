part of 'activity_bloc.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object> get props => [];
}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  const ActivityLoaded(this.activityList);

  final List<Activity> activityList;

  @override
  List<Object> get props => [activityList];
}

class ActivityError extends ActivityState {}
