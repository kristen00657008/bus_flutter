import 'package:flutter/material.dart';
import 'package:bus/model/system/bottom_navigation_data.dart';
import 'package:bus/route/base_bloc.dart';
import 'package:bus/route/page_bloc.dart';
import 'package:bus/route/page_name.dart';
import 'package:rxdart/rxdart.dart';

class DefaultPageBloc extends PageBloc {
  DefaultPageBloc(BlocOption blocOption) : super(blocOption);

  String currentCity = "";

  /// 底部導覽列顯示流
  final BehaviorSubject<bool> _isShowBottomSubject =
      BehaviorSubject.seeded(true);

  Stream<bool> get isShowBottomStream => _isShowBottomSubject.stream;

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

  void setIsShowBottomNavigation(bool isShow) {
    _isShowBottomSubject.add(isShow);
  }
}
