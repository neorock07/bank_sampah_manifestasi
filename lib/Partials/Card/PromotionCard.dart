import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget PromotionCard(BuildContext context, {
  required String asset
}){
  return Container(
    height: 130.h,
    width: MediaQuery.of(context).size.width * 0.8,
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top:30.h),
          child: Container(
            height: 100.h,
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.dm),
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(99, 215, 167, 1),
                Color.fromRGBO(237, 243, 237, 1)
              ], begin: Alignment.centerLeft, end: Alignment.centerRight)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left:10.w, top: 5.h),
                  child: Text("Beli 2\nGratis 2", style: TextStyle(
                    color: Colors.black, 
                    fontFamily: "Poppins", 
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold    
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.only(left:10.w, top: 3.h),
                  child: IntrinsicWidth(
                    child: Container(
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 227, 227, 227),
                        borderRadius: BorderRadius.circular(10.dm),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2.dm),
                        child: Center(
                          child: Text("Rp.40,000", style: TextStyle(
                            color: Colors.black, 
                            fontFamily: "Poppins", 
                            fontSize: 14.sp
                          )),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top:5.h),
            child: Container(
              height: 100.dm,
              width: 100.dm,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 227, 227, 227),
                borderRadius: BorderRadius.circular(10.dm),
                image: DecorationImage(
                  image: AssetImage(asset),
                  fit: BoxFit.fill 
                  ),
              ),
            ),
          ),
        ),

      ],
    ),
  );
}