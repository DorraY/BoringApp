import 'package:boring_app/services/base_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  MockDio mockDio = MockDio();
  BaseService service = BaseService();

  setUp(() {
    service.dio = mockDio;
    mockDio.options = BaseOptions(
      baseUrl: "http://www.boredapi.com/api/activity",
      connectTimeout: const Duration(seconds: 5000),
    );
  });

  group('BaseService tests', () {

    test('When Dio returns an activity then request is successful', () async {
      when(() => mockDio.get('/')).thenAnswer((_) async => Response(
        data: {"activity": "Learn something new"},
        statusCode: 200,
        requestOptions: RequestOptions(path: ""),
      ));
      final response = await service.dio.get("/");
      expect(response.statusCode, equals(200));
      expect(response.data["activity"], equals("Learn something new"));
    });

    test('When Dio cannot find an activity then request is successful', () async {
      when(() => mockDio.get('/?participants=100')).thenAnswer((_) async => Response(
        data: {"error": "No activity found with the specified parameters"},
        statusCode: 200,
        requestOptions: RequestOptions(path: ""),
      ));
      final response = await service.dio.get("/?participants=100");
      expect(response.statusCode, equals(200));
      expect(response.data["error"], equals("No activity found with the specified parameters"));
    });

    test('When having connection timeout Dio throws error', () async {
      when(() => mockDio.get('/')).thenThrow(DioErrorType.connectionTimeout);

      try {
        await service.dio.get('/');
      } catch (e) {
        expect(e.toString(), equals('DioErrorType.connectionTimeout'));
      }
    });
  });
}
