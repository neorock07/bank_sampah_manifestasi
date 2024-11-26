import 'dart:developer';

import 'package:bank_sampah/Partials/Card/DashboardCard.dart';
import 'package:bank_sampah/Partials/Card/ItemStuff.dart';
import 'package:bank_sampah/Partials/Card/PromotionCard.dart';
import 'package:bank_sampah/View/PenukaranDoneActivity.dart';
import 'package:bank_sampah/ViewModel/TransactionController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Partials/Search/SearchCard.dart';

class ShopActivity extends StatefulWidget {
  const ShopActivity({Key? key}) : super(key: key);

  @override
  _ShopActivityState createState() => _ShopActivityState();
}

class _ShopActivityState extends State<ShopActivity> {
  //inisiasi kontroller untuk text-field widget search
  TextEditingController searchController = TextEditingController();

  dynamic poinUser = 0.obs;
  dynamic totalSampah = 0.0.obs;
  //data static untuk list barang --> tinggal ganti lokasi asset dan data lain.
  List<dynamic> item_data = [
    {
      "item": "assets/images/ember.png",
      "harga": 300,
      "color": "a",
      "nama": "Ember"
    },
    {
      "item": "assets/images/helm.png",
      "harga": 1500,
      "color": "a",
      "nama": "Helm"
    },
    {
      "item": "assets/images/teflon.png",
      "harga": 600,
      "color": "a",
      "nama": "Teflon"
    },
    {
      "item": "assets/images/tv.png",
      "harga": 4500,
      "color": "a",
      "nama": "Televisi"
    },
    {
      "item": "assets/images/wajan.png",
      "harga": 500,
      "color": "a",
      "nama": "Wajan"
    },
  ];
  List<dynamic> item_data2 = [
    {
      "item": "assets/images/ember.png",
      "harga": 300,
      "color": "a",
      "nama": "Ember"
    },
    {
      "item": "assets/images/helm.png",
      "harga": 1500,
      "color": "a",
      "nama": "Helm"
    },
    {
      "item": "assets/images/teflon.png",
      "harga": 600,
      "color": "a",
      "nama": "Teflon"
    },
    {
      "item": "assets/images/tv.png",
      "harga": 4500,
      "color": "a",
      "nama": "Televisi"
    },
    {
      "item": "assets/images/wajan.png",
      "harga": 500,
      "color": "a",
      "nama": "Wajan"
    },
  ];
  List<dynamic> item_data3 = [
    {
      "item": "assets/images/ember.png",
      "harga": 300,
      "color": "a",
      "nama": "Ember"
    },
    {
      "item": "assets/images/helm.png",
      "harga": 1500,
      "color": "a",
      "nama": "Helm"
    },
    {
      "item": "assets/images/teflon.png",
      "harga": 600,
      "color": "a",
      "nama": "Teflon"
    },
    {
      "item": "assets/images/tv.png",
      "harga": 4500,
      "color": "a",
      "nama": "Televisi"
    },
    {
      "item": "assets/images/wajan.png",
      "harga": 500,
      "color": "a",
      "nama": "Wajan"
    },
  ];
  //variabel yang digunakan untuk menyimpan data sementara yang di select
  Map<String, dynamic> item_picked = {};
  //variabel untuk pengkondisian select barang
  bool isTap = false;

  TransactionController trans = Get.put(TransactionController());

  void getPoint() async {
    poinUser.value += await trans.getTotalPoint();
    totalSampah.value += await trans.getTotalSampah();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPoint();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      //setting warna status bar
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: const Color.fromARGB(255, 239, 239, 239),
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          //widget tombol
          child: FloatingActionButton(
            onPressed: () async {
             
              log(item_picked.toString());
              //cek jika data yang dipilih tidak kosong maka dikirim ke halaman penukaran poin
              if (item_picked.values.isNotEmpty &&
                  poinUser.value > item_picked['poin']) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PenukaranDoneActivity(
                              item_data: item_picked,
                            )));
                Get.snackbar("Transaksi Berhasil", "Poin berhasil ditukar");
                item_data[item_picked['index']]['color'] = 'a';
                //save penukaran
                await trans.insertPenukaran(
                    poin: item_picked['poin'],
                    item: item_picked['nama'],
                    images: item_picked['image'],
                    context: context);
              } else {
                log(item_picked.toString());
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Saldo tidak mencukupi!",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 14.sp),
                  ),
                ));
              }
            },
            child: Text(
              "Memesan",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Color.fromRGBO(66, 215, 167, 1),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.h,
              ),
              Container(
                height: 100.h,
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Align(
                        alignment: Alignment.topCenter,
                        //widget card dashboard info jumlah sampah terkumpul
                        child: Obx(() => DashboardCard(context,
                            saldo: poinUser.value,
                            total_sampah: totalSampah.value,
                            background: Color.fromRGBO(66, 215, 167, 1)))),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 15.h, bottom: 10.h),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Penukaran Poin",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Bree",
                        fontSize: 20.sp),
                  ),
                ),
              ),
              //widget search bar
              SearchCard(context, controller: searchController),
              Container(
                height: 120.h,
                width: MediaQuery.of(context).size.width,
                //widget listView untuk membuat list daftar barang
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: item_data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 7.w),
                        child: Material(
                          color: Colors.transparent,
                          //button jika di klik
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              //kondisi jika klik maka menambahkan data ke variabel item_picked
                              //ubah warna border ke green
                              if (isTap == false) {
                                item_data[index]['color'] = 'g';
                                item_picked['image'] = item_data[index]['item'];
                                item_picked['index'] = index;
                                item_picked['poin'] = item_data[index]['harga'];
                                item_picked['nama'] = item_data[index]['nama'];
                              }
                              //kondisi jika klik untuk un-selected item, dengan menghapus data item_picked
                              //ubah warna border ke abu2
                              else {
                                item_data[index]['color'] = 'a';
                                item_picked.clear();
                              }

                              isTap = !isTap;
                              setState(() {
                                log("item picked : ${item_picked.values}");
                              });
                            },
                            //tampilkan data item_data ke widget dalam listView
                            child: ItemStuff(context,
                                aset: "${item_data[index]['item']}",
                                label:
                                    "${NumberFormat('#,###').format(item_data[index]['harga'])}",
                                color: "${item_data[index]['color']}"),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    "Promotions",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Bree",
                        fontSize: 20.sp),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              //widget untuk menampilkan card promosi
              PromotionCard(context, asset: item_data[2]['item']),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 120.h,
                width: MediaQuery.of(context).size.width,
                //membuat daftar barang ke dua
                child: ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: item_data3.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 7.w),
                        child: ItemStuff(context,
                            aset: "${item_data3[index]['item']}",
                            label:
                                "${NumberFormat('#,###').format(item_data3[index]['harga'])}",
                            color: "${item_data3[index]['color']}"),
                      );
                    }),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 120.h,
                width: MediaQuery.of(context).size.width,
                //membuat daftar barang ketiga
                child: ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: item_data2.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 7.w),
                        child: ItemStuff(context,
                            aset: "${item_data2[index]['item']}",
                            label:
                                "${NumberFormat('#,###').format(item_data2[index]['harga'])}",
                            color: "${item_data2[index]['color']}"),
                      );
                    }),
              ),
              SizedBox(
                height: 80.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
