import 'dart:developer';

import 'package:bank_sampah/ViewModel/ItemPickedController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

var pickedController = Get.put(ItemPickedController());

Widget ItemCalculateCard(
  BuildContext context, {
  required String asset,
  required List<dynamic> item,
  required Set<String> selected,
  required double height,
  required bool isOrganik,
  required List<TextEditingController> controllers,
}) {
  RxBool isChecked = false.obs;
  List<Widget> widgets = [];
  List<Widget> widgets_field = [];

  widgets = item
      .map<Widget>((e) => Obx(() => CheckboxListTile(
          title: Text(
            e["item"],
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Poppins",
              fontSize: 14.sp,
            ),
          ),
          value: e["kondisi"].value,
          onChanged: (val) {
            e["kondisi"].value = val!;
            if (e["kondisi"] == true) {
              selected.add(e["item"]);
            } else {
              selected.remove(e["item"]);
            }

            log("selected : ${selected}");
          })))
      .toList();

  widgets_field = controllers
      .map<Widget>((e) => Padding(
            padding: EdgeInsets.all(3.dm),
            child: SizedBox(
              width: 80.w,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  // pickedController.total_non.value += double.parse(val);
                  try {
                    if (isOrganik == false) {
                      log("item index : ${controllers.indexOf(e)}");
                      int index = controllers.indexOf(e);
                      pickedController.map_controller_index[index] =
                          double.parse(val);
                      pickedController.total_non.value = 0;
                      for (var i
                          in pickedController.map_controller_index.values) {
                        pickedController.total_non.value += i;
                      }
                    } else {
                      log("item index : ${controllers.indexOf(e)}");
                      int index = controllers.indexOf(e);
                      pickedController.map_controller_organik_index[index] =
                          double.parse(val);
                      pickedController.total_organik.value = 0;
                      for (var i in pickedController
                          .map_controller_organik_index.values) {
                        pickedController.total_organik.value += i;
                      }
                    }
                    pickedController.total_point.value =  ((pickedController.total_organik.value + pickedController.total_non.value) * 200).toInt(); 
                  } catch (e) {
                    log(e.toString());
                  }
                },
                controller: e,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontSize: 12.sp),
                decoration: InputDecoration(
                    suffix: Text(
                  "Kg",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontSize: 12.sp),
                )),
              ),
            ),
          ))
      .toList();

  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    height: height,
    decoration: BoxDecoration(
        color: Color.fromRGBO(217, 217, 217, 1),
        borderRadius: BorderRadius.circular(10.dm)),
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
                    image: AssetImage(
                      asset,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Expanded(
            child: Container(
                height: height - 20,
                width: 100.w,
                child: Column(
                  children: widgets,
                )),
          ),
          Container(
              height: height - 20,
              width: 50.w,
              child: Column(
                children: widgets_field,
              )),
        ],
      ),
    ),
  );
}
