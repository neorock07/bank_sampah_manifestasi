import 'package:bank_sampah/Partials/Card/ItemStuff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget HistoryCard(context, {
  required double non, 
  required double organik, 
  required int poin, 
  required String asset,
  required String non_item, 
  required String organik_item,
  required String user, 
  required String name, 
  required String address
}) {
  return Container(
    height: 280.h,
    width: MediaQuery.of(context).size.width * 0.9,
    decoration: BoxDecoration(
      color: Color.fromRGBO(217, 217, 217, 1),
      borderRadius: BorderRadius.circular(10.dm),
    ),
    child: Stack(children: [
      Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 280.h,
          width: 120.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.dm),
            color: Colors.white,
            
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 100.dm,
            width: 80.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.dm),
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage(user),
                    fit: BoxFit.cover)),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 40.w),
        child: Align(
          alignment: Alignment.center,
          child: Container(
              height: 100.dm,
              width: 90.w,
              child: Text(
                "Nama : ${name}\n${address}",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
              height: 280.dm,
              width: 100.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Non-organik",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "${non.toStringAsFixed(2)} kg",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    non_item,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 10.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),

                  Text(
                    "Organik",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "${organik.toStringAsFixed(2)} kg",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    organik_item,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 10.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                  
                  Text(
                    "Total Poin : ${poin}",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: 90.w,
                    child: Divider(color: Colors.grey,)),
                  Text("Penukaran poin", style: TextStyle(
                    color: Colors.black, 
                    fontFamily: "Poppins", 
                    fontSize: 12.sp
                  ),),  
                  SizedBox(
                    height: 100.dm,
                    width: 80.dm,
                    child: ItemStuff(
                      context, 
                      aset: asset,
                      label: "$poin",
                      color: "a")
                  )
                ],
              )),
        ),
      ),
    ]),
  );
}
