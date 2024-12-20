import 'dart:async';
import 'dart:developer';
import 'package:bank_sampah/Partials/IconMarker/IconMarker.dart';
import 'package:bank_sampah/Partials/Maps/MapBox.dart';
import 'package:bank_sampah/ViewModel/MapsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class OnMap extends StatefulWidget {
  const OnMap({Key? key}) : super(key: key);

  @override
  _OnMapState createState() => _OnMapState();
}

class _OnMapState extends State<OnMap> {
  //inisiasi controller maps
  MapsController mpController = Get.put(MapsController());
  //inisiasi list koordinat untuk menyimpan data koordinat user dan driver
  List<StaticPositionGeoPoint>? koordinat;
  //inisiasi stream controller, timer, dan roadinfo untuk data menggambar rute jalan
  final StreamController<GeoPoint> streamController =
      StreamController<GeoPoint>();
  Timer? locationUpdateTimer;
  RoadInfo? roadinfo;

//koordinat driver dan user
  GeoPoint p = GeoPoint(latitude: -5.135581582936737, longitude: 119.4355839050661);
  GeoPoint r = GeoPoint(latitude: -5.141533, longitude: 119.435011);

//function untuk menjalankan update rute jalan
  Future<void> applyKoordinat() async {
    startLocationUpdates();
  }

//menjalankan update koordinat dan rute saat halaman pertama kali dimuat
  @override
  void initState() {
    super.initState();
    applyKoordinat();

  }

  //menggambar rute jalan
  Future<void> drawRoute(GeoPoint recipientLocation) async {
    //menghapus rute jalan sebelumnya saat update rute baru
    await mpController.controller.removeLastRoad();
    roadinfo = await mpController.controller.drawRoad(r, p,
        roadType: RoadType.bike,
        roadOption: const RoadOption(
            roadColor: Color.fromRGBO(42, 122, 89, 1),
            roadBorderColor: Color.fromRGBO(42, 122, 89, 1),
            zoomInto: true,
            roadWidth: 10));
  }

  //function untuk menampilkan avatar user dan driver serta update lokasi dan rute
  void startLocationUpdates() {
   //update stiap 10 detik
    locationUpdateTimer = Timer.periodic(Duration(seconds: 10), (timer) async {
      try {
        await mpController.controller.addMarker(r,
            markerIcon: MarkerIcon(
              iconWidget: IconMaker(
                link: "assets/images/motor.png",
              ),
            ));

         await mpController.controller.addMarker(p,
            markerIcon: MarkerIcon(
              iconWidget: IconMaker(
                link: "assets/images/marker.png",
              ),
            ));    
        
        streamController.add(p);
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
            //menjalankan streaming data lokasi
            StreamBuilder<GeoPoint>(
                stream: streamController.stream,
                builder: (context, snapshot) {
                  //cek apakah data koordinat tidak kosong
                  if (snapshot.hasData) {
                    //jika tidak kosong maka menggambar rute jalan
                    drawRoute(snapshot.data!);
                  }
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      //menampilkan maps beserta avatar marker, rute jalan
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
                      ));
                }),
            DraggableScrollableSheet(
                minChildSize: 0.3,
                maxChildSize: 0.3,
                initialChildSize: 0.3,
                builder: (_, controller) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(70, 178, 133, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            10.dm,
                          ),
                          topRight: Radius.circular(10.dm)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Stack(alignment: Alignment.center, children: [
                              Center(
                                  child: SpinKitRipple(
                                color: Colors.white,
                                size: 70.dm,
                                duration: Duration(milliseconds: 1500),
                              )),
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.call,
                                      color: Colors.black,
                                    ),
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ]),
                            Column(
                              children: [
                                //menampilkan profile driver
                                Container(
                                  width: 80.dm,
                                  height: 80.dm,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.dm),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/avatar.png"),
                                          fit: BoxFit.fill)),
                                ),
                                Text(
                                  "Driver 467",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 12.sp),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10.h),
                        IntrinsicHeight(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 243, 243, 243),
                                borderRadius: BorderRadius.circular(10.dm)),
                            child: Padding(
                              padding: EdgeInsets.all(4.dm),
                              child: Center(
                                child: Text(
                                  "Hampir Tiba",
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
                        SizedBox(
                          height: 20.h,
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
