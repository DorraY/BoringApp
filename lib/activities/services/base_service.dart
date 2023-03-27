import 'package:dio/dio.dart';


class BaseService {

  Dio dio = Dio(BaseOptions(
    baseUrl: "http://www.boredapi.com/api/activity",
    connectTimeout: const Duration(seconds: 5000),
  ));

  BaseService() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler) async {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler ) {
          switch (error.type) {
            case DioErrorType.connectionTimeout:
            case DioErrorType.sendTimeout:
            case DioErrorType.receiveTimeout:
              throw DioErrorWithMessage(error.requestOptions, "Connection timeout. Try again!");
            case DioErrorType.badResponse:
            case DioErrorType.cancel:
              break;
            case DioErrorType.unknown:
              throw DioErrorWithMessage(error.requestOptions, "Check your connection then try again!");
            case DioErrorType.connectionError:
            case DioErrorType.badCertificate:
              throw DioErrorWithMessage(error.requestOptions, "Problem connecting. Try again!");
          }

        }
    ));
  }

}


class DioErrorWithMessage extends DioError {
  String errorMessage = "An error occurred. try again!";
  DioErrorWithMessage(RequestOptions r, this.errorMessage) : super(requestOptions: r);
  @override
  String toString() => errorMessage;
}
