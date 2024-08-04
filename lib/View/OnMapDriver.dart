import 'dart:async';
import 'dart:developer';
import 'package:bank_sampah/Partials/IconMarker/IconMarker.dart';
import 'package:bank_sampah/Partials/Maps/MapBox.dart';
import 'package:bank_sampah/ViewModel/MapsController.dart';
import 'package:bank_sampah/ViewModel/TransactionController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OnMapDriver extends StatefulWidget {
  OnMapDriver({
    super.key,
    this.asset, 
    this.alamat, 
    this.nama, 
    this.item, 
    this.id_user
  });

  //buat variable untuk menerima data dari halaman sebelumnya
  String? asset, alamat, nama, item, id_user;

  @override
  _OnMapDriverState createState() => _OnMapDriverState();
}

class _OnMapDriverState extends State<OnMapDriver> {
  //inisiasi map controller dan transaction controller
  MapsController mpController = Get.put(MapsController());
  TransactionController transController = Get.put(TransactionController());
  //buat list untuk diisi koordinat dan stream controller untuk diisi koordinat driver
  List<StaticPositionGeoPoint>? koordinat;
  final StreamController<GeoPoint> streamController =
      StreamController<GeoPoint>();
  //timer digunakan untuk perulangan update data setiap 10 detik
  Timer? locationUpdateTimer;
  //variabel untuk memuat rute jalan
  RoadInfo? roadinfo;

  //variabel untuk menyimpan koordinat user
  GeoPoint p =
      GeoPoint(latitude: -5.135581582936737, longitude: 119.4355839050661);
  //variable untuk menyimpan koordinat driver 
  GeoPoint r = GeoPoint(latitude: -5.141533, longitude: 119.435011);

  //function untuk menjalankan update rute
  Future<void> applyKoordinat() async {
    startLocationUpdates();
  }

  //menjalankan update rute saat memuat halaman pertama kali
  @override
  void initState() {
    super.initState();
    applyKoordinat();
  }

  //function untuk menggambar rute jalan dari user ke driver
  Future<void> drawRoute(GeoPoint recipientLocation) async {
    //setiap update rute harus menghapus rute sebelumnya dahulu
    await mpController.controller.removeLastRoad();
    roadinfo = await mpController.controller.drawRoad(r, p,
        roadType: RoadType.bike,
        roadOption: const RoadOption(
            roadColor: Color.fromRGBO(42, 122, 89, 1),
            roadBorderColor: Color.fromRGBO(42, 122, 89, 1),
            zoomInto: true,
            roadWidth: 10));
  }

  //function untuk menampilkan avatar dan memulai update data rute setiap 10 detik
  void startLocationUpdates() {
    //mulai menjalankan update rute setiap 10 detik
    locationUpdateTimer = Timer.periodic(Duration(seconds: 10), (timer) async {
      try {
        //set avatar marker lokasi untuk driver
        await mpController.controller.addMarker(r,
            markerIcon: MarkerIcon(
              iconWidget: IconMaker(
                link: "assets/images/motor.png",
              ),
            ));

        //set avatar marker lokasi untuk user
        await mpController.controller.addMarker(p,
            markerIcon: MarkerIcon(
              iconWidget: IconMaker(
                link: "assets/images/marker.png",
              ),
            ));
        //masukkan data update lokasi driver ke stream controller
        streamController.add(r);
      } catch (e) {
        log("Error updating location: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            //mulai untuk streaming data koordinat driver dari stream controller
            StreamBuilder<GeoPoint>(
                stream: streamController.stream,
                builder: (context, snapshot) {
                  //cek jika stream controller ada data baru maka menggambar rute jalan
                  if (snapshot.hasData) {
                    drawRoute(snapshot.data!);
                  }
                  return SingleChildScrollView(
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        //menampilkan maps beserta marker koordinat user dan driver serta rute jalan
                        child: MapBoxDonatur(
                          context,
                          mpController.controller,
                          koordinat,
                          isDraw: true,
                          isUserTrack: false,
                          lat: p.latitude,
                          long: p.longitude,
                          lat_recipient: r.latitude,
                          long_recipient: r.longitude,
                        )),
                  );
                }),
            DraggableScrollableSheet(
                minChildSize: 0.4,
                maxChildSize: 0.7,
                initialChildSize: 0.4,
                builder: (_, controller) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(70, 178, 133, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            10.dm,
                          ),
                          topRight: Radius.circular(10.dm)),
                    ),
                    //list view untuk parent widget lain
                    child: ListView(controller: controller, children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 80.dm,
                                    height: 80.dm,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.dm),
                                        image: DecorationImage(
                                            image: AssetImage(widget.asset!),
                                            fit: BoxFit.fill)),
                                  ),
                                  Text(
                                    widget.nama!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontSize: 12.sp),
                                  )
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 160.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.dm)),
                                child: Padding(
                                  padding: EdgeInsets.all(2.dm),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                          width: 200.w,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              //text untuk alamat
                                              Text(
                                                widget.alamat!,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Poppins",
                                                    fontSize: 14.sp),
                                              ),
                                              SizedBox(height: 10.h),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    LucideIcons.package,
                                                    color: Colors.red,
                                                    size: 15.dm,
                                                  ),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  SizedBox(
                                                    width: 180.w,
                                                    height: 20.h,
                                                    child: SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      child: Text(
                                                        widget.item!,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: "Poppins",
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.normal),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Center(
                                                child: SpinKitRipple(
                                              color: Colors.green,
                                              size: 70.dm,
                                              duration:
                                                  Duration(milliseconds: 1500),
                                            )),
                                            //untuk profile user
                                            Center(
                                              child: CircleAvatar(
                                                backgroundColor: Colors.green,
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.call,
                                                    color: Colors.black,
                                                  ),
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.grey,
                              hoverColor: Colors.grey,
                          //button klik untuk set alamat, pelanggan, id_user untuk digunakan mengirim ke home driver.
                              onTap: () {
                                transController.alamat.value = widget.alamat!;
                                transController.pelanggan.value = widget.nama!;
                                transController.id_user.value = widget.id_user!;
                                Navigator.pushNamed(context, "/btm_driver");
                              },
                              child: Container(
                                height: 40.h,
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 243, 243, 243),
                                    borderRadius: BorderRadius.circular(10.dm)),
                                child: Padding(
                                  padding: EdgeInsets.all(4.dm),
                                  child: Center(
                                    child: Text(
                                      "Tiba",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          )
                        ],
                      ),
                    ]),
                  );
                })
          ],
        ),
      ),
    );
  }
}
