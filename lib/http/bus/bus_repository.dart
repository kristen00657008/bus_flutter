// ignore_for_file: constant_identifier_names

import 'package:bus/bean/bus/estimatedTimeOfArrival_bean/estimatedTimeOfArrival_bean.dart';
import 'package:bus/bean/bus/route_bean/route_bean.dart';
import 'package:bus/bean/bus/stop_of_route_bean/stop_of_route_bean.dart';
import 'package:bus/http/bus/bus_request_service.dart';

class BusRepository {
  static final _singleton = BusRepository._internal();

  BusRepository._internal();

  static BusRepository getInstance() => _singleton;

  factory BusRepository() => _singleton;

  final BusRequestService _busRequestService = BusRequestService();

  Stream<List<RouteBean>> getRoute(String routeName, String city) {
    return _busRequestService.getRoute(routeName, city).map((response) {
      var result1 = response.data as List<dynamic>;
      List<RouteBean> result2 = [];
      for (var element in result1) {
        result2.add(RouteBean.fromJson(Map<String, dynamic>.from(element)));
      }
      return result2;
    });
  }

  Stream<List<StopOfRouteBean>> getStopOfRoute(
      String routeUID, String routeName, String city) {
    return _busRequestService
        .getStopOfRoute(
      routeName,
      city,
    )
        .map((response) {
      var result = response.data as List<dynamic>;
      List<StopOfRouteBean> result2 = [];
      for (var e in result) {
        StopOfRouteBean stopOfRoute =
            StopOfRouteBean.fromJson(Map<String, dynamic>.from(e));
        if (stopOfRoute.routeUID == routeUID) {
          result2.add(stopOfRoute);
        }
      }
      return result2;
    });
  }

  Stream<List<EstimatedTimeOfArrivalBean>> getEstimatedTimeOfArrival(
      String routeUID, String routeName, String city) {
    return _busRequestService
        .getEstimatedTimeOfArrival(routeName, city)
        .map((response) {
      var result = response.data as List<dynamic>;
      List<EstimatedTimeOfArrivalBean> result2 = [];
      for (var e in result) {
        EstimatedTimeOfArrivalBean estimatedTimeOfArrivalBean =
        EstimatedTimeOfArrivalBean.fromJson(Map<String, dynamic>.from(e));
        if (estimatedTimeOfArrivalBean.routeUID == routeUID) {
          result2.add(estimatedTimeOfArrivalBean);
        }
      }
      return result2;
    });
  }
}
