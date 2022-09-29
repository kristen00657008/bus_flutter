import 'package:bus/bean/bus/route_bean/route_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stop_of_route_bean.g.dart';

@JsonSerializable()
class StopOfRouteBean {
  @JsonKey(name: 'RouteUID', defaultValue: "")
  String routeUID;

  @JsonKey(name: 'RouteID', defaultValue: "")
  String routeID;

  @JsonKey(name: 'RouteName', defaultValue: null)
  RouteNameBean routeName;

  @JsonKey(name: 'Operators', defaultValue: [])
  List<OperatorBean> operators;

  @JsonKey(name: 'SubRouteUID', defaultValue: "")
  String subRouteUID;

  @JsonKey(name: 'SubRouteID', defaultValue: "")
  String subRouteID;

  @JsonKey(name: 'SubRouteName', defaultValue: null)
  RouteNameBean subRouteName;

  @JsonKey(name: 'Direction', defaultValue: 0)
  int direction;

  @JsonKey(name: 'City', defaultValue: "")
  String city;

  @JsonKey(name: 'CityCode', defaultValue: "")
  String cityCode;

  @JsonKey(name: 'Stops', defaultValue: null)
  List<StopBean> stops;

  @JsonKey(name: 'UpdateTime', defaultValue: "")
  String updateTime;

  @JsonKey(name: 'VersionID', defaultValue: 0)
  int versionID;

  StopOfRouteBean({
    required this.routeUID,
    required this.routeID,
    required this.routeName,
    required this.operators,
    required this.subRouteUID,
    required this.subRouteID,
    required this.subRouteName,
    required this.direction,
    required this.city,
    required this.cityCode,
    required this.stops,
    required this.updateTime,
    required this.versionID,
  });

  factory StopOfRouteBean.fromJson(Map<String, dynamic> json) =>
      _$StopOfRouteBeanFromJson(json);

  Map<String, dynamic> toJson() => _$StopOfRouteBeanToJson(this);
}

@JsonSerializable()
class StopBean {
  @JsonKey(name: 'StopUID', defaultValue: "")
  String stopUID;

  @JsonKey(name: 'StopID', defaultValue: "")
  String stopID;

  @JsonKey(name: 'StopName', defaultValue: null)
  RouteNameBean stopName;

  @JsonKey(name: 'StopBoarding', defaultValue: 0)
  int stopBoarding;

  @JsonKey(name: 'StopSequence', defaultValue: 1)
  int stopSequence;

  @JsonKey(name: 'StopPosition', defaultValue: null)
  PositionBean stopPosition;

  @JsonKey(name: 'StationID', defaultValue: "")
  String stationID;

  @JsonKey(name: 'StationGroupID', defaultValue: "")
  String stationGroupID;

  @JsonKey(name: 'LocationCityCode', defaultValue: "")
  String locationCityCode;

  StopBean({
    required this.stopUID,
    required this.stopID,
    required this.stopName,
    required this.stopBoarding,
    required this.stopSequence,
    required this.stopPosition,
    required this.stationID,
    required this.stationGroupID,
    required this.locationCityCode,
  });

  factory StopBean.fromJson(Map<String, dynamic> json) =>
      _$StopBeanFromJson(json);

  Map<String, dynamic> toJson() => _$StopBeanToJson(this);
}

@JsonSerializable()
class PositionBean {
  @JsonKey(name: 'PositionLon', defaultValue: 0.0)
  double positionLon;

  @JsonKey(name: 'PositionLat', defaultValue: 0.0)
  double positionLat;

  @JsonKey(name: 'GeoHash', defaultValue: "")
  String geoHash;

  PositionBean({
    required this.positionLon,
    required this.positionLat,
    required this.geoHash,
  });

  factory PositionBean.fromJson(Map<String, dynamic> json) =>
      _$PositionBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PositionBeanToJson(this);
}
