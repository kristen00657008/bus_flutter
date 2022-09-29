import 'dart:async';

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

  ScrollController homePageController = ScrollController();

  FocusNode searchFieldFocusNode = FocusNode();

  /// 是否在搜尋
  final BehaviorSubject<bool> _isSearchingSubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get isSearchingStream => _isSearchingSubject.stream;

  /// 是否顯示歷史紀錄
  final BehaviorSubject<bool> _showHistorySubject =
      BehaviorSubject.seeded(true);

  Stream<bool> get showHistoryStream => _showHistorySubject.stream;

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

  final debounce = Debounce(milliseconds: 400);

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
      _showHistorySubject.add(false);
      debounce.run(() async {
        List<RouteBean> allRoute = [];
        var isFirst = true;
        for (var city in cities) {
          isFirst = allRoute.isEmpty;
          allRoute.addAll(await searchRoutes(text, city.englishName));
          if (isFirst) _routeBeanSubject.add(allRoute);
        }
        _routeBeanSubject.add(allRoute);
      });
    } else {
      _showHistorySubject.add(true);
      _routeBeanSubject.add([]);
    }
  }

  void searchTextClear() {
    searchTextChange("");
    searchController.clear();
    _routeBeanSubject.add([]);
  }

  Future<List<RouteBean>> searchRoutes(String routeName, String city) async {
    var firstValueReceived = Completer<List<RouteBean>>();
    _busRepository.getRoute(routeName, city).listen((event) {
      event = sorting(routeName, event);
      firstValueReceived.complete(event);
    });
    return firstValueReceived.future;
  }

  List<RouteBean> sorting(String routeName, List<RouteBean> routeData) {
    routeData.sort((a, b) {
      var aValue = parseIntPrefix(a.routeName.tw);
      var bValue = parseIntPrefix(b.routeName.tw);
      if (aValue != null && bValue != null) {
        if(a.routeName.tw.startsWith(routeName) ) {
          return aValue - bValue;
        } else {
          return 0;
        }

      }

      if (aValue == null && bValue == null) {
        // If neither string has an integer prefix, sort the strings lexically.
        return a.routeName.tw.compareTo(b.routeName.tw);
      }

      // Sort strings with integer prefixes before strings without.
      if (aValue == null) {
        return 1;
      } else {
        return -1;
      }
    });

    return routeData;
  }

  int? parseIntPrefix(String s) {
    var re = RegExp(r'(-?[0-9]+).*');
    var match = re.firstMatch(s);
    if (match == null) {
      return null;
    }
    return int.parse(match.group(1)!);
  }

  @override
  void dispose() {}
}
