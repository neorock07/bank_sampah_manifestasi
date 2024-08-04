import 'package:bank_sampah/Partials/Card/DriverCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListDriverActivity extends StatefulWidget {
  const ListDriverActivity({Key? key}) : super(key: key);

  @override
  _ListDriverActivityState createState() => _ListDriverActivityState();
}

class _ListDriverActivityState extends State<ListDriverActivity> {
  //list data static driver
  List<dynamic> list_item = [
    {
      "asset" : "assets/images/man_119.webp",
      "name" : "Tedjo Blangkon",
      "jarak" : 1.3
    },
    {
      "asset" : "assets/images/man_69.webp",
      "name" : "Si Doel",
      "jarak" : 1.7
    },
    {
      "asset" : "assets/images/man_21.webp",
      "name" : "Wiranto",
      "jarak" : 2.3
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(99, 215, 167, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.only(left:20.w),
            child: Text("Driver Terdekat", style: TextStyle(
              color: Colors.black, 
              fontFamily: "Poppins", 
              fontSize: 18.sp, 
              fontWeight: FontWeight.bold
            ),),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.8,
            //membuat list driver dengan data static tadi
            child: ListView.builder(
              itemCount: list_item.length,
              itemBuilder: (_, index){
                return Padding(
                  padding: EdgeInsets.all(10.dm),
                  //dengan widget driver card untuk menampilkan data driver
                  child: DriverCard(
                    context,
                    name: list_item[index]['name'],
                    asset: list_item[index]['asset'],
                    jarak: list_item[index]['jarak']
                    ),
                );
              }),
          ),
          
        ],
      ),
    );
  }
}
