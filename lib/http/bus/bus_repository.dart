// ignore_for_file: constant_identifier_names

import 'package:bus/bean/bus/route_bean/route_bean.dart';
import 'package:bus/http/bus/bus_request_service.dart';

class BusRepository {
  static final _singleton = BusRepository._internal();

  BusRepository._internal();

  static BusRepository getInstance() => _singleton;

  factory BusRepository() => _singleton;

  final BusRequestService _busRequestService = BusRequestService();

  Stream<RouteBean> getRouteData(String routeName, String city) {
    return _busRequestService.getBusRoute(routeName, city).map((response) {
      return RouteBean.fromJson(Map<String, dynamic>.from(response.data));
    });
  }
}
