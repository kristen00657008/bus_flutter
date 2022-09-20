import 'dart:math';
import 'package:bus/bean/weather/location_data.dart';
import 'package:bus/route/page_name.dart';
import 'package:bus/route/route_data.dart';
import 'package:bus/route/route_mixin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

class ApplicationBloc with RouteMixin {
  static final _singleton = ApplicationBloc._internal();

  static ApplicationBloc getInstance() => _singleton;

  factory ApplicationBloc() => _singleton;

  ApplicationBloc._internal() {
    addSubPageRoute(RouteData(PageName.HomePage));
  }

  /// 頁面歷史紀錄
  final List<RouteData> _subPageHistory = [];

  String? get lastSubPage => _subPageSubject.value.routeName;

  /// 紀錄當前頁面
  final BehaviorSubject<RouteData> _subPageSubject =
      BehaviorSubject.seeded(RouteData(''));

  Stream<RouteData> get subPageStream => _subPageSubject.stream;

  String currentCity = '';

  void addSubPageRoute(RouteData routeData) {
    _subPageSubject.add(routeData);
  }

  void popSubPage() {
    if (_subPageHistory.length > 1) {
      _subPageHistory.removeLast();
    }

    if (!_subPageHistory.last.addHistory) {
      _subPageHistory.removeLast();
    }

    _subPageSubject.add(_subPageHistory.last);
  }

  void getNeededApi() {
    getLocate().then((_) {
      print(currentCity);
    });
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getLocate() async{
    await determinePosition().then((value) {
       currentCity = getCurrentCity(value.latitude, value.longitude);
    });
  }

  String getCurrentCity(double currentLat, double currentLon) {
      var p = 0.017453292519943295;
      var c = cos;
      var cityIndex = 0;
      var minDistance = double.maxFinite;

      locates.asMap().forEach((index, locate) {
        var lat = double.parse(locate.lat);
        var lon = double.parse(locate.lon);

        var a = 0.5 -
            c((lat - currentLat) * p) / 2 +
            c(currentLat * p) *
                c(lat * p) *
                (1 - c((lon - currentLon) * p)) /
                2;
        var distance = 12742 * asin(sqrt(a));
        if (distance < minDistance) {
          minDistance = distance;
          cityIndex = index;
        }
      });
      return cities[cityIndex];
  }

  /// 關閉
  void dispose() {
    _subPageSubject.close();
  }
}
