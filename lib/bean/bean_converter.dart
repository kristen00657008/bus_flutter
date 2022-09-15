import 'dart:convert';

import 'package:bus/bean/weather/weather_bean.dart';


/// 轉換Bean
/// flutter pub run build_runner build --delete-conflicting-outputs
class BeanConverter {
  /// 轉化 [jsonString] 為 Bean
  /// <p>[onError] - 當轉化出現錯誤時呼叫</p>
  /// <p>[onError] 的 Function 參數可帶入以下兩種</p>
  /// - Function(dyanmic, Stacktrace) => 第一個參數為發生的錯誤, 第二個參數為 StackTrace
  /// - Function(dyanmic)
  static T convert<T>(
      String jsonString, {
        Function? onError,
      }) {
    return _convert<T>(
      jsonString,
      onError: onError,
    );
  }

  static T _convert<T>(
      String jsonString, {
        Function? onError,
      }) {
    late Map<String, dynamic> jsonConvert;
    try {
      jsonConvert = jsonDecode(jsonString);
    } catch (error, stack) {
      print("BeanConverter 錯誤[json解析] - $jsonString");
      print("BeanConverter 錯誤[json解析] - $error");
      print("BeanConverter 錯誤[json解析] - $stack");
      handleError(onError, error, stack);
    }

    T? bean;

    /// 首先反序列化
    try {
      Function(Map<String, dynamic> jsonData)? convertFunc = _factories[T];
      if (convertFunc != null) {
        bean = convertFunc(jsonConvert);
      }
    } catch (error, stack) {
      print("BeanConverter 錯誤[反序列化 - $T] - $jsonString");
      print("BeanConverter 錯誤[反序列化 - $T] - $error");
      print("BeanConverter 錯誤[反序列化 - $T] - $stack");
      handleError(onError, error, stack);
    }

    /// 檢查反序列化後的結果, 若為 null 必定為尚未實現對應類別, 因為是使用 factory 初始化
    if (bean == null) {
      print("BeanConverter 錯誤[null] - auto bean 尚未實現對應類別 ${StackTrace.current}");
      handleError(onError, NullThrownError(), StackTrace.current);
    }

    return bean!;
  }

  /// 發生錯誤之後跳入此處進行處理
  static void handleError(Function? onError, dynamic error, StackTrace stackTrace) {
    if (onError == null) {
      print("BeanConverter 錯誤: $error");
      throw error;
    } else {
      if (onError is Function(dynamic)) {
        onError(error);
      } else if (onError is Function(dynamic, StackTrace)) {
        onError(error, stackTrace);
      } else {
        print("onError 格式錯誤: ${onError.runtimeType}, 須得是: Function(dyanmic, Stacktrace) 或 Function(dyanmic)");
        throw error;
      }
    }
  }

  BeanConverter._();
}

final _factories = <Type, Function(Map<String, dynamic> jsonData)?>{
  WeatherBean: (jsonData) => WeatherBean.fromJson(jsonData),
};
