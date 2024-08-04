import 'dart:developer';
import 'package:bank_sampah/View/BottomNavPage.dart';
import 'package:bank_sampah/View/BottomNavPageDriver.dart';
import 'package:bank_sampah/View/ListUserActivity.dart';
import 'package:bank_sampah/View/LoginActivity.dart';
import 'package:bank_sampah/View/OnMapDriver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth fb_auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxBool isLoading2 = false.obs;
  RxBool isLoading3 = false.obs;
  RxBool isLoading4 = false.obs;

  Future<void> registerUser(
    BuildContext context, {
    required String email,
    required String password,
    required String no_wa,
    required String alamat,
    required String nik,
    required String name,
    required String username,
  }) async {
    try {
      UserCredential userCred = await fb_auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        isLoading.value = false;
        return value;
      });

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCred.user!.uid)
          .set({
        "nama": name,
        "no_wa": no_wa,
        "alamat": alamat,
        "username": username,
        "nik": nik
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("sukses register")));
      Get.to(() => LoginActivity());
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      log("error : ${e.toString()}");
      var a = "";
      if (e.code == 'email-already-in-use') {
        a = "Email ini sudah digunakan";
      } else {
        a = "${e.message}";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "${a}",
        style: TextStyle(
            color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp),
      )));
    } catch (e) {
      isLoading.value = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "${e.toString()}",
        style: TextStyle(
            color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp),
      )));
    }
  }

  Future<void> registerDriver(
    BuildContext context, {
    required String email,
    required String password,
    required String no_wa,
    required int gender,
    required String name,
    required String username,
  }) async {
    try {
      UserCredential userCred = await fb_auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        isLoading3.value = false;
        return value;
      });

      await FirebaseFirestore.instance
          .collection("driver")
          .doc(userCred.user!.uid)
          .set({
        "nama": name,
        "no_wa": no_wa,
        "username": username,
        "gender": gender
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("sukses register")));
      Get.to(() => LoginActivity());
    } on FirebaseAuthException catch (e) {
      log("error : ${e.toString()}");
      isLoading3.value = false;
      var a = "";
      if (e.code == 'email-already-in-use') {
        a = "Email ini sudah digunakan";
      } else {
        a = "${e.message}";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "${a}",
        style: TextStyle(
            color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp),
      )));
    } catch (e) {
      isLoading3.value = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "${e.toString()}",
        style: TextStyle(
            color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp),
      )));
    }
  }

  Future<void> loginUser(BuildContext context,
      {required String email, required String password}) async {
    try {
      UserCredential userCred = await fb_auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        isLoading4.value = false;
        return value;
      });
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userCred.user!.uid)
          .get();

      DocumentSnapshot snapshot_driver = await FirebaseFirestore.instance
          .collection("driver")
          .doc(userCred.user!.uid)
          .get();
          
      if (snapshot.exists) {
        isLoading2.value = false;
        Map<String, dynamic> user_data =
            snapshot.data() as Map<String, dynamic>;
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString("id", userCred.user!.uid.toString());
        await pref.setString("nama", user_data['nama']);
        await pref.setString("nik", user_data['nik']);
        await pref.setString("no_wa", user_data['no_wa']);
        await pref.setString("alamat", user_data['alamat']);
        await pref.setString("username", user_data['username']);
        await pref.setString("role", "user");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Login berhasil",
          style: TextStyle(
              color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp),
        )));
        Get.to(() => BottomNavPage());
      } else if (snapshot_driver.exists) {
        isLoading4.value = false;
        Map<String, dynamic> user_data =
            snapshot_driver.data() as Map<String, dynamic>;
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString("id", userCred.user!.uid.toString());
        await pref.setString("nama", user_data['nama']);
        await pref.setInt("gender", user_data['gender']);
        await pref.setString("no_wa", user_data['no_wa']);
        await pref.setString("username", user_data['username']);
        await pref.setString("role", "driver");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Login berhasil",
          style: TextStyle(
              color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp),
        )));
        Get.to(() => ListUserActivity());
      } else {
        isLoading4.value = false;
        isLoading2.value = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Login gagal, periksa data Anda",
          style: TextStyle(
              color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp),
        )));
      }
    } on FirebaseAuthException catch (e) {
      log("error : ${e.message}");
      isLoading4.value = false;
      isLoading2.value = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "${e.message}",
        style: TextStyle(
            color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp),
      )));
    } catch (e) {
      isLoading4.value = false;
      isLoading2.value = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Login gagal, periksa data Anda",
        style: TextStyle(
            color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp),
      )));
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString("id");
    String? nama = pref.getString("nama");
    String? nik = pref.getString("nik");
    String? no_wa = pref.getString("no_wa");
    String? alamat = pref.getString("alamat");
    String? username = pref.getString("username");

    return {
      "id": id,
      "nama": nama,
      "nik": nik,
      "no_wa": no_wa,
      "alamat": alamat,
      "username": username
    };
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Terkirim!, Silahkan cek email Anda",
        style: TextStyle(
            fontFamily: "Poppins", color: Colors.white, fontSize: 12.sp),
      )));
    } catch (e) {
      print('Error: $e');
      // Handle error, show a dialog or a Snackbar with an error message
    }
  }
}
