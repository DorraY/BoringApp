import 'package:boring_app/models/activity.dart';
import 'package:boring_app/models/activity_search_criteria.dart';
import 'package:boring_app/models/activity_type.dart';
import 'package:boring_app/services/activity_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

void main() {

  late Dio mockDio;
  late ActivityService activityService;

  setUp(() {
    mockDio = MockDio();
    activityService = ActivityService();
    activityService.dio = mockDio;
  });

  group('ActivityService', () {

    test('when given a correct json it should parse it and return valid activity', () {
      final json = {"activity": "Organize your dresser", "type": "busywork", "participants": 1, "price": 0, "link": "", "key": "7556665", "accessibility": 1};
      final newActivity = activityService.parseActivityData(json);
      expect(newActivity.isValid(), true);
    });

    test('when given a correct json it should parse it and return invalid activity', () {
      final json = {"error":"error"};
      final newActivity = activityService.parseActivityData(json);
      expect(newActivity.isValid(), false);
    });

    });
}