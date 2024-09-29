import 'package:flutter/material.dart';
import 'package:sms_admin/constants/bottom_page.dart';
import 'package:sms_admin/feat/auth/screens/auth-screen.dart';
import 'package:sms_admin/feat/auth/screens/login.dart';
import 'package:sms_admin/feat/auth/screens/signup.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginPage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => LoginPage());
    case SignupPage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => SignupPage());
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => AuthScreen());
      case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => BottomBar());

    // case ApplicationScreen.routeName:
    //   var club = routeSettings.arguments as Club;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => ApplicationScreen(
    //             club: club,
    //           ));

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen does not exist'),
                ),
              ));
  }
}
