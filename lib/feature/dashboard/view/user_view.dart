// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:untitled1/feature/dashboard/provider/provider.dart';
//
// class UserView extends ConsumerWidget {
//   const UserView({super.key});
//
//   static const routeName = '/user';
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final data = ref.watch(userProvider(''));
//
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text('Test App'),
//         ),
//         body: RefreshIndicator(
//           onRefresh: () async => ref.refresh(userProvider('')),
//           child: data.when(data: (data) {
//             return ListView.builder(
//                 itemCount: data.data.length,
//                 itemBuilder: (context, index) {
//                   final details = data.data[index];
//
//                   return ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(details.avatar!),
//                     ),
//                     title: Text(details.firstName),
//                     subtitle: Text(details.lastName),
//                   );
//                 });
//           }, error: (error, _) {
//             return Text(error.toString());
//           }, loading: () {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }),
//         ));
//   }
// }
