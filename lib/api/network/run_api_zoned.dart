import 'dart:developer';

import 'package:flutter/foundation.dart';

/// Used to abstract the error handling when making API requests.
/// For a function [fn], executes the [exceptionHandler]
/// and catches the error. Also logs the error.
///
/// This function is based on the premise that exceptions should not
/// propagate further unhandled from the repository layer.
Future<T> runApiZoned<T>({
  //todo: change to api scope?
  required Future<T> Function() fn,
  required T Function(dynamic e) exceptionHandler,
}) async {
  try {
    // final connection = await InternetConnectionChecker().hasConnection;
    // if (connection == false) return exceptionHandler(e);
    final response = await fn();
    return response;
  } catch (e, stk) {
    if (kDebugMode) {
      log(
        '$fn: An error occurred when getting ${fn.toString()}.',
        name: fn.toString(),
        error: e,
        stackTrace: stk,
      );
    }
    return exceptionHandler(e);
  }
}

// todo: create a extenion method for this instead?
// extension FutureX<T> on Future<T> {
//   Future<T> withExceptionHandler(
//     T Function() exHandler,
//   ) async {
//     try {
//       return this;
//     } catch (e, stk) {
//       log(
//         'An error occurred when calling $exHandler.',
//         name: '$this',
//         error: e,
//         stackTrace: stk,
//       );
//       return exHandler();
//     }
//   }
// }
