import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget DriverCard(context, {required String asset, required double jarak, required String name}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    height: 100.h,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10.dm)),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left:10.w),
          child: Container(
            height: 80.dm,
            width: 80.dm,
            decoration:
                BoxDecoration(
                  borderRadius: BorderRadius.circular(5.dm),
                  image: DecorationImage(image: AssetImage(asset), fit: BoxFit.cover)),
          ),
        ),
        SizedBox(width: 10.w,),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(
                color: Colors.black, 
                fontFamily: "Poppins", 
                fontSize: 23.sp, 
                fontWeight: FontWeight.bold
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.motorcycle, color: Colors.red,size: 15.dm,),
                  SizedBox(width: 2.w,),
                  Text("$jarak km dari lokasi Anda", style: TextStyle(
                    color: Colors.grey, 
                    fontFamily: "Poppins", 
                    fontSize: 14.sp, 
                    fontWeight: FontWeight.normal
                  ),),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
