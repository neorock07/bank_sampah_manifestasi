import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

Widget HomeButton(BuildContext context, {
  required String label,
  required String asset,
}) {
  return Container(
    height: 95.h,
    // color: Colors.red,
    child: Stack(children: [
      Padding(
        padding: EdgeInsets.only(top:40.h),
        child: Container(
          height: 70.h,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.dm),
              color: Color.fromRGBO(217, 217, 217, 1)),
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right:20.w),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(label, style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontSize: 16.sp
                  ),),
                  Icon(Icons.arrow_right_alt_sharp, color: Colors.black,size: 30.dm,)
                ],
              ),
            ),
          ),    
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top:40.h),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 70.h,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.dm)),
        ),
      ),
       Padding(
         padding: EdgeInsets.only(left:10.w, bottom: 10.h),
         child: Image.asset(
          asset,
          height: 80.dm,
          width: 80.dm,
          fit: BoxFit.cover,
             ),
       ),
    ]),
  );
}
