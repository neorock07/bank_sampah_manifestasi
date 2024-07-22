import 'package:bank_sampah/Partials/Button/BaseButton.dart';
import 'package:bank_sampah/Partials/Form/formPassword.dart';
import 'package:bank_sampah/Partials/Form/formText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginActivity extends StatefulWidget {
  const LoginActivity({Key? key}) : super(key: key);

  @override
  _LoginActivityState createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxBool isVisible = true.obs;
  GlobalKey<FormState> global_key = GlobalKey<FormState>();

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
        body: Form(
          key: global_key,
          child: Container(
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
                            fontWeight: FontWeight.bold
                            ),
                      ),
                    ),
                    SizedBox(height: 80.h),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: FormText(context,
                            label: "Username", controller: usernameController)),
                    SizedBox(height: 10.h),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Obx(() => FormPassword(context,
                            label: "Password",
                            controller: passController,
                            isVisible: isVisible))),
                    SizedBox(
                      height: 60.h,
                    ),
                    BaseButton(context,
                        height: 40.h,
                        width: MediaQuery.of(context).size.width * 0.5,
                        label: "Login",
                        color: Colors.black,
                        fontColor: Colors.white,
                        onTap: (){
                           if (global_key.currentState!.validate() == false) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                "mohon isi data dengan benar!",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12.sp,
                                ),
                              )));
                            } 
                        }
                        ),
                    SizedBox(
                      height: 10.h,
                    ),
                    BaseButton(context,
                        height: 40.h,
                        width: MediaQuery.of(context).size.width * 0.5,
                        label: "Daftar Akun",
                        color: Colors.black,
                        fontColor: Colors.white,
                        onTap: (){
        
                          Navigator.pushNamed(context, "/register");
                        }
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
