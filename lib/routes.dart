import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'pages/register/register.dart';
import 'pages/login/login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch(settings.name) {
      case '/login': return MaterialPageRoute(builder: (context) => LoginPage());
      case '/register': return MaterialPageRoute(builder: (context) => RegisterPage());
      default: debugPrint('Error in routing');
    }
  }
}