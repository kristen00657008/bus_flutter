import 'package:bus/bean/weather/location_data.dart';
import 'package:bus/resource/colors.dart';
import 'package:flutter/material.dart';
import 'package:bus/model/system/bottom_navigation_data.dart';
import 'package:bus/route/base_bloc.dart';
import 'package:bus/route/page_bloc.dart';
import 'package:bus/route/page_name.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' show cos, sqrt, asin;

class DefaultPageBloc extends PageBloc {
  DefaultPageBloc(BlocOption blocOption) : super(blocOption);

  String currentCity = "";

  List<BottomNavigationData> bottomNavigationList = [
    BottomNavigationData(
        type: BottomNavigationEnum.homePage,
        icon: Icons.house,
        title: "HomePage",
        url: PageName.HomePage),
    BottomNavigationData(
        type: BottomNavigationEnum.locationPage,
        icon: Icons.location_on,
        title: "LocationPage",
        url: PageName.LocationPage),
    BottomNavigationData(
        type: BottomNavigationEnum.mrtPage,
        icon: Icons.train_outlined,
        title: "MRTPage",
        url: PageName.MRTPage),
    BottomNavigationData(
        type: BottomNavigationEnum.settingPage,
        icon: Icons.settings,
        title: "SettingPage",
        url: PageName.SettingPage)
  ];

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void getLocate() {
    determinePosition().then((value) {
        currentCity = getCurrentCity(value.latitude, value.longitude);
        print(currentCity);
    });
  }

  String getCurrentCity(currentLat, currentLon){
    var p = 0.017453292519943295;
    var c = cos;
    var cityIndex = 0;
    var minDistance = double.maxFinite;

    locates.asMap().forEach((index, locate) {
      var lat = double.parse(locate.lat);
      var lon = double.parse(locate.lon);

      var a = 0.5 - c((lat - currentLat) * p)/2 +
          c(currentLat * p) * c(lat * p) *
              (1 - c((lon - currentLon) * p))/2;
      var distance = 12742 * asin(sqrt(a));
      if(distance < minDistance) {
        minDistance = distance;
        cityIndex = index;
      }
    });

    return cities[cityIndex];
  }
}
