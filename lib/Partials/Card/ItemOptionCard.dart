import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


Widget ItemOptionCard(BuildContext context, {
  required String asset,
  required List<dynamic> item,
  required Set<String> selected,
  required double height
}){
  RxBool isChecked = false.obs;
  List<Widget> widgets = [];

  widgets = item.map<Widget>((e) => Obx(() => CheckboxListTile(
            title: Text(e["item"], style: TextStyle(
              color: Colors.black, 
              fontFamily: "Poppins", 
              fontSize: 14.sp, 
            ),),
            value: e["kondisi"].value,
            onChanged: (val){
                e["kondisi"].value = val!;
                if(e["kondisi"] == true){
                  selected.add(e["item"]);
                }else{
                  selected.remove(e["item"]);
                }

                log("selected : ${selected}");

            }))).toList();

  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    height: height,
    decoration: BoxDecoration(
      color: Color.fromRGBO(217, 217, 217, 1),
      borderRadius: BorderRadius.circular(10.dm)
    ),
    child: Padding(
      padding: EdgeInsets.all(5.dm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 80.dm,
              width: 80.dm,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.dm),
                image: DecorationImage(
                  image: AssetImage(asset,),
                  fit: BoxFit.cover
                   ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: height - 20,
              width: 80.w,
              child: Column(
                children: widgets,
              )
            ),
          )
        ],
      ),
    ),
  );
}