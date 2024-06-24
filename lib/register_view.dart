import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/extensions/padding_extensions.dart';
import 'package:untitled1/feature/dashboard/models/register_model.dart';
import 'package:untitled1/interceptors/pretty_dio_logger.dart';

final registerProvider =
    StateNotifierProvider<RegisterController, AsyncValue<RegisterModel?>>(
        (ref) => RegisterController());

class RegisterController extends StateNotifier<AsyncValue<RegisterModel?>> {
  RegisterController() : super(const AsyncValue.loading());

  Future<void> postRegister(String username, String password) async {
    try {
      final dio = Dio()
        ..options.validateStatus = ((status) => status! < 401)
        ..interceptors.add(PrettyDioLogger());
      final response = await dio.post(
        'https://reqres.in/api/register',
        data: jsonEncode({'username': username, 'password': password}),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if (response.statusCode == 200) {
        final jsonData = response.data;
        state = AsyncValue.data(RegisterModel.fromJson(jsonData));
      } else {
        state = AsyncValue.error('Registration failed', StackTrace.current);
      }
    } catch (e, _) {
      state = AsyncValue.error(e.toString(), _);
    }
  }
}

class RegisterView extends HookConsumerWidget {
  const RegisterView({super.key});
  static const routeName = '/register';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isObscure = useState<bool>(true);
    final registerController = ref.watch(registerProvider.notifier);
    final data = ref.watch(registerProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Register'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Username'),
          TextFormField(
            controller: userController,
          ),
          const Text('Password').pT(50.h),
          TextField(
            controller: passwordController,
            obscureText: isObscure.value,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      isObscure.value = !isObscure.value;
                    },
                    icon: Icon(isObscure.value
                        ? Icons.visibility_off
                        : Icons.visibility))),
          ),
          GestureDetector(
            onTap: () async => await registerController.postRegister(
                userController.text, passwordController.text),
            child: Container(
                width: 100.w,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.red)),
                child: data.when(data: (data) {
                  return const Text('Submit');
                }, error: (e, _) {
                  return const Text('error');
                }, loading: () {
                  return const Center(child: CircularProgressIndicator());
                })).pT(50.h),
          )
        ],
      ).pX(40.w),
    );
  }
}
