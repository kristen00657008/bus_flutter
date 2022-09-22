import 'package:json_annotation/json_annotation.dart';

part 'route_bean.g.dart';

@JsonSerializable()
class RouteBean {
  @JsonKey(name: 'RouteUID', defaultValue: "")
  String routeUID;

  @JsonKey(name: 'RouteID', defaultValue: "")
  String routeID;

  @JsonKey(name: 'HasSubRoutes', defaultValue: false)
  bool hasSubRoutes;

  @JsonKey(name: 'Operators', defaultValue: [])
  List<OperatorBean> operators;

  @JsonKey(name: 'AuthorityID', defaultValue: "")
  String authorityID;

  @JsonKey(name: 'ProviderID', defaultValue: "")
  String providerID;

  @JsonKey(name: 'SubRoutes', defaultValue: [])
  List<SubRouteBean> subRoutes;

  @JsonKey(name: 'BusRouteType', defaultValue: 0)
  int busRouteType;

  @JsonKey(name: 'RouteName', defaultValue: null)
  RouteNameBean routeName;

  @JsonKey(name: 'DepartureStopNameZh', defaultValue: "")
  String departureStopNameZh;

  @JsonKey(name: 'DepartureStopNameEn', defaultValue: "")
  String departureStopNameEn;

  @JsonKey(name: 'DestinationStopNameZh', defaultValue: "")
  String destinationStopNameZh;

  @JsonKey(name: 'DestinationStopNameEn', defaultValue: "")
  String destinationStopNameEn;

  @JsonKey(name: 'RouteMapImageUrl', defaultValue: "")
  String routeMapImageUrl;

  @JsonKey(name: 'City', defaultValue: "")
  String city;

  @JsonKey(name: 'CityCode', defaultValue: "")
  String cityCode;

  @JsonKey(name: 'UpdateTime', defaultValue: "")
  String updateTime;

  @JsonKey(name: 'VersionID', defaultValue: "")
  String versionID;

  RouteBean({
    required this.routeUID,
    required this.routeID,
    required this.hasSubRoutes,
    required this.operators,
    required this.authorityID,
    required this.providerID,
    required this.subRoutes,
    required this.busRouteType,
    required this.routeName,
    required this.departureStopNameZh,
    required this.departureStopNameEn,
    required this.destinationStopNameZh,
    required this.destinationStopNameEn,
    required this.routeMapImageUrl,
    required this.city,
    required this.cityCode,
    required this.updateTime,
    required this.versionID,
  });

  factory RouteBean.fromJson(Map<String, dynamic> json) =>
      _$RouteBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RouteBeanToJson(this);
}

@JsonSerializable()
class OperatorBean {
  @JsonKey(name: 'OperatorID', defaultValue: "")
  String operatorID;

  @JsonKey(name: 'OperatorName', defaultValue: null)
  OperatorNameBean operatorName;

  @JsonKey(name: 'OperatorCode', defaultValue: "")
  String operatorCode;

  @JsonKey(name: 'OperatorNo', defaultValue: "")
  String operatorNo;

  OperatorBean({
    required this.operatorID,
    required this.operatorName,
    required this.operatorCode,
    required this.operatorNo,
  });

  factory OperatorBean.fromJson(Map<String, dynamic> json) =>
      _$OperatorBeanFromJson(json);

  Map<String, dynamic> toJson() => _$OperatorBeanToJson(this);
}

@JsonSerializable()
class OperatorNameBean {
  @JsonKey(name: 'Zh_tw', defaultValue: "")
  String tw;

  OperatorNameBean({
    required this.tw,
  });

  factory OperatorNameBean.fromJson(Map<String, dynamic> json) =>
      _$OperatorNameBeanFromJson(json);

  Map<String, dynamic> toJson() => _$OperatorNameBeanToJson(this);
}

@JsonSerializable()
class SubRouteBean {
  @JsonKey(name: 'SubRouteUID', defaultValue: "")
  String subRouteUID;

  @JsonKey(name: 'SubRouteID', defaultValue: "")
  String subRouteID;

  @JsonKey(name: 'OperatorIDs', defaultValue: [])
  List<int> operatorIDs;

  @JsonKey(name: 'SubRouteName', defaultValue: null)
  SubRouteNameBean subRouteName;

  @JsonKey(name: 'Headsign', defaultValue: "")
  String headSign;

  @JsonKey(name: 'HeadsignEn', defaultValue: "")
  String headSignEn;

  @JsonKey(name: 'Direction', defaultValue: 0)
  int direction;

  SubRouteBean({
    required this.subRouteUID,
    required this.subRouteID,
    required this.operatorIDs,
    required this.subRouteName,
    required this.headSign,
    required this.headSignEn,
    required this.direction,
  });

  factory SubRouteBean.fromJson(Map<String, dynamic> json) =>
      _$SubRouteBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SubRouteBeanToJson(this);
}

@JsonSerializable()
class SubRouteNameBean {
  @JsonKey(name: 'Zh_tw', defaultValue: "")
  String tw;

  @JsonKey(name: 'En', defaultValue: "")
  String en;

  SubRouteNameBean({
    required this.tw,
    required this.en,
  });

  factory SubRouteNameBean.fromJson(Map<String, dynamic> json) =>
      _$SubRouteNameBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SubRouteNameBeanToJson(this);
}

@JsonSerializable()
class RouteNameBean {
  @JsonKey(name: 'Zh_tw', defaultValue: "")
  String tw;

  @JsonKey(name: 'En', defaultValue: "")
  String en;

  RouteNameBean({
    required this.tw,
    required this.en,
  });

  factory RouteNameBean.fromJson(Map<String, dynamic> json) =>
      _$RouteNameBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RouteNameBeanToJson(this);
}
