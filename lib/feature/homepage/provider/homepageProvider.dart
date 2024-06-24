import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/api/error/network_exceptions.dart';
import 'package:untitled1/feature/homepage/models/homepage_model.dart';
import 'package:untitled1/feature/homepage/repository/repository.dart';

final homepageProvider =
    StateNotifierProvider.autoDispose<UserProvider, AsyncValue<HomepageModel>>(
  (ref) => UserProvider(repository: ref.watch(repository)),
);

class UserProvider extends StateNotifier<AsyncValue<HomepageModel>> {
  UserProvider({required this.repository}) : super(const AsyncValue.loading()) {
    getHomepage();
  }

  final Repository repository;

  Future<void> getHomepage({String? searchQuery}) async {
    state = const AsyncValue.loading();
    final result = await repository.getHomepage(searchQuery: searchQuery);
    result.fold(
      (failure) {
        debugPrint('xxx$failure');
        state = AsyncValue.error(
            NetworkExceptions.getErrorMessage(failure), StackTrace.current);
      },
      (success) {
        state = AsyncData(success);
      },
    );
  }
}
