import 'dart:developer';

import 'package:bank_sampah/Partials/Button/BaseButton.dart';
import 'package:bank_sampah/Partials/Card/ItemOptionCard.dart';
import 'package:bank_sampah/Partials/ClipPath/BaseClip.dart';
import 'package:bank_sampah/ViewModel/TransactionController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PenjemputanActivity extends StatefulWidget {
  const PenjemputanActivity({Key? key}) : super(key: key);

  @override
  _PenjemputanActivityState createState() => _PenjemputanActivityState();
}

class _PenjemputanActivityState extends State<PenjemputanActivity> {
  //data static untuk list checkbox
  List<dynamic> non_organik = [
    {"item": "Botol", "kondisi": false.obs},
    {"item": "Kertas", "kondisi": false.obs},
    {"item": "Kaleng", "kondisi": false.obs},
    {"item": "Kaca", "kondisi": false.obs},
    {"item": "Kardus", "kondisi": false.obs},
  ];
  List<dynamic> organik = [
    {"item": "Sampah makanan", "kondisi": false.obs},
    {"item": "Tanaman", "kondisi": false.obs},
  ];
  //variabel untuk menyimpan checkbox yang di ceklist
  Set<String> non_selected = {};
  Set<String> organik_selected = {};
  var transController = Get.put(TransactionController());

  //inisiasi shared preferences
  RxString name = "".obs;
  RxString alamat = "".obs;
  SharedPreferences? pref;

  //function untuk get nama akun dan alamat yang tersimpan di shared preferences
  Future<void> getUserData() async {
    pref = await SharedPreferences.getInstance();
    name.value = pref!.getString("nama")!;
    alamat.value = pref!.getString("alamat")!;
  }

  //panggil function pada saat pertama kali memuat halaman pertama kali
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(99, 215, 167, 1),
              Color.fromRGBO(176, 201, 177, 1)
            ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
          ),
          //membuat bentuk card background sesuai desain figma dengan widget clip-path
          ClipPath(
            clipper: BaseClip(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h, left: 10.w),
            child: Container(
              height: 120.dm,
              width: 120.dm,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      scale: 1,
                      image: AssetImage("assets/images/recycle.png"),
                      fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 50.w),
                child: Text(
                  "Reduce\n Reuse\n  Recycle\n",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Bree",
                      shadows: [
                        Shadow(
                            color: Colors.green,
                            offset: Offset(4, 4),
                            blurRadius: 2.dm)
                      ],
                      fontSize: 30.sp),
                )),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 160.h),
              child: Column(
                children: [
                  //widget untuk checkbox non organik
                  Align(
                      alignment: Alignment.topCenter,
                      child: ItemOptionCard(context,
                          height: 280.h,
                          asset: "assets/images/non.png",
                          item: non_organik,
                          selected: non_selected)),
                  SizedBox(
                    height: 10.h,
                  ),
                  //widget untuk checkbox organik
                  Align(
                      alignment: Alignment.topCenter,
                      child: ItemOptionCard(context,
                          height: 130.h,
                          asset: "assets/images/organik.png",
                          item: organik,
                          selected: organik_selected)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: BaseButton(context,
                          height: 40.h,
                          width: MediaQuery.of(context).size.width * 0.9,
                          label: "MEMESAN",
                          color: Color.fromRGBO(217, 217, 217, 1),
                          fontColor: Colors.black,
                          borderRadius: 10.dm, onTap: () async {
                        Get.snackbar("Mendapatkan Driver",
                            "Silahkan tunggu driver segera datang...");
                        //simpan data yang di checklist ke sebuah variable list
                        List<String> list_item_non = non_selected.toList();
                        List<String> list_item_or = organik_selected.toList();
                        String item =
                            list_item_or.toString() + list_item_non.toString();
                        log(item);
                        //simpan data tersebut ke server firebase dengan function ini
                        await transController.requestPenjemputan(
                          context,
                          items: item,
                          name: name.value,
                          alamat: alamat.value,
                        );
                        //setelah menyimpan, pergi ke halaman onmap untuk melihat posisi driver
                        Navigator.pushReplacementNamed(context, "/onmap");
                      })),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
