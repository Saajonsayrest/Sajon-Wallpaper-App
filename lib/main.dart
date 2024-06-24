import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app/logger/riverpod_logger.dart';
import 'package:untitled1/app/view/awsome_snackbar.dart';
import 'package:untitled1/bootstrap.dart';
import 'package:untitled1/feature/dashboard/view/dashboard_view.dart';
import 'package:untitled1/feature/google_auth_service/google_auth_service.dart';
import 'package:untitled1/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyDJcP0cmCGwsrN-NQswpIR139l0w-w2OrY',
      appId: '1:883104796432:android:93fdcf526f3126db739f95',
      messagingSenderId: '883104796432',
      projectId: 'vrit-c1e5e',
    ));
  }

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
      home: FirebaseAuth.instance.currentUser != null
          ? const DashBoardScreen()
          : SignInScreen(),
      routes: Routes.routes,
    );
  }
}

class SignInScreen extends StatelessWidget {
  static const routeName = '/signin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final AuthService authService = AuthService();
            User? user = await authService.signInWithGoogle();
            if (user != null) {
              // Navigate to DashboardScreen on successful sign-in
              Navigator.pushReplacementNamed(
                  context, DashBoardScreen.routeName);
            } else {
              awsomeSnackbar(context, 'Failed', 'Failed to sign in with Google',
                  ContentType.failure);
            }
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}
