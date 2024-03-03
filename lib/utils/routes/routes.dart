import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_provider/utils/routes/routes_name.dart';
import 'package:mvvm_provider/view/home_screen.dart';
import 'package:mvvm_provider/view/login_screen.dart';
import 'package:mvvm_provider/view/signup_screen.dart';

import '../../view/splash_view.dart';

class Routes
{

  static Route<dynamic> generateRoute(RouteSettings settings)
  {
switch(settings.name)
    {
  case RoutesName.home:
    return MaterialPageRoute(builder: (context) => const HomeScreen(),);
    case RoutesName.login:
    return MaterialPageRoute(builder: (context) => const LoginScreen(),);
  case RoutesName.signup:
    return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case RoutesName.splash:
    return MaterialPageRoute(builder: (context) => const SplashView());
  default:
    return MaterialPageRoute(builder: (_){
      return const Scaffold(
        body: Center(
          child: Text("No route defined"),
        ),
      );
    });
}
  }

}