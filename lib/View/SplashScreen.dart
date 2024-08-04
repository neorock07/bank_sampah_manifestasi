import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? name;

  //fungsi untuk mendapatkan data role, 
  //nantinya digunakan untuk cek role user yang login
  Future<void> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString("role")!;
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    //panggil fungsi get data role
    getUserData();
    //delay selama 3 detik saat menampilkan halaman splashscreen
    Future.delayed(const Duration(seconds: 3), () {
      if (name != null) {
        //jika role adalah user maka masuk ke halaman home
        if (name == "user") {
          Navigator.pushReplacementNamed(context, '/home');
        }else{
          //jika role adalah driver maka masuk ke halaman daftar penjemputan terdekat
          Navigator.pushReplacementNamed(context, '/list_user');
        }
      } else {
        //jika data role tidak ada / null maka masuk ke login
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }


  //dispose halaman splash screen ketika pindah ke halaman lain
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
      //atur warna background dan widget text dengan posisi center
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(99, 215, 167, 1),
            Color.fromRGBO(176, 201, 177, 1)
          ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                  child: Text(
                    "Bank Sampah",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 16.sp),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
