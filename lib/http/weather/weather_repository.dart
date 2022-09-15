import 'package:bus/bean/weather/weather_bean.dart';
import 'package:bus/http/weather/weather_request_service.dart';

class WeatherRepository {
  static final _singleton = WeatherRepository._internal();

  WeatherRepository._internal();

  static WeatherRepository getInstance() => _singleton;

  factory WeatherRepository() => _singleton;

  final WeatherRequestService _weatherRequestService = WeatherRequestService();

  Stream<WeatherBean> getWeather() {
    return _weatherRequestService
        .getWeather()
        // .replaceBracket()
        .map((response) {
          return WeatherBean.fromJson(Map<String, dynamic>.from(response.data));
        });
  }


}
