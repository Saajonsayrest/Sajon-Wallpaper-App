/// Author:    Nabraj Khadka
/// Created:   11.03.2023
/// Description:
/// (c) Copyright by Ncash.com
///

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest() = UnauthorizedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.receiveTimeout() = ReceiveTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  // ignore: prefer_constructors_over_static_methods
  static NetworkExceptions handleResponse(int? statusCode) {
    switch (statusCode) {
      case 400:
        return const NetworkExceptions.badRequest();
      case 401:
        return const NetworkExceptions.unauthorizedRequest();
      case 403:
        return const NetworkExceptions.unauthorizedRequest();
      case 404:
        return const NetworkExceptions.notFound('Not found');
      case 409:
        return const NetworkExceptions.conflict();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        final responseCode = statusCode;
        return NetworkExceptions.defaultError(
          'Received invalid status code: $responseCode',
        );
    }
  }

  static String handleErrorToString(dynamic e) {
    try {
      if (e is DioException && e.response?.data is Map<String, dynamic>) {
        final data = e.response?.data as Map<String, dynamic>;
        if (data.containsKey('message')) {
          return data['message'].toString();
        }
      }
      return NetworkExceptions.getErrorMessage(
          NetworkExceptions.getDioException(e));
    } catch (error) {
      return NetworkExceptions.getErrorMessage(
          NetworkExceptions.getDioException(e));
    }
  }

  // ignore: prefer_constructors_over_static_methods
  static NetworkExceptions getDioException(dynamic error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioException) {
          // Use DioException or the new error type
          switch (error.type) {
            case DioExceptionType.cancel: // Update with new DioException types
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType
                  .connectionTimeout: // Update with new DioException types
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioExceptionType
                  .receiveTimeout: // Update with new DioException types
              networkExceptions = const NetworkExceptions.receiveTimeout();
              break;
            case DioExceptionType
                  .sendTimeout: // Update with new DioException types
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType
                  .badResponse: // Example new type for handling responses
              networkExceptions =
                  NetworkExceptions.handleResponse(error.response?.statusCode);
              break;
            case DioExceptionType
                  .connectionError: // Example new type for connection errors
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioExceptionType.unknown:
            default:
              networkExceptions = const NetworkExceptions.unexpectedError();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = '';
    networkExceptions.when(
      notImplemented: () {
        errorMessage = 'Not Implemented';
      },
      requestCancelled: () {
        errorMessage = 'Request Cancelled';
      },
      internalServerError: () {
        errorMessage = 'Internal Server Error';
      },
      notFound: (String reason) {
        errorMessage = reason;
      },
      serviceUnavailable: () {
        errorMessage = 'Service unavailable';
      },
      methodNotAllowed: () {
        errorMessage = 'Method Not Allowed';
      },
      badRequest: () {
        errorMessage = 'Bad request';
      },
      unauthorizedRequest: () {
        errorMessage = 'Invalid Credentials';
      },
      unexpectedError: () {
        errorMessage = 'Oops !! Something went wrong :( ';
      },
      requestTimeout: () {
        errorMessage = 'Connection request timeout';
      },
      receiveTimeout: () {
        errorMessage = 'Connection receive timeout';
      },
      noInternetConnection: () {
        errorMessage =
            // 'No internet connection! Check your network connection and try again';
            'Unable to reach to our server';
      },
      conflict: () {
        errorMessage = 'Error due to a conflict';
      },
      sendTimeout: () {
        errorMessage = 'Send timeout in connection with API server';
      },
      unableToProcess: () {
        errorMessage = 'Unable to process the data';
      },
      defaultError: (String error) {
        errorMessage = error;
      },
      formatException: () {
        errorMessage = 'Unexpected error occurred';
      },
      notAcceptable: () {
        errorMessage = 'Not acceptable';
      },
    );
    return errorMessage;
  }
}
