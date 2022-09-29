import 'package:bus/bean/bus/route_bean/route_bean.dart';

class BusRouteQueryData {
  final String routeName;

  final String city;

  final String routeUID;

  final List<SubRouteBean> subRoutes;

  BusRouteQueryData({
    required this.routeName,
    required this.city,
    required this.routeUID,
    required this.subRoutes
  });
}
