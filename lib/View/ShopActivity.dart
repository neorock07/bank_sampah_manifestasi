import 'package:bank_sampah/Partials/Card/DashboardCard.dart';
import 'package:bank_sampah/Partials/Card/ItemStuff.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Partials/Search/SearchCard.dart';

class ShopActivity extends StatefulWidget {
  const ShopActivity({Key? key}) : super(key: key);

  @override
  _ShopActivityState createState() => _ShopActivityState();
}

class _ShopActivityState extends State<ShopActivity> {
  TextEditingController searchController = TextEditingController();
  
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 60.h,
            ),
            Stack(
              children: [
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
                    padding: EdgeInsets.only(right:12.w),
                    child: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/sd.jpeg"),
                                ),
                  ),
                )      
          ]),
            Padding(
              padding: EdgeInsets.only(left:20.w, top: 15.h, bottom:10.h),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Penukaran Poin", style: TextStyle(
                  color: Colors.black, 
                  fontFamily: "Bree", 
                  fontSize: 20.sp
                ),),
              ),
            ),
            SearchCard(context, controller: searchController),
            ItemStuff(context, aset: "assets/images/ember.png", label: "Ember")
          ],
        ),
      ),
    );
  }
}
