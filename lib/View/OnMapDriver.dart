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

class OnMapDriver extends StatefulWidget {
  const OnMapDriver({Key? key}) : super(key: key);

  @override
  _OnMapDriverState createState() => _OnMapDriverState();
}

class _OnMapDriverState extends State<OnMapDriver> {
  MapsController mpController = Get.put(MapsController());
  List<StaticPositionGeoPoint>? koordinat;
  final StreamController<GeoPoint> streamController =
      StreamController<GeoPoint>();
  Timer? locationUpdateTimer;
  RoadInfo? roadinfo;

  GeoPoint p =
      GeoPoint(latitude: -5.135581582936737, longitude: 119.4355839050661);
  GeoPoint r = GeoPoint(latitude: -5.141533, longitude: 119.435011);

  Future<void> applyKoordinat() async {
    startLocationUpdates();
  }

  @override
  void initState() {
    super.initState();
    applyKoordinat();
  }

  Future<void> drawRoute(GeoPoint recipientLocation) async {
    await mpController.controller.removeLastRoad();
    roadinfo = await mpController.controller.drawRoad(r, p,
        roadType: RoadType.bike,
        roadOption: const RoadOption(
            roadColor: Color.fromRGBO(42, 122, 89, 1),
            roadBorderColor: Color.fromRGBO(42, 122, 89, 1),
            zoomInto: true,
            roadWidth: 10));
  }

  void startLocationUpdates() {
    locationUpdateTimer = Timer.periodic(Duration(seconds: 10), (timer) async {
      try {
        // mpController.setMarker(p, "assets/images/motor.png");
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
            StreamBuilder<GeoPoint>(
                stream: streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    drawRoute(snapshot.data!);
                  }
                  return SingleChildScrollView(
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.8,
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
                                            image: AssetImage(
                                                "assets/images/sd.jpeg"),
                                            fit: BoxFit.fill)),
                                  ),
                                  Text(
                                    "Indra Sjafri",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontSize: 12.sp),
                                  )
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 140.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.dm)),
                                child: Padding(
                                  padding: EdgeInsets.all(4.dm),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Text(
                                        "Renal",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                          width: 150.w,
                                          child: Text(
                                            "Jl.Tlogosari Utara No.IV",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Poppins",
                                                fontSize: 14.sp),
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
                                            Center(
                                              child: CircleAvatar(
                                                backgroundColor: Colors.green,
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
                              onTap: () {
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
