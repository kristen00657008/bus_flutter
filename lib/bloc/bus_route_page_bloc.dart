import 'dart:async';

import 'package:bus/bean/bus/route_bean/route_bean.dart';
import 'package:bus/bean/bus/stop_of_route_bean/stop_of_route_bean.dart';
import 'package:bus/http/bus/bus_repository.dart';
import 'package:bus/route/base_bloc.dart';
import 'package:bus/route/page_bloc.dart';
import 'package:bus/route/page_name.dart';
import 'package:bus/ui/bus_route_page.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BusRoutePageBloc extends PageBloc {
  BusRoutePageBloc(BlocOption blocOption) : super(blocOption);

  final BusRepository _busRepository = BusRepository();

  RouteBean get busRoute => option.query[BlocOptionKey.BusRouteKey];

  late TabController tabController;

  final BehaviorSubject<List<StopOfRouteBean>> _stopOfRouteSubject =
      BehaviorSubject.seeded([]);

  Stream<List<StopOfRouteBean>> get stopOfRouteStream =>
      _stopOfRouteSubject.stream;

  final BehaviorSubject<Animation> _indicatorAnimationSubject =
  BehaviorSubject();

  Stream<Animation> get indicatorAnimationStream =>
      _indicatorAnimationSubject.stream;

  late AnimationController indicatorController;
  late Animation indicatorAnimation;
  late Timer _indicatorTimer;

  void init(BusRoutePageState state) {
    indicatorCycle(state);
    _indicatorTimer = Timer.periodic(Duration(seconds: 11), (timer) {
      indicatorController.reset();
      indicatorCycle(state);
    });
  }

  void indicatorCycle(BusRoutePageState state) {
    indicatorController = AnimationController(
      vsync: state,
      duration: Duration(seconds: 10),
      animationBehavior: AnimationBehavior.preserve
    )..forward();
    indicatorAnimation =
        Tween<double>(begin: 1, end: 0).animate(indicatorController);
    _indicatorAnimationSubject.add(indicatorAnimation);

    Future.delayed(Duration(seconds: 10), () {
      if (!state.mounted) return;
      indicatorController.reset();
      indicatorController = AnimationController(
        vsync: state,
        duration: Duration(seconds: 1),
      )..forward();
      indicatorAnimation =
          Tween<double>(begin: 0, end: 1).animate(indicatorController);
      _indicatorAnimationSubject.add(indicatorAnimation);
    });
  }

  void getStopOfRoute() {
    _busRepository
        .getStopOfRoute(busRoute.routeUID, busRoute.routeName.tw, busRoute.city)
        .listen((event) {
      _stopOfRouteSubject.add(event);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _indicatorTimer.cancel();
  }
}
