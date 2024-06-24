import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/app/view/awsome_snackbar.dart';
import 'package:untitled1/app/view/decorations.dart';
import 'package:untitled1/app/view/exit_dialog.dart';
import 'package:untitled1/extensions/padding_extensions.dart';
import 'package:untitled1/feature/dashboard/view/dashboard_view.dart';
import 'package:untitled1/feature/sign_in/google_auth_service.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/signin';

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show exit confirmation dialog
        final shouldExit = await showDialog(
          context: context,
          builder: (context) => const ExitDialog(),
        );

        return shouldExit ?? false;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/vrit.png',
                height: 240.h,
                width: 240.w,
              ).pB(30.h),
              Text(
                'Sign In',
                style: TextStyle(fontSize: 35.sp, color: Colors.teal),
              ).pB(35.h),
              GestureDetector(
                onTap: () async {
                  final AuthService authService = AuthService();
                  User? user = await authService.signInWithGoogle();
                  if (user != null) {
                    // Navigate to DashboardScreen on successful sign-in
                    Navigator.pushReplacementNamed(
                        context, DashBoardScreen.routeName);
                  } else {
                    awsomeSnackbar(context, 'Failed',
                        'Failed to sign in with Google', ContentType.failure);
                  }
                },
                child: const SignInWidgets(
                  title: 'Google',
                  imagePath: 'assets/images/google.png',
                ),
              ).pB(30.h),
              const SignInWidgets(
                title: 'Apple',
                imagePath: 'assets/images/apple.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInWidgets extends StatelessWidget {
  const SignInWidgets({
    super.key,
    required this.title,
    required this.imagePath,
  });

  final String title, imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getShadowDecoration(),
      height: 140.h,
      width: 140.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 100.h,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20.sp),
          ),
        ],
      ),
    );
  }
}
