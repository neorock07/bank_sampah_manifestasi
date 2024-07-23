import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

Widget DashboardCard(BuildContext context, {
  required Color background
}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.dm),
        color: Color.fromRGBO(217, 217, 217, 1)),
    child: Padding(
      padding: EdgeInsets.all(8.dm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 80.h,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(10.dm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.dollarSign,
                      color: Colors.black,
                    ),
                    Text(
                      "Saldo",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 3.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Poin",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontFamily: "Poppins",
                        ),
                    ),
                    SizedBox(width: 2.w,),
                    Text(
                      "100,000",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: "Poppins",
                            fontWeight: FontWeight.bold
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Container(
            height: 80.h,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(10.dm),
            ),
            child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sampah\nTerkumpul",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontFamily: "Poppins",
                          ),
                    ),
                    SizedBox(width: 2.w,),
                    Text(
                      "61,5 kg",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: "Poppins",
                            fontWeight: FontWeight.bold
                          ),
                    ),
                  ],
                ),
          ),
        ],
      ),
    ),
  );
}
