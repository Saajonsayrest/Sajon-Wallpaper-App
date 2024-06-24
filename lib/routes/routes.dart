import 'package:untitled1/feature/dashboard/view/dashboard_view.dart';
import 'package:untitled1/feature/dashboard/view/favorites_view.dart';
import 'package:untitled1/feature/dashboard/view/homepage_view.dart';
import 'package:untitled1/feature/dashboard/view/profile_view.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/register_view.dart';

class Routes {
  static var routes = {
    DashBoardScreen.routeName: (ctx) => const DashBoardScreen(),
    HomepageView.routeName: (ctx) => const HomepageView(),
    FavoriteView.routeName: (ctx) => const FavoriteView(),
    ProfileView.routeName: (ctx) => const ProfileView(),
    RegisterView.routeName: (ctx) => const RegisterView(),
    SignInScreen.routeName: (ctx) => SignInScreen(),
    // UserView.routeName: (ctx) => const UserView(),
  };
}
