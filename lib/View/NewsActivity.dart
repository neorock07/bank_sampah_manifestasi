import 'package:bank_sampah/Partials/Card/NewsCard.dart';
import 'package:bank_sampah/Partials/Pagination/PaginationView.dart';
import 'package:bank_sampah/Partials/Search/SearchCard.dart';
import 'package:bank_sampah/ViewModel/TransactionController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewsActivity extends StatefulWidget {
  const NewsActivity({Key? key}) : super(key: key);

  @override
  _NewsActivityState createState() => _NewsActivityState();
}
//halaman untuk berita
class _NewsActivityState extends State<NewsActivity> {
  TextEditingController controller = TextEditingController();
  TransactionController trans = Get.put(TransactionController());

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
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(99, 215, 167, 1),
              Color.fromRGBO(176, 201, 177, 1)
            ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
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
                              onTap: () {
                                trans.getTotalPoint();
                              },
                              child: const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/sd.jpeg"),
                              ),
                            )
                          ],
                        ),
                        //profile user
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
                      height: 10.h,
                    ),
                    //widget search bar
                    SearchCard(context,
                        controller: controller, hint: "Cari berita"),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.dm)),
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                        //list view untuk card berita
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  //tampilkan data dummy ke widget card news
                                  NewsCard(context,
                                      asset: "assets/images/ember.png"),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: const Divider(
                                        color: Colors.grey,
                                      )),
                                ],
                              );
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    //membuat pagination (nomor halaman)
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: PaginationView(context))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
