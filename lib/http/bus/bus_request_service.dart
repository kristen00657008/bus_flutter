import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class BusRequestService {
  final baseUrl = "https://ptx.transportdata.tw/MOTC/v2/Bus/";
  final String appId = "e329c82e8e4d4570a965c94793f43cc3";
  final String appKey = "Z8FNUWcoYOIldYjv7P8ELjNrPLQ";
  final category = "Route/";

  // Future<Response> getAccessToken() async {
  //   String xDate = getTimeString();
  //   Dio dio = Dio();
  //   var formData = FormData.fromMap({
  //     'Authorization': getAuthorization(xDate),
  //     'x-date': xDate,
  //   });
  //   dio.options.baseUrl =
  //   'https://tdx.transportdata.tw/auth/realms/TDXConnect/protocol/openid-connect/token';
  //   return await dio.post('/info',
  //       data: formData,
  //       options: Options(
  //         contentType: 'application/x-www-form-urlencoded',
  //         // headers: {
  //         //   'content-type': 'application/x-www-form-urlencoded'
  //         // }
  //       ));
  // }

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

  Stream<Response> getBusRoute(String routeName, String city) {
    Dio dio = Dio();
    String xDate = getTimeString();
    dio.options.headers["Authorization"] = getAuthorization(xDate);
    dio.options.headers["x-date"] = xDate;
    dio.options.headers["Accept-Encoding"] = 'gzip';

    city = "City/" + city + "/";
    return dio
        .get(baseUrl + category + city + routeName + "?%24format=JSON")
        .asStream();
  }
}
