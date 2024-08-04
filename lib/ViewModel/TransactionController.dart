
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionController extends GetxController {
  
  RxString pelanggan = "".obs;
  RxString alamat = "".obs;
  RxString id_user = "".obs;
  RxMap<String, dynamic> map_user_data = <String, dynamic>{}.obs;
  RxList<dynamic> list_user_data = <dynamic>[].obs;
  RxList<dynamic> list_request_data = <dynamic>[].obs;
  RxList<dynamic> list_history_user_data = <dynamic>[].obs;
  
  Future<void> savePengiriman(BuildContext context, {
    required String items_non,
    required String name, 
    required String alamat,
    required String items_organik,
    required double total_non,
    required double total_organik,
    required int poin,
    required String user_id
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id_driver = pref.getString("id");

    await FirebaseFirestore.instance
        .collection("transaction")
        .add({
          "id_driver" : id_driver,
          "id_user" : user_id, 
          "nama" : name, 
          "alamat" : alamat,
          "items_non" : items_non, 
          "items_organik" : items_organik, 
          "total_non" : total_non, 
          "total_organik" : total_organik, 
          "poin" : poin
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Disimpan", style: TextStyle(
            color: Colors.white, 
            fontFamily: "Poppins",
            fontSize: 14.sp
          ),)));
        });
  }
  
  Future<void> requestPenjemputan(BuildContext context, {
    required String items,
    required String name, 
    required String alamat,
  }) async {

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
    String? id_user = pref.getString("id");

    await FirebaseFirestore.instance
        .collection("penjemputan")
        .add({
          "id_user" : id_user,
          "nama" : name, 
          "alamat" : alamat,
          "items" : items, 
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Disimpan", style: TextStyle(
            color: Colors.white, 
            fontFamily: "Poppins",
            fontSize: 14.sp
          ),)));
        });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal : ${e.toString()}")));
    }
  }

  Future<void> getTransaksi(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id_driver = pref.getString("id");
    try {
      final QuerySnapshot snap = await FirebaseFirestore.instance
      .collection("transaction")
      .where("id_driver", isEqualTo: id_driver)
      .get();

      list_user_data.value = snap.docs;  

      log(list_user_data[0]['nama'].toString());

    } catch (e) {
      log("error : ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uh!, tidak ada data")));
    }
  }

  Future<void> getRequest(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id_user = pref.getString("id");
    try {
      final QuerySnapshot snap = await FirebaseFirestore.instance
      .collection("penjemputan")
      // .where(field)
      .get();

      list_request_data.value = snap.docs.toList();  

      log(list_request_data[0]['nama'].toString());

    } catch (e) {
      log("error : ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uh!, tidak ada data")));
    }
  }

  Future<void> getRequestById(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id_user = pref.getString("id");
    try {
      final QuerySnapshot snap = await FirebaseFirestore.instance
      .collection("transaction")
      .where("id_user", isEqualTo: id_user)
      .get();

      list_history_user_data.value = snap.docs.toList();  

      log(list_history_user_data[0]['nama'].toString());

    } catch (e) {
      log("error : ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uh!, tidak ada data")));
    }
  }

}

  


