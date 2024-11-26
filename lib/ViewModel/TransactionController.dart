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

  Future<void> savePengiriman(BuildContext context,
      {required String items_non,
      required String name,
      required String alamat,
      required String items_organik,
      required double total_non,
      required double total_organik,
      required int poin,
      required String user_id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id_driver = pref.getString("id");

    await FirebaseFirestore.instance.collection("transaction").add({
      "id_driver": id_driver,
      "id_user": user_id,
      "nama": name,
      "alamat": alamat,
      "items_non": items_non,
      "items_organik": items_organik,
      "total_non": total_non,
      "total_organik": total_organik,
      "poin": poin
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Disimpan",
        style: TextStyle(
            color: Colors.white, fontFamily: "Poppins", fontSize: 14.sp),
      )));
    });
  }

  Future<void> requestPenjemputan(
    BuildContext context, {
    required String items,
    required String name,
    required String alamat,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? id_user = pref.getString("id");

      await FirebaseFirestore.instance.collection("penjemputan").add({
        "id_user": id_user,
        "nama": name,
        "alamat": alamat,
        "items": items,
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Disimpan",
          style: TextStyle(
              color: Colors.white, fontFamily: "Poppins", fontSize: 14.sp),
        )));
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Gagal : ${e.toString()}")));
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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Uh!, tidak ada data")));
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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Uh!, tidak ada data")));
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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Uh!, tidak ada data")));
    }
  }

  Future<int> getTotalPoint() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id_user = pref.getString("id");
    String? role = pref.getString("role");
    int total = 0;
    int total_penukaran = 0;
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("transaction")
          .where((role == "user") ? "id_user" : "id_driver", isEqualTo: id_user)
          .get();
      
      final QuerySnapshot snapshot_shop = await FirebaseFirestore.instance
          .collection("shop")
          .where("id_person", isEqualTo: id_user)
          .get();

      List<dynamic> result = snapshot.docs.toList();
      List<dynamic> result_shop = snapshot_shop.docs.toList();

      //total poin pendapatan
      for (var i in result) {
        int poin = i.data()['poin'];
        total += poin;
      }

      //total penukaran
      for (var i in result_shop) {
        int poin = i.data()['poin'];
        total_penukaran += poin;
      }

      log("hasil : ${total - total_penukaran}");
    } catch (e) {
      log.printError(info: e.toString());
    }

    return ((total - total_penukaran) < 0 )? 0 : total - total_penukaran;
  }

  Future<double> getTotalSampah() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id_user = pref.getString("id");
    String? role = pref.getString("role");
    double total_non = 0;
    double total_org = 0;
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("transaction")
          .where((role == "user") ? "id_user" : "id_driver", isEqualTo: id_user)
          .get();
      
      List<dynamic> result = snapshot.docs.toList();

      //total poin pendapatan
      for (var i in result) {
        double non = i.data()['total_non'];
        double org = i.data()['total_organik'];
        total_non += non;
        total_org += org;
      }

      log("hasil sampah : ${total_non + total_org}");
    } catch (e) {
      log.printError(info: e.toString());
    }

    return total_non + total_org;
  }

  Future<void> insertPenukaran(
      {required int poin,
      required String item,
      required String images,
      required BuildContext context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id_person = pref.getString("id");

    await FirebaseFirestore.instance.collection("shop").add({
      "id_person": id_person,
      "item": item,
      "poin": poin,
      "images": images
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Disimpan",
          style: TextStyle(
              color: Colors.white, fontFamily: "Poppins", fontSize: 14.sp),
        ),
      ));
    });
  }
}
