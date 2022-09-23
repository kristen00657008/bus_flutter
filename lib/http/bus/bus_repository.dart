// ignore_for_file: constant_identifier_names

import 'package:bus/bean/bus/route_bean/route_bean.dart';
import 'package:bus/http/bus/bus_request_service.dart';

class BusRepository {
  static final _singleton = BusRepository._internal();

  BusRepository._internal();

  static BusRepository getInstance() => _singleton;

  factory BusRepository() => _singleton;

  final BusRequestService _busRequestService = BusRequestService();

  Stream<List<RouteBean>> getRouteData(String routeName, String city) {
    return _busRequestService.getBusRoute(routeName, city).map((response) {
      var result1 = response.data as List<dynamic>;
      List<RouteBean> result2 = [];
      for (var element in result1) {
        result2.add(RouteBean.fromJson(Map<String, dynamic>.from(element)));
      }
      return result2;
      // return RouteBean.fromJson(Map<String, dynamic>.from(response.data));
    });
  }
}
