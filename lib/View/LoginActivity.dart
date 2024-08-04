import 'package:bank_sampah/Partials/Button/BaseButton.dart';
import 'package:bank_sampah/Partials/Dialog/DialogPop.dart';
import 'package:bank_sampah/Partials/Form/formPassword.dart';
import 'package:bank_sampah/Partials/Form/formText.dart';
import 'package:bank_sampah/View/ForgotPasswordPage.dart';
import 'package:bank_sampah/ViewModel/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginActivity extends StatefulWidget {
  const LoginActivity({Key? key}) : super(key: key);

  @override
  _LoginActivityState createState() => _LoginActivityState();
}

//halaman untuk login
class _LoginActivityState extends State<LoginActivity> {
  //inisiasi controller
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  //variable kondisi visibility password
  RxBool isVisible = true.obs;
  GlobalKey<FormState> global_key = GlobalKey<FormState>();
  //inisiasi controller auth
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color.fromRGBO(70, 178, 133, 1),
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: global_key,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(99, 215, 167, 1),
                Color.fromRGBO(176, 201, 177, 1)
              ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
              child: Padding(
                padding: EdgeInsets.only(top: 80.h),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Center(
                        child: Text(
                          "Selamat Datang",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Bree",
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 80.h),
                      //form email
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: FormText(context,
                              label: "Email",
                              controller: usernameController,
                              type: TextInputType.emailAddress)),
                      SizedBox(height: 10.h),
                      //form password
                    
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Obx(() => FormPassword(context,
                              label: "Password",
                              controller: passController,
                              isVisible: isVisible))),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(left: 40.w),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.grey,
                              //jika lupa password maka arahkan ke forgot password
                              onTap: () {
                                Get.to(() => ForgotPasswordPage());
                              },
                              child: Text(
                                "Lupa password?",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.solid),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      
                      Obx(() {
                        //cek apakah loading, jika loading maka tampilkan widget loading 
                        if (authController.isLoading2.value == true ||
                            authController.isLoading4.value == true) {
                          return CircularProgressIndicator(
                            color: Colors.blue,
                          );
                        } 
                        //jika tidak maka tampilkan button untuk login
                        else {
                          return BaseButton(context,
                              height: 40.h,
                              width: MediaQuery.of(context).size.width * 0.5,
                              label: "Login",
                              color: Colors.black,
                              fontColor: Colors.white, onTap: () {
                            //cek apakah data sudah diisi dengan benar
                            if (global_key.currentState!.validate() == false) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "mohon isi data dengan benar!",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12.sp,
                                ),
                              )));
                            } 
                            //jika sudah benar maka menjalankan function login user untuk login ke aplikasi
                            else {
                              authController.isLoading2.value = true;
                              setState(() {});
                            
                              authController.loginUser(context,
                                  email: usernameController.text,
                                  password: passController.text);
                            }
                          });
                        }
                      }),
                      SizedBox(
                        height: 10.h,
                      ),
                      //tombol daftar akun baru
                      BaseButton(context,
                          height: 40.h,
                          width: MediaQuery.of(context).size.width * 0.5,
                          label: "Daftar Akun",
                          color: Colors.black,
                          fontColor: Colors.white, onTap: () async {
                           //muncul alert dialog untuk memilih role user atau driver 
                        DialogPop(context,
                            size: [180.dm, 180.dm],
                            icon: Container(
                              height: 150.dm,
                              width: 150.dm,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.dm)),
                              child: Column(
                                children: [
                                  Text(
                                    "Pilih Role Akun",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Poppins",
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  //jika pilih user maka akan mengarah ke halaman register user
                                  BaseButton(context,
                                      height: 40.w,
                                      width: 140.w,
                                      label: "User",
                                      color: Colors.green,
                                      fontColor: Colors.white, onTap: () {
                                    Navigator.pushNamed(context, "/register");
                                  }),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  //jika pilih driver maka register ke halaman register driver
                                  BaseButton(context,
                                      height: 40.w,
                                      width: 140.w,
                                      label: "Driver",
                                      color: Colors.green,
                                      fontColor: Colors.white, onTap: () {
                                    Navigator.pushNamed(
                                        context, "/register_driver");
                                  }),
                                ],
                              ),
                            ));
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
