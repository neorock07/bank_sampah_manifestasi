import 'package:bank_sampah/View/HomeActivity.dart';
import 'package:bank_sampah/View/LoginActivity.dart';
import 'package:bank_sampah/View/RegisterActivity.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginActivity());     
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterActivity());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeActivity());
    
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text("Error!\npage not found 404"),
        ),
      );
    });
  }
}
