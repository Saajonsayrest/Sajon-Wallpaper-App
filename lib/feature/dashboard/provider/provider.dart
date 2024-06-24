// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:untitled1/api/error/network_exceptions.dart';
// import 'package:untitled1/api/responses/default_response.dart';
// import 'package:untitled1/feature/dashboard/repository/repository.dart';
//
// final userProvider = StateNotifierProvider.family
//     .autoDispose<UserProvider, AsyncValue<DefaultResponse>, String?>(
//   (ref, pageName) =>
//       UserProvider(repository: ref.watch(repository), pageName: pageName),
// );
//
// class UserProvider extends StateNotifier<AsyncValue<DefaultResponse>> {
//   UserProvider({required this.repository, this.pageName})
//       : super(const AsyncValue.loading()) {
//     getContents(/*pageName: pageName*/);
//   }
//
//   final String? pageName;
//   final Repository repository;
//
//   Future<void> getContents() async {
//     state = const AsyncValue.loading();
//     final result = await repository.getContents();
//     result.fold(
//       (failure) {
//         print('xxx$failure');
//         state = AsyncValue.error(
//             NetworkExceptions.getErrorMessage(failure), StackTrace.current);
//       },
//       (success) {
//         state = AsyncData(success);
//       },
//     );
//   }
// }
