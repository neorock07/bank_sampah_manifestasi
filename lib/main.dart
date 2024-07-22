import 'package:bank_sampah/Route/Routes.dart';
import 'package:bank_sampah/View/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child){
        return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.generateRoute,
        title: 'Bank Sampah',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(99, 215, 167, 1)),
          useMaterial3: true,
        ),
        home: child,
      );
      },
      child: SplashScreen(), 

    );
  }
}

