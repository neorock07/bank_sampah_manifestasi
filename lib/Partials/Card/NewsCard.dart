import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget NewsCard(BuildContext context, {required String asset}) {
  return Container(
    height: 80.h,
    width: MediaQuery.of(context).size.width * 0.8,
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Berita: Kerusakan Hutan Kalimantan", style: TextStyle(
                  color: Colors.black, 
                  fontFamily: "Poppins", 
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp
                ),),
                
                Text("10 Juni 2024", style: TextStyle(
                  color: Colors.grey, 
                  fontFamily: "Poppins", 
                  fontSize: 12.sp
                ),),
          
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right:5.w),
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 60.dm,
              width: 60.dm,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.dm),
                image: DecorationImage(image: AssetImage(asset), fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
