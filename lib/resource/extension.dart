import 'dart:convert';

import 'package:bus/bean/weather/weather_bean.dart';
import 'package:bus/http/weather/weather_repository.dart';
import 'package:dio/dio.dart';

/// 發現有部分API回傳是包含在JsonArray內一層，調用此方法刪除[]
extension StreamBracket on Stream<Response> {
  Stream<Response> replaceBracket() => map((response) {
        try {
          var a = (jsonDecode(response.data) as List).toList();
          String responseJson = response.data;
          if (a.length == 1) {
            responseJson = responseJson.replaceFirst("[", "");
            responseJson =
                responseJson.replaceFirst("]", "", responseJson.length - 1);
            response.data = responseJson;
          }
        } catch (e) {
          print("error");
        }

        return response;
      });
}

extension StringExtension on String {
  String toTime() {
    String time = replaceFirst("+08:00", "")..replaceFirst("T", " ");
    DateTime dateTime = DateTime.parse(time);
    return dateTime.minute < 10
        ? dateTime.hour.toString() + ":0" + dateTime.minute.toString()
        : dateTime.hour.toString() + ":" + dateTime.minute.toString();
  }

  int timeToSecond() {
    String time = replaceFirst("+08:00", "")..replaceFirst("T", " ");
    DateTime dateTime = DateTime.parse(time);
    return dateTime.difference(DateTime.now()).inSeconds;
  }
}

extension IntegerExtension on int {
  int toMinute() {
    return this ~/ 60;
  }
}

extension WeatherBeanExtension on WeatherBean {
  String get T => weatherElementList[1].time[0].elementValue.first.value;

  String get minT => weatherElementList[8].time[0].elementValue.first.value;

  String get maxT => weatherElementList[12].time[0].elementValue.first.value;

  String get wX => weatherElementList[6].time[0].elementValue.first.value;

  String get minCT => weatherElementList[3].time[0].elementValue.last.value;

  String get maxCT => weatherElementList[7].time[0].elementValue.last.value;

  String get cT => minCT + "至" + maxCT;

  String get pop12h => weatherElementList[0].time[0].elementValue.last.value;
}
