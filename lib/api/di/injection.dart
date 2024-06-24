import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/api/network/api_endpoints.dart';
import 'package:untitled1/api/network/rest_client.dart';
import 'package:untitled1/interceptors/pretty_dio_logger.dart';

String get baseUrl => kBaseUrl;

final dioProvider = Provider.family<Dio, String>((ref, url) {
  return Dio()
    ..options.baseUrl = url
    ..options.followRedirects = false
    ..options.connectTimeout = const Duration(seconds: 10)
    ..options.receiveTimeout = const Duration(seconds: 10)
    ..options.validateStatus = ((status) => status! < 401)
    ..interceptors.addAll(
      [
        if (kDebugMode) PrettyDioLogger(),
        // ref.watch(authInterceptor),
      ],
    );
});

final homepageProvider = Provider.family<Dio, String>((ref, url) {
  final dio = Dio()
    ..options.baseUrl = url
    ..options.followRedirects = false
    ..options.connectTimeout = const Duration(seconds: 10)
    ..options.receiveTimeout = const Duration(seconds: 10)
    ..options.headers['Authorization'] =
        apiKey // Directly adding the authorization header
    ..options.validateStatus = ((status) => status! < 405)
    ..interceptors.addAll(
      [
        if (kDebugMode) PrettyDioLogger(),
      ],
    );
  return dio;
});

final restClientProvider = Provider(
  (ref) => RestClient(ref.watch(dioProvider(baseUrl))),
);

final restClientHomepageProvider = Provider(
  (ref) => RestClient(ref.watch(homepageProvider(baseUrl))),
);
