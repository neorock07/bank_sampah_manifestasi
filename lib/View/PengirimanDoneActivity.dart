import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PengirimanDoneActivity extends StatefulWidget {
  PengirimanDoneActivity({super.key, this.poin});

  //buat untuk menerima poin dari halaman penjemputan
  int? poin;
  @override
  _PengirimanDoneActivityState createState() => _PengirimanDoneActivityState();
}

class _PengirimanDoneActivityState extends State<PengirimanDoneActivity> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color.fromRGBO(66, 215, 167, 1),
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(66, 215, 167, 1),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 150.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(217, 217, 217, 1),
                      borderRadius: BorderRadius.circular(10.dm)),
                  child: Center(
                    child: Text(
                      "Transaksi Selesai",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 70.h,
              ),
              Stack(alignment: Alignment.center, children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/image.png"),
                  radius: 120.dm,
                ),
                Center(
                  child: Text(
                    "SELESAI",
                    style: TextStyle(
                        fontSize: 35.sp, fontFamily: "Bree", color: Colors.black),
                  ),
                )
              ]),
              SizedBox(
                height: 100.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: IntrinsicWidth(
                  child: Container(
                    // width: 150.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(217, 217, 217, 1),
                        borderRadius: BorderRadius.circular(10.dm)),
                    child: Padding(
                      padding: EdgeInsets.all(10.dm),
                      child: Center(
                        //untuk menampilkan poin yang diterima
                        child: Text(
                          "Terkirim : ${widget.poin}",
                          // "Terkirim",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
