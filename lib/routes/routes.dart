import 'package:untitled1/feature/dashboard/view/dashboard_view.dart';
import 'package:untitled1/feature/favorites/view/favorites_view.dart';
import 'package:untitled1/feature/homepage/view/homepage_view.dart';
import 'package:untitled1/feature/profile/view/profile_view.dart';
import 'package:untitled1/feature/sign_in/sign_in_view.dart';

class Routes {
  static var routes = {
    DashBoardScreen.routeName: (ctx) => const DashBoardScreen(),
    HomepageView.routeName: (ctx) => const HomepageView(),
    FavoriteView.routeName: (ctx) => const FavoriteView(),
    ProfileView.routeName: (ctx) => const ProfileView(),
    SignInScreen.routeName: (ctx) => SignInScreen(),
  };
}
