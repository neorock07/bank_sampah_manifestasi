import 'package:bank_sampah/Partials/Button/BaseButton.dart';
import 'package:bank_sampah/Partials/Card/ItemOptionCard.dart';
import 'package:bank_sampah/Partials/ClipPath/BaseClip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PenjemputanActivity extends StatefulWidget {
  const PenjemputanActivity({Key? key}) : super(key: key);

  @override
  _PenjemputanActivityState createState() => _PenjemputanActivityState();
}

class _PenjemputanActivityState extends State<PenjemputanActivity> {
  List<dynamic> non_organik = [
    {
    "item" : "Botol",
    "kondisi" : false.obs
    },
    {
    "item" : "Kertas",
    "kondisi" : false.obs
    },
    {
    "item" : "Kaleng",
    "kondisi" : false.obs
    },
    {
    "item" : "Kaca",
    "kondisi" : false.obs
    },
    {
    "item" : "Kardus",
    "kondisi" : false.obs
    },
    ];
  List<dynamic> organik = [
    {
    "item" : "Sampah makanan",
    "kondisi" : false.obs
    }, 
    {
    "item" : "Tanaman",
    "kondisi" : false.obs
    }, 
    ];
  Set<String> non_selected = {};
  Set<String> organik_selected = {};

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
                      child: BaseButton(
                        context,

                        height: 40.h,
                        width: MediaQuery.of(context).size.width * 0.9,
                        label: "MEMESAN",
                        color: Color.fromRGBO(217, 217, 217, 1),
                        fontColor: Colors.black,
                        borderRadius: 10.dm,
                        onTap: (){
                           Navigator.pushNamed(context, "/onmap"); 
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
