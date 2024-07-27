import 'package:bank_sampah/Partials/Card/HistoryCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryActivity extends StatefulWidget {
  const HistoryActivity({Key? key}) : super(key: key);

  @override
  _HistoryActivityState createState() => _HistoryActivityState();
}

class _HistoryActivityState extends State<HistoryActivity> {
  
  List<dynamic> item = [
    {
      "non" : 4.5,
      "organik" : 2.0,
      "non_item" : "Botol, Kertas, Kaca", 
      "organik_item" : "Sisa makanan",
      "poin" : 15000,
      "name" : "Renal",
      "address" : "Jln.Tlogosari Utara No.IV",
      "asset" : "assets/images/teflon.png", 
      "user" : "assets/images/man_119.webp",
    },
    {
      "non" : 6.0,
      "organik" : 0.0,
      "non_item" : "Botol, Kaca", 
      "organik_item" : "",
      "poin" : 20000,
      "name" : "Tedjo Blangkon",
      "address" : "Dusun Ngernak",
      "asset" : "assets/images/ember.png", 
      "user" : "assets/images/sd.jpeg",
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color.fromRGBO(70, 178, 133, 1),
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(99, 215, 167, 1),
        body: Column(
          children: [
            SizedBox(height: 50.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "History Transaksi",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Bree",
                    fontSize: 20.sp,
                  ),
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/sd.jpeg"),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: item.length,
                itemBuilder: (_, index){
                  return Padding(
                    padding: EdgeInsets.all(10.dm),
                    child: HistoryCard(
                      context, 
                      non: item[index]["non"],
                      organik: item[index]["organik"],
                      poin: item[index]["poin"],
                      asset: item[index]["asset"],
                      non_item: item[index]["non_item"],
                      organik_item: item[index]["organik_item"],
                      user: item[index]["user"],
                      name: item[index]["name"],
                      address: item[index]["address"]),
                  );
                }),
            )
          ],
        ),
      ),
    );
  }
}
