import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/api/di/injection.dart';
import 'package:untitled1/api/error/network_exceptions.dart';
import 'package:untitled1/api/network/rest_client.dart';
import 'package:untitled1/api/network/run_api_zoned.dart';
import 'package:untitled1/feature/homepage/models/homepage_model.dart';

final repository = Provider<Repository>(
    (ref) => RepositoryImpl(api: ref.watch(restClientHomepageProvider)));

abstract class Repository {
  Future<Either<NetworkExceptions, HomepageModel>> getHomepage(
      {String? searchQuery});
}

class RepositoryImpl implements Repository {
  RepositoryImpl({required RestClient api}) : _api = api;
  final RestClient _api;

  @override
  Future<Either<NetworkExceptions, HomepageModel>> getHomepage(
      {String? searchQuery}) {
    return runApiZoned(fn: () async {
      final query = searchQuery?.isNotEmpty ?? false ? searchQuery : 'all';
      final res = await _api.getHomepage(
        searchQuery: query,
      );
      if (res.photos!.isNotEmpty) {
        return right(res);
      } else {
        return left(
          const NetworkExceptions.defaultError(/*res.message!*/ "Sorry error"),
        );
      }
    }, exceptionHandler: (dynamic e) {
      return left(NetworkExceptions.getDioException(e));
    });
  }
}
