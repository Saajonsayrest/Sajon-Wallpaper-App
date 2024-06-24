import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app/logger/riverpod_logger.dart';
import 'package:untitled1/bootstrap.dart';
import 'package:untitled1/feature/dashboard/view/dashboard_view.dart';
import 'package:untitled1/feature/google_sign_in/view/sign_in_screen.dart';
import 'package:untitled1/routes/routes.dart';

void main() {
  bootstrap(
    () => ProviderScope(
      observers: [
        ProviderLoggingObserver(),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void _setScreenSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      // Set screen size for mobile
      ScreenUtil.init(
        context,
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
      );
    } else {
      // Set screen size for non-mobile (assume it's a tablet or TV)
      ScreenUtil.init(
        context,
        designSize: const Size(1440, 1024),
        minTextAdapt: true,
        splitScreenMode: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _setScreenSize(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashBoardScreen(),
      routes: Routes.routes,
    );
  }
}

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  static const routeName = '/signin';
  final GoogleSignInHelper _googleSignInHelper = GoogleSignInHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            User? user = await _googleSignInHelper.signInWithGoogle();
            if (user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashBoardScreen(/*user*/),
                ),
              );
            } else {
              // Handle sign-in failure
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Sign-in failed'),
                ),
              );
            }
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}
