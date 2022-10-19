import 'dart:convert';

import 'package:dio/dio.dart';

/// 發現有部分API回傳是包含在JsonArray內一層，調用此方法刪除[]
extension StreamBracket on Stream<Response> {
  Stream<Response> replaceBracket() => map((response) {
        try {
          var a = (jsonDecode(response.data) as List).toList();
          String responseJson = response.data;
          if (a.length == 1) {
            print("a.length == 1");
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
    return dateTime.hour.toString() + ":" + dateTime.minute.toString();
  }
}

extension IntegerExtension on int {

  String toMinute() {
    double minute = this / 60;
    return minute.toInt().toString() + "分";
  }
}
