import 'package:bank_sampah/Partials/Button/HomeButton.dart';
import 'package:bank_sampah/Partials/Card/DashboardCard.dart';
import 'package:bank_sampah/ViewModel/HomeChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({Key? key}) : super(key: key);

  @override
  _HomeActivityState createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  var chartController = Get.put(HomeChartController());

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
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/sd.jpeg"),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 45.w, top: 5.h),
                          child: Text(
                            "Sin Te Yong",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    DashboardCard(context),
                    SizedBox(
                      height: 5.h,
                    ),
                    HomeButton(context,
                        label: "Penjemputan", asset: "assets/images/motor.png"),
                    SizedBox(height: 5.h),
                    HomeButton(context,
                        label: "Penukaran Poin",
                        asset: "assets/images/troli.png"),
                    SizedBox(height: 5.h),
                    HomeButton(context,
                        label: "Berita", asset: "assets/images/news.png"),
                    SizedBox(height: 5.h),
                    Obx(() => Padding(
                      padding: EdgeInsets.only(top: 10.h, left: 10.w, bottom: 30.h),
                      child: PieChart(
                            dataMap: chartController.data.value,
                            chartType: ChartType.disc,
                            chartValuesOptions: ChartValuesOptions(
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
