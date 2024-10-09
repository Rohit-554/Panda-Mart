
import 'package:flutter/material.dart';
import 'package:panda_mart/main.dart';

class AppRoutes{
  static Route onGenerateRoutes(RouteSettings settings){
    switch(settings.name){
      case '/home':
        return _materialRoute(const MyApp());
      default:
        return _materialRoute(const MyApp());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}