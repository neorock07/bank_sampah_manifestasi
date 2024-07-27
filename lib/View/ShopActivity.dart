import 'dart:developer';

import 'package:bank_sampah/Partials/Card/DashboardCard.dart';
import 'package:bank_sampah/Partials/Card/ItemStuff.dart';
import 'package:bank_sampah/Partials/Card/PromotionCard.dart';
import 'package:bank_sampah/View/PenukaranDoneActivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Partials/Search/SearchCard.dart';

class ShopActivity extends StatefulWidget {
  const ShopActivity({Key? key}) : super(key: key);

  @override
  _ShopActivityState createState() => _ShopActivityState();
}

class _ShopActivityState extends State<ShopActivity> {
  TextEditingController searchController = TextEditingController();

  List<dynamic> item_data = [
    {"item": "assets/images/ember.png", "harga": "Rp.30,000", "color": "a"},
    {"item": "assets/images/helm.png", "harga": "Rp.150,000", "color": "a"},
    {"item": "assets/images/teflon.png", "harga": "Rp.60,000", "color": "a"},
    {"item": "assets/images/tv.png", "harga": "Rp.450,000", "color": "a"},
    {"item": "assets/images/wajan.png", "harga": "Rp.50,000", "color": "a"},
  ];
  List<dynamic> item_data2 = [
    {"item": "assets/images/ember.png", "harga": "Rp.30,000", "color": "a"},
    {"item": "assets/images/helm.png", "harga": "Rp.150,000", "color": "a"},
    {"item": "assets/images/teflon.png", "harga": "Rp.60,000", "color": "a"},
    {"item": "assets/images/tv.png", "harga": "Rp.450,000", "color": "a"},
    {"item": "assets/images/wajan.png", "harga": "Rp.50,000", "color": "a"},
  ];
  List<dynamic> item_data3 = [
    {"item": "assets/images/ember.png", "harga": "Rp.30,000", "color": "a"},
    {"item": "assets/images/helm.png", "harga": "Rp.150,000", "color": "a"},
    {"item": "assets/images/teflon.png", "harga": "Rp.60,000", "color": "a"},
    {"item": "assets/images/tv.png", "harga": "Rp.450,000", "color": "a"},
    {"item": "assets/images/wajan.png", "harga": "Rp.50,000", "color": "a"},
  ];

  Map<String, dynamic> item_picked = {};
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
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
          child: FloatingActionButton(
            onPressed: () {
              log(item_picked.toString());
              // Navigator.pushNamed(context, "/penukaran_done");
              if (item_picked.values.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PenukaranDoneActivity(
                              item_data: item_picked,
                            )));
                Get.snackbar("Transaksi Berhasil", "Poin berhasil ditukar");
                item_data[item_picked['index']]['color'] = 'a';
              }else{
              log(item_picked.toString());
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
                        child: DashboardCard(context,
                            background: Color.fromRGBO(66, 215, 167, 1))),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/sd.jpeg"),
                      ),
                    ),
                  )
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
              SearchCard(context, controller: searchController),
              Container(
                height: 120.h,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: item_data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 7.w),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              if (isTap == false) {
                                item_data[index]['color'] = 'g';
                                item_picked['image'] = item_data[index]['item'];
                                item_picked['index'] = index;
                                item_picked['poin'] = item_data[index]['harga']
                                    .toString()
                                    .split("Rp.")[1];
                              } else {
                                item_data[index]['color'] = 'a';
                                item_picked.clear();
                              }

                              isTap = !isTap;
                              setState(() {
                                log("item picked : ${item_picked.values}");
                              });
                            },
                            child: ItemStuff(context,
                                aset: "${item_data[index]['item']}",
                                label: "${item_data[index]['harga']}",
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
              PromotionCard(context, asset: item_data[2]['item']),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 120.h,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: item_data3.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 7.w),
                        child: ItemStuff(context,
                            aset: "${item_data3[index]['item']}",
                            label: "${item_data3[index]['harga']}",
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
                child: ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: item_data2.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 7.w),
                        child: ItemStuff(context,
                            aset: "${item_data2[index]['item']}",
                            label: "${item_data2[index]['harga']}",
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
