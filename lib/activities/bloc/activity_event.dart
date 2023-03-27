part of 'activity_bloc.dart';

@immutable
abstract class ActivityEvent extends Equatable {
  const ActivityEvent();
}

class ActivityStarted extends ActivityEvent {
  @override
  List<Object?> get props => [];

}

