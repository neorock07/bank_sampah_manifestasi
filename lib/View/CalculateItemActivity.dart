import 'dart:developer';

import 'package:bank_sampah/Partials/Button/BaseButton.dart';
import 'package:bank_sampah/Partials/Card/ItemCalculateCard.dart';
import 'package:bank_sampah/Partials/Card/ItemOptionCard.dart';
import 'package:bank_sampah/Partials/Card/TotalItemCard.dart';
import 'package:bank_sampah/Partials/ClipPath/BaseClip.dart';
import 'package:bank_sampah/View/PengirimanDoneActivity.dart';
import 'package:bank_sampah/ViewModel/ItemPickedController.dart';
import 'package:bank_sampah/ViewModel/TransactionController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CalculateItemActivity extends StatefulWidget {
  const CalculateItemActivity({Key? key}) : super(key: key);

  @override
  _CalculateItemActivityState createState() => _CalculateItemActivityState();
}

class _CalculateItemActivityState extends State<CalculateItemActivity> {
  //data static untuk checkbox non-organik dan organik
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
  //variable untuk menyimpan data yang terpilih
  Set<String> non_selected = {};
  Set<String> organik_selected = {};

  //list text controller untuk tiap text field , default nilai set nilai 0
  List<TextEditingController> controllers_non = [
    TextEditingController(text: "0.0"),
    TextEditingController(text: "0.0"),
    TextEditingController(text: "0.0"),
    TextEditingController(text: "0.0"),
    TextEditingController(text: "0.0"),
  ];
  //list text controller untuk tiap text field , default nilai set nilai 0

  List<TextEditingController> controllers_organik = [
    TextEditingController(text: "0.0"),
  ];

  RxString items_picked_non = "".obs;
  RxString items_picked_organik = "".obs;
  //controller itemPicked dan transaction
  var pickedController = Get.put(ItemPickedController());
  var transController = Get.put(TransactionController());

  //jika pindah ke halaman lain, hapus semua data pada variabel yang menyimpan data chekclist dan total nilai organik/non
  @override
  void dispose() {
    super.dispose();
    pickedController.map_controller_index.clear();
    pickedController.map_controller_organik_index.clear();
    pickedController.map_non_items.clear();
    pickedController.map_organik_items.clear();
    pickedController.total_point.value = 0;
    pickedController.total_non.value = 0;
    pickedController.total_organik.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          //jika tekan back, hapus semua data pada variabel yang menyimpan data chekclist dan total nilai organik/non

          pickedController.map_controller_index.clear();
          pickedController.map_controller_organik_index.clear();
          pickedController.map_non_items.clear();
          pickedController.map_organik_items.clear();
          pickedController.total_point.value = 0;
          return true;
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(99, 215, 167, 1),
                Color.fromRGBO(176, 201, 177, 1)
              ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
            ),
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
                    ///tampilkan data non organik checkbox dengan widget dibawah
                    Align(
                        alignment: Alignment.topCenter,
                        child: ItemCalculateCard(context,
                            height: 280.h,
                            isOrganik: false,
                            controllers: controllers_non,
                            asset: "assets/images/non.png",
                            item: non_organik,
                            selected: non_selected)),
                    SizedBox(
                      height: 10.h,
                    ),
                    ///tampilkan data organik checkbox dengan widget dibawah

                    Align(
                        alignment: Alignment.topCenter,
                        child: ItemCalculateCard(context,
                            height: 130.h,
                            isOrganik: true,
                            controllers: controllers_organik,
                            asset: "assets/images/organik.png",
                            item: organik,
                            selected: organik_selected)),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(() {
                      items_picked_non.value = non_selected.toString();

                      items_picked_organik.value = organik_selected.toString();

                      log("nilai : ${pickedController.total_non.value}");
                      //tampilkan card total jumlah non organik dan organik serta poin dengan widget ini
                      return TotalItemCard(context,
                          background: Colors.white,
                          total_non: pickedController.total_non,
                          total_organik: pickedController.total_organik,
                          total_point: pickedController.total_point,
                          items_non: items_picked_non,
                          items_organik: items_picked_organik);
                    }),
                    SizedBox(
                      height: 10.h,
                    ),
                    //button untuk menyimpan data jumlah kg dan tipe item ke database
                    Align(
                        alignment: Alignment.topCenter,
                        child: BaseButton(context,
                            height: 40.h,
                            width: MediaQuery.of(context).size.width * 0.9,
                            label: "KIRIM",
                            color: Color.fromRGBO(217, 217, 217, 1),
                            fontColor: Colors.black,
                            borderRadius: 10.dm, onTap: () async {
                          //menjalankan function ini untuk save ke database
                          await transController
                              .savePengiriman(context,
                                  name: transController.pelanggan.value,
                                  alamat: transController.alamat.value,
                                  user_id: transController.id_user.value,
                                  items_non: items_picked_non.toString(),
                                  items_organik:
                                      items_picked_organik.toString(),
                                  total_non: pickedController.total_non.value,
                                  total_organik:
                                      pickedController.total_organik.value,
                                  poin: pickedController.total_point.value)
                              .then((value) {
                            Get.snackbar(
                                "Terima Kasih", "Selamat pengiriman berhasil!");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PengirimanDoneActivity(
                                            poin: pickedController
                                                .total_point.value)));
                          });
                        })),
                    SizedBox(
                      height: 50.h,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
