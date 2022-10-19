// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimatedTimeOfArrival_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstimatedTimeOfArrivalBean _$EstimatedTimeOfArrivalBeanFromJson(
        Map<String, dynamic> json) =>
    EstimatedTimeOfArrivalBean(
      plateNumb: json['PlateNumb'] as String? ?? '',
      stopUID: json['StopUID'] as String? ?? '',
      stopID: json['StopID'] as String? ?? '',
      stopName:
          RouteNameBean.fromJson(json['StopName'] as Map<String, dynamic>),
      routeUID: json['RouteUID'] as String? ?? '',
      routeID: json['RouteID'] as String? ?? '',
      routeName:
          RouteNameBean.fromJson(json['RouteName'] as Map<String, dynamic>),
      subRouteUID: json['SubRouteUID'] as String? ?? '',
      subRouteID: json['SubRouteID'] as String? ?? '',
      subRouteName:
          RouteNameBean.fromJson(json['SubRouteName'] as Map<String, dynamic>),
      direction: json['Direction'] as int? ?? 0,
      estimateTime: json['EstimateTime'] as int? ?? 0,
      stopSequence: json['StopSequence'] as int? ?? 0,
      stopStatus: json['StopStatus'] as int? ?? 0,
      nextBusTime: json['NextBusTime'] as String? ?? '',
      estimates: (json['Estimates'] as List<dynamic>?)
              ?.map((e) => EstimateBean.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      srcUpdateTime: json['SrcUpdateTime'] as String? ?? '',
      updateTime: json['UpdateTime'] as String? ?? '',
    );

Map<String, dynamic> _$EstimatedTimeOfArrivalBeanToJson(
        EstimatedTimeOfArrivalBean instance) =>
    <String, dynamic>{
      'PlateNumb': instance.plateNumb,
      'StopUID': instance.stopUID,
      'StopID': instance.stopID,
      'StopName': instance.stopName,
      'RouteUID': instance.routeUID,
      'RouteID': instance.routeID,
      'RouteName': instance.routeName,
      'SubRouteUID': instance.subRouteUID,
      'SubRouteID': instance.subRouteID,
      'SubRouteName': instance.subRouteName,
      'Direction': instance.direction,
      'EstimateTime': instance.estimateTime,
      'StopSequence': instance.stopSequence,
      'StopStatus': instance.stopStatus,
      'NextBusTime': instance.nextBusTime,
      'Estimates': instance.estimates,
      'SrcUpdateTime': instance.srcUpdateTime,
      'UpdateTime': instance.updateTime,
    };

EstimateBean _$EstimateBeanFromJson(Map<String, dynamic> json) => EstimateBean(
      plateNumb: json['PlateNumb'] as String? ?? '',
      estimateTime: json['EstimateTime'] as int? ?? 0,
      isLastBus: json['IsLastBus'] as bool? ?? false,
    );

Map<String, dynamic> _$EstimateBeanToJson(EstimateBean instance) =>
    <String, dynamic>{
      'PlateNumb': instance.plateNumb,
      'EstimateTime': instance.estimateTime,
      'IsLastBus': instance.isLastBus,
    };
