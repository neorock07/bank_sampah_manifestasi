import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/login');
    });
  }

   @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
       value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromRGBO(176, 201, 177, 1),
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(99, 215, 167, 1),
              Color.fromRGBO(176, 201, 177, 1)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Text("Bank Sampah", 
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontSize: 16.sp
                ),),
              )
            ]
          ),
        ), 
      ),
    );
  }
}