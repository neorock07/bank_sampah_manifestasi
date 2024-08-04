import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';


Widget TotalItemCard(
  BuildContext context, {
  required Color background,
  required RxDouble total_non,
  required RxDouble total_organik,
  required RxInt total_point,
  required RxString items_non,
  required RxString items_organik
}) {
  return Column(
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.dm),
            color: Color.fromRGBO(217, 217, 217, 1)),
        child: Padding(
          padding: EdgeInsets.all(8.dm),
          child: Column(
            children: [
              Text(
                "TOTAL BERAT",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontSize: 14.sp,
                ),
              ),
              Row(
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
                        Text(
                          "Non-Organik",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                              "${total_non.value.toStringAsFixed(2)} KG",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            items_non.value,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontFamily: "Poppins",
                            ),
                          ),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Organik",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                              "${total_organik.value.toStringAsFixed(2)} KG",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            items_organik.value,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 2.h,
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 40.h,
        color: Color.fromRGBO(217, 217, 217, 1),
        child: Center(
          child: Text(
            "Total Poin : ${total_point.value}",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                fontFamily: "Poppins"),
          ),
        ),
      )
    ],
  );
}
