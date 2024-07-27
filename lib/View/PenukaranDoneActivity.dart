import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PenukaranDoneActivity extends StatefulWidget {
  PenukaranDoneActivity({ super.key, this.item_data});

  Map<String, dynamic>? item_data;

  @override
  _PenukaranDoneActivityState createState() => _PenukaranDoneActivityState();
}

class _PenukaranDoneActivityState extends State<PenukaranDoneActivity> {
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
         body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h,),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 150.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(217, 217, 217, 1),
                  borderRadius: BorderRadius.circular(10.dm)
                ),
                child: Center(
                  child: Text("Transaksi Selesai", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14.sp, 
                    
                  ),),
                ),
              ),
            ),
            SizedBox(
              height: 70.h,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                backgroundImage: AssetImage(widget.item_data!['image']),
                radius: 120.dm,
              ),
              Center(
                child: Text("SELESAI", style: TextStyle(
                  fontSize: 35.sp, 
                  fontFamily: "Bree",
                  color: Colors.red
                ),),
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
                    borderRadius: BorderRadius.circular(10.dm)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.dm),
                    child: Center(
                      child: Text("Poin ditukar : ${widget.item_data!['poin']}", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20.sp, 
                        
                      ),),
                    ),
                  ),
                ),
              ),
            ),
          ],
         ), 
      ),
    );
  }
}