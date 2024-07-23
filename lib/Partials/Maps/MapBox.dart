import 'dart:async';
import 'package:bank_sampah/Partials/IconMarker/IconMarker.dart';
import 'package:bank_sampah/ViewModel/MapsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

var marker_user;
var mpController = Get.put(MapsController());

Widget MapBoxDonatur(
    BuildContext context, var controller, dynamic point,
    {bool? isDraw = false,
    bool? isPicker = false,
    bool? isTrack = true,
    double? lat,
    double? long,
    bool? isUserTrack = true,
    double? lat_recipient,
    double? long_recipient,
    String? role}) {
  return OSMFlutter(
    onMapIsReady: (condition) async {
      if (condition == true && isDraw == true) {
        // Ensure the getUserLocation method returns a valid location
        try {
          var userLocation = await mpController.getUserLocation();
          if (userLocation != null) {
            await controller.drawRoad(
              GeoPoint(
                  latitude: userLocation.latitude,
                  longitude: userLocation.longitude),
              GeoPoint(latitude: lat!, longitude: long!),
              roadType: RoadType.bike,
              roadOption: RoadOption(
                roadWidth: 10,
                roadColor: Color.fromRGBO(48, 122, 89, 1),
              ),
            );
          }

          // mpController.roadInfo!.value;
        } finally {
          mpController.isLoading.value = false;
        }
      } else if (condition == true && isDraw == true && isUserTrack == false) {
        try {
          var userLocation = await mpController.getUserLocation();
          if (userLocation != null) {
            await controller.drawRoad(
              GeoPoint(latitude: lat!, longitude: long!),
              GeoPoint(latitude: lat_recipient!, longitude: long_recipient!),
              roadType: RoadType.bike,
              roadOption: RoadOption(
                roadWidth: 10,
                roadColor: Color.fromRGBO(48, 122, 89, 1),
              ),
            );
          }
          // mpController.roadInfo!.value;
        } finally {
          mpController.isLoading.value = false;
        }
      }
    },
    osmOption: OSMOption(
      isPicker: isPicker ?? false,
      markerOption: MarkerOption(
          defaultMarker: MarkerIcon(
        icon: Icon(
          Icons.person_pin_circle,
          color: Colors.blue,
          size: 56,
        ),
      )),
      staticPoints: (point != null) ? point : [],
      showDefaultInfoWindow: true,
      showZoomController: false,
      userTrackingOption: UserTrackingOption(
        enableTracking: false,
        unFollowUser: true,
      ),
      zoomOption: const ZoomOption(
        initZoom: 15,
        minZoomLevel: 3,
        maxZoomLevel: 18,
        stepZoom: 1.0,
      ),
      userLocationMarker: (isUserTrack == false)
          ? null
          : UserLocationMaker(
              personMarker: MarkerIcon(
                iconWidget: IconMaker(),
              ),
              directionArrowMarker: MarkerIcon(
                iconWidget: IconMaker(),
              ),
            ),
    ),
    controller: controller,
  );
}
