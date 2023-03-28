part of 'activity_bloc.dart';

@immutable
abstract class ActivityEvent extends Equatable {
  const ActivityEvent();
}

class ActivityListStarted extends ActivityEvent {
  @override
  List<Object?> get props => [];

}

class ActivitySearchStarted extends ActivityEvent {
  final ActivitySearchCriteria type;

  const ActivitySearchStarted(this.type);
  @override
  List<Object?> get props => [];

}


