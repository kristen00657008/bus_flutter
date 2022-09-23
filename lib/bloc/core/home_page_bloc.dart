import 'package:bus/bean/bus/route_bean/route_bean.dart';
import 'package:bus/bean/weather/weather_bean.dart';
import 'package:bus/bloc/system/application_bloc.dart';
import 'package:bus/http/bus/bus_repository.dart';
import 'package:bus/http/weather/weather_repository.dart';
import 'package:bus/resource/city_data.dart';
import 'package:bus/route/base_bloc.dart';
import 'package:bus/route/page_bloc.dart';
import 'package:bus/util/debounce.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomePageBloc extends PageBloc {
  HomePageBloc(BlocOption blocOption) : super(blocOption);

  final WeatherRepository _weatherRepository = WeatherRepository();

  final BusRepository _busRepository = BusRepository();

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

  /// 搜尋文字流
  final BehaviorSubject<String> _searchTextSubject = BehaviorSubject.seeded("");

  Stream<String> get searchTextStream => _searchTextSubject.stream;

  /// 公車路線流
  final BehaviorSubject<List<RouteBean>> _routeBeanSubject =
      BehaviorSubject.seeded([]);

  Stream<List<RouteBean>> get routeBeanStream => _routeBeanSubject.stream;

  double get expandHeight => _expandHeightAnimation.value;

  double get appBarHeight => _appBarHeightAnimation.value;

  late TextEditingController searchController;

  final debounce = Debounce(milliseconds: 100);

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

    searchController = TextEditingController();
  }

  void setCity(String city) {
    ApplicationBloc.getInstance().currentCity = city;
  }

  void getWeather() {
    _weatherRepository
        .getWeather(ApplicationBloc.getInstance().currentCity)
        .listen((event) {
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

  void searchTextChange(String text) {
    _searchTextSubject.add(text);
    if (text.isNotEmpty) {
      debounce.run(() {
        getRouteData(text, cities.first.englishName);
      });
    } else {
      _routeBeanSubject.add([]);
    }
  }

  void searchTextClear() {
    searchTextChange("");
    searchController.clear();
    _routeBeanSubject.add([]);
  }

  void getRouteData(String routeName, String city) {
    _busRepository.getRouteData(routeName, city).listen((event) {
      _routeBeanSubject.add(sorting(routeName, event));
    });
  }

  List<RouteBean> sorting(String routeName, List<RouteBean> routeData) {
    routeData.sort((a, b) {
      return a.subRoutes.first.subRouteName.tw.startsWith(routeName) ? -1 : 1;
    });
    return routeData;
  }

  @override
  void dispose() {}
}
