import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget FormPassword(BuildContext context,
    {required String label,
    required TextEditingController controller,
    bool isKonf = false,
    TextEditingController? sibling,
    required RxBool isVisible}) {
  return TextFormField(
    controller: controller,
    obscuringCharacter: "*",
    obscureText: isVisible.value,
    style:
        TextStyle(fontFamily: "Poppins", color: Colors.black, fontSize: 14.sp),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.all(3.dm),
        label: Text(
          label,
          style: TextStyle(
              color: Colors.black, fontFamily: "Bree", fontSize: 14.sp),
        ),
        suffixIcon: IconButton(
            onPressed: () {
              isVisible.value = !isVisible.value;
            },
            icon: (isVisible.value)
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off))),
    validator: (String? sr) {
      if (sr!.isEmpty) {
        return "field $label tidak boleh kosong!";
      }

      if (isKonf == true) {
        if (sr.isEmpty || sibling!.text != sr) {
          return "password tidak sesuai";
        }
      }
    },
  );
}
