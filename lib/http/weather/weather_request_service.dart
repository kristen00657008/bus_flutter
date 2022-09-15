import 'package:dio/dio.dart';

class WeatherRequestService {

  Stream<Response> getWeather() {
    return Dio()
        .get(
            'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-089?Authorization=CWB-38A5972D-6400-4127-9A58-852965CBAC44')
        .asStream();
  }
}
