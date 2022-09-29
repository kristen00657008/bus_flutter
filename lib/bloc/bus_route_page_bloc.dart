import 'package:bus/bean/bus/route_bean/route_bean.dart';
import 'package:bus/bean/bus/stop_of_route_bean/stop_of_route_bean.dart';
import 'package:bus/http/bus/bus_repository.dart';
import 'package:bus/route/base_bloc.dart';
import 'package:bus/route/page_bloc.dart';
import 'package:bus/route/page_name.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BusRoutePageBloc extends PageBloc {
  BusRoutePageBloc(BlocOption blocOption) : super(blocOption);

  final BusRepository _busRepository = BusRepository();

  RouteBean get busRoute =>
      option.query[BlocOptionKey.BusRouteKey];

  late TabController controller;

  final BehaviorSubject<List<StopOfRouteBean>> _stopOfRouteSubject =
      BehaviorSubject.seeded([]);

  Stream<List<StopOfRouteBean>> get stopOfRouteStream =>
      _stopOfRouteSubject.stream;

  Future<List<StopOfRouteBean>> getStopOfRoute() {
    return _busRepository
        .getStopOfRoute(busRoute.routeUID, busRoute.routeName.tw, busRoute.city)
        .firstWhere((element) {
      return true;
    });
  }
}
