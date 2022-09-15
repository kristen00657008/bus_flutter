import 'package:flutter/material.dart';

class BottomNavigationData {
  final BottomNavigationEnum type;

  final IconData icon;

  final String title;

  final String url;

  BottomNavigationData({
    required this.type,
    required this.icon,
    required this.title,
    required this.url,
  });
}

enum BottomNavigationEnum {
  homePage,

  locationPage,

  mrtPage,

  settingPage,
}
