import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ItemStuff(BuildContext context,{
  required String aset,
  required String label,
  required String color
}){
  return SizedBox(
    height: 100.h,
    width: 100.w,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 80.h,
          width: 80.w,
          decoration: BoxDecoration(
            border: Border.all(color: (color == "g")? Colors.green : Colors.grey, width: 2.dm),
            borderRadius: BorderRadius.circular(10.dm),
            image: DecorationImage(
              image: AssetImage(aset),
              fit: BoxFit.fill
              )
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:70.h),
          child: Container(
            width: 100.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 232, 232, 232),
              borderRadius: BorderRadius.circular(10.dm)
            ),
            child: Center(child: Text(label, style: TextStyle(
              color: Colors.black, 
              fontFamily: "Poppins", 
              fontSize: 14.sp
            ),),),
          ),
          
        )
      ],
    ),
  );
}