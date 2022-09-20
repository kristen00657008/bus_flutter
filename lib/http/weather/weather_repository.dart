// ignore_for_file: constant_identifier_names

import 'package:bus/bean/weather/weather_bean.dart';
import 'package:bus/http/weather/weather_request_service.dart';

class WeatherRepository {
  static final _singleton = WeatherRepository._internal();

  WeatherRepository._internal();

  static WeatherRepository getInstance() => _singleton;

  factory WeatherRepository() => _singleton;

  final WeatherRequestService _weatherRequestService = WeatherRequestService();

  Stream<WeatherBean> getWeather(String city) {
    return _weatherRequestService.getWeather(city).map((response) {
      return WeatherBean.fromJson(Map<String, dynamic>.from(response.data));
    });
  }
}

extension WeatherBeanExtension on WeatherBean {
  String get success => this.success;

  String get datasetDescription => records.locations.first.datasetDescription;

  String get locationsName => records.locations.first.locationsName;

  String get locationName =>
      records.locations.first.location.first.locationName;

  String get lat => records.locations.first.location.first.lat;

  String get lon => records.locations.first.location.first.lon;

  List<WeatherElement> get weatherElementList =>
      records.locations.first.location.first.weatherElement;
}

extension WeatherElementListExtension on List<WeatherElement> {
  WeatherElement getElement(String key) {
    late WeatherElement result;
    for (var element in this) {
      if (element.elementName == key) {
        result = element;
      }
    }
    return result;
  }
}

extension WeatherElemenExtension on WeatherElement {
  String get elementName => this.elementName;

  String get description => this.description;

  String getValue(int timeZone) {
    return time[timeZone].elementValue.first.value;
  }
}

class ElementName {
  /// 天氣現象
  static const Wx = "Wx";

  /// 12小時降雨機
  static const PoP12h = "PoP12h";

  /// 體感溫度
  static const AT = "AT";

  /// 溫度
  static const T = "T";

  /// 相對濕度
  static const RH = "RH";

  /// 舒適度指數
  static const CI = "CI";

  /// 天氣預報綜合描述
  static const WeatherDescription = "WeatherDescription";

  /// 6小時降雨機率
  static const PoP6h = "PoP6h";

  /// 風速
  static const WS = "WS";

  /// 風向
  static const WD = "WD";

  /// 露點溫度
  static const Td = "Td";
}
