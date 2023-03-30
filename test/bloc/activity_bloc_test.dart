import 'package:bloc_test/bloc_test.dart';
import 'package:boring_app/bloc/activity_bloc.dart';
import 'package:boring_app/models/activity.dart';
import 'package:boring_app/models/activity_search_criteria.dart';
import 'package:boring_app/models/activity_type.dart';
import 'package:boring_app/services/activity_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockActivityService extends Mock implements ActivityService {}

void main() {
  group('ActivityBloc', () {
    late ActivityService activityService;

    setUp(() {
      activityService = MockActivityService();
    });

    test('initial state is ActivitySearchIdle', () {
      expect(ActivityBloc(activityService: activityService).state, ActivitySearchIdle());
    });

    blocTest<ActivityBloc, ActivityState>(
      'emits [ActivityLoading, ActivityListLoaded] when ActivityListStarted is added and service call is successful',
      build: () {
        when(() => activityService.getActivity()).thenAnswer((_) async => Activity(ActivityType('education'), 'Learn a new language',1,Accessibility.hard,Price.expensive,"","0"));
        return ActivityBloc(activityService: activityService);
      },
      act: (bloc) => bloc.add(ActivityListStarted()),
      expect: () => [
        ActivityLoading(),
        ActivityListLoaded([Activity(ActivityType('education'), 'Learn a new language',1,Accessibility.hard,Price.expensive,"","0")])
      ],
    );

    blocTest<ActivityBloc, ActivityState>(
      'emits [ActivityLoading, ActivityListError] when ActivityListStarted is added and service call throws an error',
      build: () {
        when(() => activityService.getActivity()).thenThrow(Exception('Unable to get activity'));
        return ActivityBloc(activityService: activityService);
      },
      act: (bloc) => bloc.add(ActivityListStarted()),
      expect: () => [
        ActivityLoading(),
        ActivityListError(),
      ],
    );

    blocTest<ActivityBloc, ActivityState>(
      'emits [ActivityLoading, ActivitySearchLoaded] when ActivitySearchStarted is added and service call is successful',
      build: () {
        when(() => activityService.getActivityByFilter(ActivitySearchCriteria())).thenAnswer((_) async => Activity(ActivityType('education'), 'Learn a new language',1,Accessibility.hard,Price.expensive,"",""));
        return ActivityBloc(activityService: activityService);
      },
      act: (bloc) => bloc.add(ActivitySearchStarted(ActivitySearchCriteria(type: 'education'))),
      expect: () => [
        ActivityLoading(),
        ActivitySearchError()
      ],
    );

    blocTest<ActivityBloc, ActivityState>(
      'emits [ActivityLoading, ActivitySearchError] when ActivitySearchStarted is added and service call throws an error',
      build: () {
        when(() => activityService.getActivityByFilter(ActivitySearchCriteria(numberOfParticipants: 100))).thenThrow(Exception('Unable to get activity'));
        return ActivityBloc(activityService: activityService);
      },
      act: (bloc) => bloc.add(ActivitySearchStarted(ActivitySearchCriteria(numberOfParticipants: 100))),
      expect: () => [
        ActivityLoading(),
        ActivitySearchError(),
      ],
    );
  });
}