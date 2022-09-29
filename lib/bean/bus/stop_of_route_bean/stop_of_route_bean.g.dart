// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_of_route_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StopOfRouteBean _$StopOfRouteBeanFromJson(Map<String, dynamic> json) =>
    StopOfRouteBean(
      routeUID: json['RouteUID'] as String? ?? '',
      routeID: json['RouteID'] as String? ?? '',
      routeName:
          RouteNameBean.fromJson(json['RouteName'] as Map<String, dynamic>),
      operators: (json['Operators'] as List<dynamic>?)
              ?.map((e) => OperatorBean.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      subRouteUID: json['SubRouteUID'] as String? ?? '',
      subRouteID: json['SubRouteID'] as String? ?? '',
      subRouteName:
          RouteNameBean.fromJson(json['SubRouteName'] as Map<String, dynamic>),
      direction: json['Direction'] as int? ?? 0,
      city: json['City'] as String? ?? '',
      cityCode: json['CityCode'] as String? ?? '',
      stops: (json['Stops'] as List<dynamic>)
          .map((e) => StopBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      updateTime: json['UpdateTime'] as String? ?? '',
      versionID: json['VersionID'] as int? ?? 0,
    );

Map<String, dynamic> _$StopOfRouteBeanToJson(StopOfRouteBean instance) =>
    <String, dynamic>{
      'RouteUID': instance.routeUID,
      'RouteID': instance.routeID,
      'RouteName': instance.routeName,
      'Operators': instance.operators,
      'SubRouteUID': instance.subRouteUID,
      'SubRouteID': instance.subRouteID,
      'SubRouteName': instance.subRouteName,
      'Direction': instance.direction,
      'City': instance.city,
      'CityCode': instance.cityCode,
      'Stops': instance.stops,
      'UpdateTime': instance.updateTime,
      'VersionID': instance.versionID,
    };

StopBean _$StopBeanFromJson(Map<String, dynamic> json) => StopBean(
      stopUID: json['StopUID'] as String? ?? '',
      stopID: json['StopID'] as String? ?? '',
      stopName:
          RouteNameBean.fromJson(json['StopName'] as Map<String, dynamic>),
      stopBoarding: json['StopBoarding'] as int? ?? 0,
      stopSequence: json['StopSequence'] as int? ?? 1,
      stopPosition:
          PositionBean.fromJson(json['StopPosition'] as Map<String, dynamic>),
      stationID: json['StationID'] as String? ?? '',
      stationGroupID: json['StationGroupID'] as String? ?? '',
      locationCityCode: json['LocationCityCode'] as String? ?? '',
    );

Map<String, dynamic> _$StopBeanToJson(StopBean instance) => <String, dynamic>{
      'StopUID': instance.stopUID,
      'StopID': instance.stopID,
      'StopName': instance.stopName,
      'StopBoarding': instance.stopBoarding,
      'StopSequence': instance.stopSequence,
      'StopPosition': instance.stopPosition,
      'StationID': instance.stationID,
      'StationGroupID': instance.stationGroupID,
      'LocationCityCode': instance.locationCityCode,
    };

PositionBean _$PositionBeanFromJson(Map<String, dynamic> json) => PositionBean(
      positionLon: (json['PositionLon'] as num?)?.toDouble() ?? 0.0,
      positionLat: (json['PositionLat'] as num?)?.toDouble() ?? 0.0,
      geoHash: json['GeoHash'] as String? ?? '',
    );

Map<String, dynamic> _$PositionBeanToJson(PositionBean instance) =>
    <String, dynamic>{
      'PositionLon': instance.positionLon,
      'PositionLat': instance.positionLat,
      'GeoHash': instance.geoHash,
    };
