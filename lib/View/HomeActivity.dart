import 'package:bank_sampah/Partials/Button/HomeButton.dart';
import 'package:bank_sampah/Partials/Card/DashboardCard.dart';
import 'package:bank_sampah/ViewModel/HomeChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Partials/Dialog/DialogPop.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({Key? key}) : super(key: key);

  @override
  _HomeActivityState createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  //inisiasi chart controller
  HomeChartController chartController = Get.put(HomeChartController());

  RxString name = "".obs;
  SharedPreferences? pref;
  //get user akun data dari shared preferences
  Future<void> getUserData() async {
    pref = await SharedPreferences.getInstance();
    name.value = pref!.getString("nama")!;
  }

  //menjalaknkan function tersbut saat halaman pertama kali dibuka
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(99, 215, 167, 0.58),
              Color.fromRGBO(176, 201, 177, 1)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Selamat Datang",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Bree",
                                fontSize: 20.sp,
                              ),
                            ),
                            InkWell(
                              //profile ketika di klik tampil alert dialog dan tombol log out
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
                                                    MaterialStatePropertyAll(
                                                        Colors.green)),
                                            onPressed: () {
                                              //hapus data login yang ada pada shared preferences
                                              pref!.clear();
                                              //pergi ke halaman login setelah dihapus
                                              Navigator.pushReplacementNamed(
                                                  context, "/login");
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
                                backgroundImage:
                                    AssetImage("assets/images/avatar.png"),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 45.w, top: 5.h),
                          child: Obx(() => Text(
                                name.value,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 14.sp,
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    //widget dahsboard informasi jumlah sampah yang terkumpul , dll edit nilai widget ini apabila diperlukan
                    DashboardCard(context, background: Colors.white),
                    SizedBox(
                      height: 5.h,
                    ),
                    //button penjemputan
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey,
                        hoverColor: Colors.grey,
                        onTap: () {
                          //pergi ke halaman penjemptan
                          Navigator.pushNamed(context, "/penjemputan");
                        },
                        child: HomeButton(context,
                            label: "Penjemputan",
                            asset: "assets/images/motor.png"),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    //button penukaran poin
                    InkWell(
                      onTap: () {
                        //pergi ke halaman penukaran
                        Navigator.pushNamed(context, "/penukaran");
                      },
                      child: HomeButton(context,
                          label: "Penukaran Poin",
                          asset: "assets/images/troli.png"),
                    ),
                    SizedBox(height: 5.h),
                    //button untuk ke berita
                    InkWell(
                      onTap: () {
                        //pergi ke halaman news 
                        Navigator.pushNamed(context, "/news");
                      },
                      child: HomeButton(context,
                          label: "Berita", asset: "assets/images/news.png"),
                    ),
                    SizedBox(height: 5.h),
                    Obx(() => Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, left: 10.w, bottom: 30.h),
                          //membuat pie chart dari data yang ada pada chart controller
                          child: PieChart(
                            dataMap: chartController.data.value,
                            chartType: ChartType.disc,
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                              decimalPlaces: 1,
                            ),
                          ),
                        ))
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
