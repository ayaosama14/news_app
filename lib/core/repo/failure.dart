import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        return ServerFailure('Connection timeout');
      case DioErrorType.sendTimeout:
        return ServerFailure('Send timeout');

      case DioErrorType.receiveTimeout:
        return ServerFailure('Receive timeout');

      case DioErrorType.badCertificate:
        return ServerFailure('Bad Certificate');

      case DioErrorType.badResponse:
        return ServerFailure.fromResponse(
            statusCode: dioError.response!.statusCode!);

      case DioErrorType.cancel:
        return ServerFailure('Your request was canceled');

      case DioErrorType.connectionError:
        return ServerFailure('Connection Error');

      case DioErrorType.unknown:
        return ServerFailure('Unknown Error');
    }
  }

  factory ServerFailure.fromResponse(
      {required int statusCode, dynamic response}) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request Not Found, try again later');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server Error, try Later');
    } else {
      return ServerFailure('Error, Try Again later');
    }
  }
}
