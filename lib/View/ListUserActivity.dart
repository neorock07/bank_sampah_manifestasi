import 'dart:math';

import 'package:bank_sampah/Partials/Card/DriverCard.dart';
import 'package:bank_sampah/Partials/Card/UserCard.dart';
import 'package:bank_sampah/Partials/Dialog/DialogPop.dart';
import 'package:bank_sampah/View/LoginActivity.dart';
import 'package:bank_sampah/View/OnMapDriver.dart';
import 'package:bank_sampah/ViewModel/AuthController.dart';
import 'package:bank_sampah/ViewModel/TransactionController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListUserActivity extends StatefulWidget {
  const ListUserActivity({Key? key}) : super(key: key);

  @override
  _ListUserActivityState createState() => _ListUserActivityState();
}
//halaman untuk daftar user yang minta penjemputan
class _ListUserActivityState extends State<ListUserActivity> {
 //inisasi controller transaction
  TransactionController transController = Get.put(TransactionController());
  //function untuk get data user terdekat dari database
  Future<void> getData() async {
    await transController.getRequest(context);
  }

  //function untuk get data nama akun dari shared preferences
  RxString name = "".obs;
  SharedPreferences? pref;
  Future<void> getUserData() async {
    pref = await SharedPreferences.getInstance();
    name.value = pref!.getString("nama")!;
  }
  //inisiasi controller auth
  var authController = Get.put(AuthController());

//jalankan kedua function pada saat halaman pertama kali dimuat
  @override
  void initState() {
    super.initState();
    getData();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(99, 215, 167, 1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Penjemputan Terdekat",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Bree",
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                InkWell(
                  //muncul dialog log out jika tombol profile diklik
                  onTap: () async {
                    DialogPop(context,
                        icon: Column(
                          children: [
                            Text("Tekan untuk keluar Akun",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontSize: 14.sp)),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.green)),
                                onPressed: () {
                                  //hapus data login dari shared preferences
                                  pref!.clear();
                                  authController.isLoading.value = false;
                                  authController.isLoading2.value = false;
                                  authController.isLoading3.value = false;
                                  authController.isLoading4.value = false;
                                  //pindah ke halaman login jika sudah dihapus
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginActivity()));
                                },
                                child: Text(
                                  "Log-Out",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 14.sp),
                                ))
                          ],
                        ));
                  },
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/avatar.png"),
                  ),
                )
              ],
            ),
            Obx(() => Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  //cek apakah data yang di get dari database sudah ada 
                  child: (transController.list_request_data.isEmpty)
                      ? 
                      //jika tidak ada maka menampilkan 404
                      Container(
                          height: 80.dm,
                          width: 80.dm,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/not.png"),
                                  fit: BoxFit.cover)),
                        )
                      : 
                      //jika sudah ada data maka menampilkan list view dengan data tersebut
                      ListView.builder(
                          itemCount: transController.list_request_data.length,
                          itemBuilder: (_, index) {
                            var list_item =
                                transController.list_request_data.value;
                            return Padding(
                              padding: EdgeInsets.all(10.dm),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OnMapDriver(
                                                asset:
                                                    "assets/images/avatar.png",
                                                nama: list_item[index]['nama'],
                                                alamat: list_item[index]
                                                    ['alamat'],
                                                item: list_item[index]['items'],
                                                id_user: list_item[index]
                                                    ['id_user'],
                                              )));
                                },
                                //gunakan widget user card untuk menampilkan data
                                child: UserCard(context,
                                    name: list_item[index]['nama'],
                                    asset: "assets/images/avatar.png",
                                    jarak: Random().nextDouble() * 8.8 + 1.1,
                                    item: list_item[index]['items']
                                        .toString()
                                        .replaceAll(RegExp(r'[\[\]]'), "")),
                              ),
                            );
                          }),
                )),
          ],
        ),
      ),
    );
  }
}
