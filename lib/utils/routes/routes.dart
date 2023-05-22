
import 'package:flutter/material.dart';
import 'package:practicing_mvvm_architecture/utils/routes/routes_name.dart';
import 'package:practicing_mvvm_architecture/view/home_screen.dart';
import 'package:practicing_mvvm_architecture/view/login_screen.dart';
import 'package:practicing_mvvm_architecture/view/signup_view.dart';
import 'package:practicing_mvvm_architecture/view/spash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LogInScreen());

      case RoutesName.signup:
        return MaterialPageRoute(builder: (BuildContext context) => const SignupView());

      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text("No Route Defined"),
            ),
          );
        });

    }
  }
}