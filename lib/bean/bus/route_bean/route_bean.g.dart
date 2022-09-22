// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteBean _$RouteBeanFromJson(Map<String, dynamic> json) => RouteBean(
      routeUID: json['RouteUID'] as String? ?? '',
      routeID: json['RouteID'] as String? ?? '',
      hasSubRoutes: json['HasSubRoutes'] as bool? ?? false,
      operators: (json['Operators'] as List<dynamic>?)
              ?.map((e) => OperatorBean.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      authorityID: json['AuthorityID'] as String? ?? '',
      providerID: json['ProviderID'] as String? ?? '',
      subRoutes: (json['SubRoutes'] as List<dynamic>?)
              ?.map((e) => SubRouteBean.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      busRouteType: json['BusRouteType'] as int? ?? 0,
      routeName:
          RouteNameBean.fromJson(json['RouteName'] as Map<String, dynamic>),
      departureStopNameZh: json['DepartureStopNameZh'] as String? ?? '',
      departureStopNameEn: json['DepartureStopNameEn'] as String? ?? '',
      destinationStopNameZh: json['DestinationStopNameZh'] as String? ?? '',
      destinationStopNameEn: json['DestinationStopNameEn'] as String? ?? '',
      routeMapImageUrl: json['RouteMapImageUrl'] as String? ?? '',
      city: json['City'] as String? ?? '',
      cityCode: json['CityCode'] as String? ?? '',
      updateTime: json['UpdateTime'] as String? ?? '',
      versionID: json['VersionID'] as String? ?? '',
    );

Map<String, dynamic> _$RouteBeanToJson(RouteBean instance) => <String, dynamic>{
      'RouteUID': instance.routeUID,
      'RouteID': instance.routeID,
      'HasSubRoutes': instance.hasSubRoutes,
      'Operators': instance.operators,
      'AuthorityID': instance.authorityID,
      'ProviderID': instance.providerID,
      'SubRoutes': instance.subRoutes,
      'BusRouteType': instance.busRouteType,
      'RouteName': instance.routeName,
      'DepartureStopNameZh': instance.departureStopNameZh,
      'DepartureStopNameEn': instance.departureStopNameEn,
      'DestinationStopNameZh': instance.destinationStopNameZh,
      'DestinationStopNameEn': instance.destinationStopNameEn,
      'RouteMapImageUrl': instance.routeMapImageUrl,
      'City': instance.city,
      'CityCode': instance.cityCode,
      'UpdateTime': instance.updateTime,
      'VersionID': instance.versionID,
    };

OperatorBean _$OperatorBeanFromJson(Map<String, dynamic> json) => OperatorBean(
      operatorID: json['OperatorID'] as String? ?? '',
      operatorName: OperatorNameBean.fromJson(
          json['OperatorName'] as Map<String, dynamic>),
      operatorCode: json['OperatorCode'] as String? ?? '',
      operatorNo: json['OperatorNo'] as String? ?? '',
    );

Map<String, dynamic> _$OperatorBeanToJson(OperatorBean instance) =>
    <String, dynamic>{
      'OperatorID': instance.operatorID,
      'OperatorName': instance.operatorName,
      'OperatorCode': instance.operatorCode,
      'OperatorNo': instance.operatorNo,
    };

OperatorNameBean _$OperatorNameBeanFromJson(Map<String, dynamic> json) =>
    OperatorNameBean(
      tw: json['Zh_tw'] as String? ?? '',
    );

Map<String, dynamic> _$OperatorNameBeanToJson(OperatorNameBean instance) =>
    <String, dynamic>{
      'Zh_tw': instance.tw,
    };

SubRouteBean _$SubRouteBeanFromJson(Map<String, dynamic> json) => SubRouteBean(
      subRouteUID: json['SubRouteUID'] as String? ?? '',
      subRouteID: json['SubRouteID'] as String? ?? '',
      operatorIDs: (json['OperatorIDs'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      subRouteName: SubRouteNameBean.fromJson(
          json['SubRouteName'] as Map<String, dynamic>),
      headSign: json['Headsign'] as String? ?? '',
      headSignEn: json['HeadsignEn'] as String? ?? '',
      direction: json['Direction'] as int? ?? 0,
    );

Map<String, dynamic> _$SubRouteBeanToJson(SubRouteBean instance) =>
    <String, dynamic>{
      'SubRouteUID': instance.subRouteUID,
      'SubRouteID': instance.subRouteID,
      'OperatorIDs': instance.operatorIDs,
      'SubRouteName': instance.subRouteName,
      'Headsign': instance.headSign,
      'HeadsignEn': instance.headSignEn,
      'Direction': instance.direction,
    };

SubRouteNameBean _$SubRouteNameBeanFromJson(Map<String, dynamic> json) =>
    SubRouteNameBean(
      tw: json['Zh_tw'] as String? ?? '',
      en: json['En'] as String? ?? '',
    );

Map<String, dynamic> _$SubRouteNameBeanToJson(SubRouteNameBean instance) =>
    <String, dynamic>{
      'Zh_tw': instance.tw,
      'En': instance.en,
    };

RouteNameBean _$RouteNameBeanFromJson(Map<String, dynamic> json) =>
    RouteNameBean(
      tw: json['Zh_tw'] as String? ?? '',
      en: json['En'] as String? ?? '',
    );

Map<String, dynamic> _$RouteNameBeanToJson(RouteNameBean instance) =>
    <String, dynamic>{
      'Zh_tw': instance.tw,
      'En': instance.en,
    };
