import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget OptionButton(BuildContext context, {
  required RxInt value,
  required RxInt group_value,
  required String label
}){
  return Column(
    children: [
      Radio(
        value: value.value,
        groupValue: group_value.value,
        onChanged: (vp){
           group_value.value = vp!; 
        }),
      Text(label, style: TextStyle(
        color: Colors.black, 
        fontFamily: "Poppins", 
        fontSize: 12.sp
      ),)  
    ],
  );
}