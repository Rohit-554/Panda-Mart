
import 'package:flutter/material.dart';
import 'package:panda_mart/main.dart';
import 'package:panda_mart/views/auth/login_screen.dart';
import 'package:panda_mart/views/auth/register_screen.dart';
import 'package:panda_mart/views/home/home_screen.dart';

class AppRoutes{
  static Route onGenerateRoutes(RouteSettings settings){
    switch(settings.name){
      case '/login':
        return _materialRoute(LoginScreen());
      case '/home':
        return _materialRoute(const HomeScreen());
      case '/register':
        return _materialRoute(const RegisterScreen());
      default:
        return _materialRoute(LoginScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}