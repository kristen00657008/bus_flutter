import 'package:dio/dio.dart';

class WeatherRequestService {
  final baseUrl = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/";
  final resourceId = "F-D0047-091?";
  final authorization =
      "Authorization=CWB-38A5972D-6400-4127-9A58-852965CBAC44";

  Stream<Response> getWeather(String city) {
    String encodedCity = Uri.encodeComponent(city);
    return Dio()
        .get(
            baseUrl + resourceId + authorization + '&locationName=$encodedCity')
        .asStream();
  }
}
