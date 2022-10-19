// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class BusRequestService {
  final baseUrl = "https://ptx.transportdata.tw/MOTC/v2/Bus/";
  final String appId = "e329c82e8e4d4570a965c94793f43cc3";
  final String appKey = "Z8FNUWcoYOIldYjv7P8ELjNrPLQ";
  final Dio _dio = Dio();

  Dio get dio => _dio;

  String getAuthorization(String xDate) {
    String time = getTimeString();
    final signDate = "x-date: $time";
    var key = utf8.encode(appKey);
    var hmacSha1 = Hmac(sha1, key);
    var hmac = hmacSha1.convert(utf8.encode(signDate));
    var base64HmacString = base64Encode(hmac.bytes);
    var authorization =
        """hmac username="$appId", algorithm="hmac-sha1", headers="x-date", signature="$base64HmacString\"""";
    return authorization;
  }

  String getTimeString() {
    return DateFormat("EEE, dd MMM yyyy HH:mm:ss")
            .format(DateTime.now().toUtc()) +
        " GMT";
  }

  void addHeader() {
    String xDate = getTimeString();
    dio.options.headers["Authorization"] = getAuthorization(xDate);
    dio.options.headers["x-date"] = xDate;
    dio.options.headers["Accept-Encoding"] = 'gzip';
  }

  Stream<Response> getRoute(String routeName, String city) {
    addHeader();
    print(Category.Route.toString());
    city = "/City/$city/";
    return dio
        .get(baseUrl + Category.Route.name + city + routeName + "?%24format=JSON")
        .asStream();
  }

  Stream<Response> getStopOfRoute(String routeName, String city) {
    addHeader();
    city = "/City/$city/";
    print(baseUrl + Category.StopOfRoute.name + city + routeName + "?%24format=JSON");
    return dio
        .get(baseUrl + Category.StopOfRoute.name + city + routeName + "?%24format=JSON")
        .asStream();
  }

  Stream<Response> getEstimatedTimeOfArrival(String routeName, String city) {
    addHeader();
    city = "/City/$city/";
    print(baseUrl + Category.EstimatedTimeOfArrival.name + city + routeName + "?%24format=JSON");
    return dio
        .get(baseUrl + Category.EstimatedTimeOfArrival.name + city + routeName + "?%24format=JSON")
        .asStream();
  }
}
enum Category{
  Route,
  StopOfRoute,
  EstimatedTimeOfArrival,
}
