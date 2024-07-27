import 'package:bank_sampah/View/BottomNavPage.dart';
import 'package:bank_sampah/View/BottomNavPageDriver.dart';
import 'package:bank_sampah/View/CalculateItemActivity.dart';
import 'package:bank_sampah/View/HomeActivity.dart';
import 'package:bank_sampah/View/LoginActivity.dart';
import 'package:bank_sampah/View/NewsActivity.dart';
import 'package:bank_sampah/View/OnMap.dart';
import 'package:bank_sampah/View/OnMapDriver.dart';
import 'package:bank_sampah/View/PengirimanDoneActivity.dart';
import 'package:bank_sampah/View/PenjemputanActivity.dart';
import 'package:bank_sampah/View/PenukaranDoneActivity.dart';
import 'package:bank_sampah/View/RegisterActivity.dart';
import 'package:bank_sampah/View/RegisterDriverActivity.dart';
import 'package:bank_sampah/View/ShopActivity.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginActivity());     
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterActivity());
      case '/register_driver':
        return MaterialPageRoute(builder: (_) => RegisterDriverActivity());
      case '/home':
        return MaterialPageRoute(builder: (_) => BottomNavPage());
      case '/penjemputan':
        return MaterialPageRoute(builder: (_) => PenjemputanActivity());
      case '/calculate':
        return MaterialPageRoute(builder: (_) => CalculateItemActivity());
      case '/onmap':
        return MaterialPageRoute(builder: (_) => OnMap());
      case '/onmap_driver':
        return MaterialPageRoute(builder: (_) => OnMapDriver());
      case '/penukaran':
        return MaterialPageRoute(builder: (_) => ShopActivity());
      case '/news':
        return MaterialPageRoute(builder: (_) => NewsActivity());
      case '/penukaran_done':
        return MaterialPageRoute(builder: (_) => PenukaranDoneActivity());
      case '/pengiriman_done':
        return MaterialPageRoute(builder: (_) => PengirimanDoneActivity());
      case '/btm_driver':
        return MaterialPageRoute(builder: (_) => BottomNavPageDriver());
    
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
