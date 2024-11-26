import 'package:bank_sampah/Partials/Button/BaseButton.dart';
import 'package:bank_sampah/Partials/Button/OptionButton.dart';
import 'package:bank_sampah/Partials/Form/formPassword.dart';
import 'package:bank_sampah/Partials/Form/formText.dart';
import 'package:bank_sampah/ViewModel/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterActivity extends StatefulWidget {
  const RegisterActivity({Key? key}) : super(key: key);

  @override
  _RegisterActivityState createState() => _RegisterActivityState();
}

class _RegisterActivityState extends State<RegisterActivity> {
  //inisiasi text controller
  TextEditingController namaController = TextEditingController();
  TextEditingController waController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController konfController = TextEditingController();
  //variabel untuk kondisi radio button
  RxInt selectedOption = 1.obs;
  RxBool isVisible = true.obs;
  RxBool isVisible2 = true.obs;
  GlobalKey<FormState> global_key = GlobalKey<FormState>();
  //inisiasi kontroller auth
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
                //set title halaman
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Daftar Akun",
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
                ////form untuk nama
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
                //form untuk nik
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FormText(context,
                        label: "NIK",
                        controller: nikController,
                        type: TextInputType.number),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                //form untuk alamat
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FormText(context,
                        label: "Alamat/Tempat tinggal (RT/RW)",
                        controller: alamatController,
                        type: TextInputType.multiline,
                        maxline: 3),
                  ),
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
                //form untuk ulang password
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
                //kode untuk menyimpan data register
                Obx(() {
                  if (authController.isLoading.value == true) {
                    return const CircularProgressIndicator(
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
                        //cek apakah data sudah diisi dengan benar
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
                          authController.isLoading.value = true;
                          setState(() {});
                          //panggil auth controller untuk register
                          authController.registerUser(context,
                              email: usernameController.text,
                              password: passController.text,
                              no_wa: waController.text,
                              alamat: alamatController.text,
                              nik: nikController.text,
                              name: namaController.text,
                              username: usernameController.text);
                        }
                      }),
                    );
                  }
                }),
                SizedBox(
                  height: 40.h,
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
