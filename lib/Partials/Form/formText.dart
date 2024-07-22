import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget FormText(BuildContext context, {
  required String label,
  required TextEditingController controller,
  TextInputType type = TextInputType.text,
  int maxline = 1
}){
    return TextFormField(
        controller: controller,
        keyboardType: type,
        maxLines: maxline,
        style: TextStyle(
          fontFamily: "Poppins",
          color: Colors.black,
          fontSize: 14.sp
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(3.dm),
          label: Text(label, 
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Bree",
            fontSize: 14.sp
          ),),
        ),
        validator: (String? sr){
          if(sr!.isEmpty){
            return "field $label tidak boleh kosong!";
          }
        },   
    );
}