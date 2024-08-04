import 'package:bank_sampah/ViewModel/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  //inisiasi controller
  final TextEditingController emailController = TextEditingController();
  //auth controller
  AuthController authController = Get.put(AuthController());
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            //field untuk mengisi email
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            //tekan tombol untuk request reset password
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text.trim();
                if (email.isNotEmpty) {
                  await authController.resetPassword(context, email).then((value) {
                    Navigator.pop(context);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Mohon isi email Anda!')));
                }
              },
              child: Text('Reset Password', style: TextStyle(
                fontFamily: "Poppins", 
                fontSize: 14.sp,
                color: Colors.black, 
                fontWeight: FontWeight.bold
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
