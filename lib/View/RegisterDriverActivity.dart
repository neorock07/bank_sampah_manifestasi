import 'dart:developer';

import 'package:bank_sampah/Partials/Button/BaseButton.dart';
import 'package:bank_sampah/Partials/Button/OptionButton.dart';
import 'package:bank_sampah/Partials/Form/formPassword.dart';
import 'package:bank_sampah/Partials/Form/formText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterDriverActivity extends StatefulWidget {
  const RegisterDriverActivity({Key? key}) : super(key: key);

  @override
  _RegisterDriverActivityState createState() => _RegisterDriverActivityState();
}

class _RegisterDriverActivityState extends State<RegisterDriverActivity> {
  TextEditingController namaController = TextEditingController();
  TextEditingController waController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController konfController = TextEditingController();
  RxInt selectedOption = 1.obs;
  RxBool isVisible = true.obs;
  RxBool isVisible2 = true.obs;
  GlobalKey<FormState> global_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: global_key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Daftar Akun Driver",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Bree",
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FormText(context,
                        label: "Nama Lengkap", controller: namaController),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Obx(() {
                    log("Selected : ${selectedOption}");
                    
                    return Row(
                        children: [
                          OptionButton(context,
                              value: 1.obs,
                              group_value: selectedOption,
                              label: "L"),
                          OptionButton(context,
                              value: 2.obs,
                              group_value: selectedOption,
                              label: "P"),
                        ],
                      );
                  } ),
                ),
                
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FormText(context,
                        label: "No Hp(Whatsapp)",
                        controller: waController,
                        type: TextInputType.phone),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FormText(context,
                        label: "Username",
                        controller: usernameController,
                        type: TextInputType.text),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Obx(() => FormPassword(context,
                          label: "Password",
                          controller: passController,
                          isVisible: isVisible))),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Obx(() => FormPassword(context,
                          label: "Ulang Password",
                          controller: konfController,
                          isKonf: true,
                          sibling: passController,
                          isVisible: isVisible2))),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: BaseButton(context,
                      label: "Daftar",
                      height: 40.h,
                      width: MediaQuery.of(context).size.width * 0.4,
                      color: Colors.black,
                      fontColor: Colors.white, onTap: () {
                    if (global_key.currentState!.validate() == false) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        "mohon isi data dengan benar!",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12.sp,
                        ),
                      )));
                    } else {
                      Navigator.pushNamed(context, "/onmap_driver");
                    }
                  }),
                ),
                SizedBox(
                  height: 40.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
