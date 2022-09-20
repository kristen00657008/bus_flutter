import 'package:bus/bean/weather/weather_bean.dart';
import 'package:bus/bloc/system/application_bloc.dart';
import 'package:bus/http/weather/weather_repository.dart';
import 'package:bus/route/base_bloc.dart';
import 'package:bus/route/page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomePageBloc extends PageBloc {
  HomePageBloc(BlocOption blocOption) : super(blocOption);

  final WeatherRepository _weatherRepository = WeatherRepository();

  late AnimationController controller;

  late Animation<double> _expandHeightAnimation;

  late Animation<double> _appBarHeightAnimation;

  /// 是否在搜尋
  final BehaviorSubject<bool> _isSearchingSubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get isSearchingStream => _isSearchingSubject.stream;

  /// 天氣資料流
  final BehaviorSubject<WeatherBean> _weatherBeanSubject = BehaviorSubject();

  Stream<WeatherBean> get weatherBeanStream => _weatherBeanSubject.stream;

  double get expandHeight => _expandHeightAnimation.value;

  double get appBarHeight => _appBarHeightAnimation.value;

  void init(TickerProvider tickerProvider) {
    ApplicationBloc.getInstance().getLocate().then((_) {
      getWeather();
    });
    controller = AnimationController(
        vsync: tickerProvider, duration: Duration(milliseconds: 200))
      ..reverse();
    _expandHeightAnimation =
        Tween<double>(begin: 200.0, end: 0).animate(controller);
    _appBarHeightAnimation =
        Tween<double>(begin: kToolbarHeight, end: 0).animate(controller);
  }

  void setCity(String city) {
    ApplicationBloc.getInstance().currentCity = city;
  }

  void getWeather() {
    _weatherRepository.getWeather(ApplicationBloc.getInstance().currentCity).listen((event) {
      _weatherBeanSubject.add(event);
    });
  }

  void setIsSearching(bool isSearching) {
    _isSearchingSubject.add(isSearching);
  }

  void changeToSearching() {
    controller.forward();
  }

  void changeToHomePage() {
    controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
  }
}
