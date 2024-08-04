import 'dart:developer';

import 'package:bank_sampah/Partials/Button/BaseButton.dart';
import 'package:bank_sampah/Partials/Button/OptionButton.dart';
import 'package:bank_sampah/Partials/Form/formPassword.dart';
import 'package:bank_sampah/Partials/Form/formText.dart';
import 'package:bank_sampah/ViewModel/AuthController.dart';
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
  //class untuk register role driver
  //inisiasi controller untuk tiap text-field untuk mengisi data
  TextEditingController namaController = TextEditingController();
  TextEditingController waController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController konfController = TextEditingController();
  //inisiasi kondisi untuk radio button 
  RxInt selectedOption = 1.obs;
  RxBool isVisible = true.obs;
  RxBool isVisible2 = true.obs;
  //inisiasi global key untuk text-field
  GlobalKey<FormState> global_key = GlobalKey<FormState>();
  //inisiasi controller authentication
  AuthController authController = Get.put(AuthController());

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
          //buat widget parent Form sebagai parent widget text-field
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
                //text untuk title halaman
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
                //form untuk nama 
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
                //widget radio button untuk field jenis kelamin
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
                  }),
                ),
                SizedBox(
                  height: 20.h,
                ),
                //form untuk no wa
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
                //form untuk email
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FormText(context,
                        label: "Email",
                        controller: usernameController,
                        type: TextInputType.emailAddress),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                //form untuk password
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
                //form untuk konfirmasi password
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
                //kode untuk menyimpan data ke database sebagai driver
                Obx(() {
                  if (authController.isLoading3.value == true) {
                    return CircularProgressIndicator(
                      color: Colors.blue,
                    );
                  } else {
                    return Align(
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
                          authController.isLoading3.value = true;
                          setState(() {});
                          //panggil function pada kontroller auth untuk register
                          authController.registerDriver(context,
                              email: usernameController.text,
                              password: passController.text,
                              no_wa: waController.text,
                              name: namaController.text,
                              gender: selectedOption.value,
                              username: usernameController.text);
                          // Navigator.pushNamed(context, "/onmap_driver");
                        }
                      }),
                    );
                  }
                }),
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
