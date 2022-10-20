import 'package:bus/bean/bus/route_bean/route_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'estimatedTimeOfArrival_bean.g.dart';

@JsonSerializable()
class EstimatedTimeOfArrivalBean {
  @JsonKey(name: 'PlateNumb', defaultValue: "")
  String plateNumb;

  @JsonKey(name: 'StopUID', defaultValue: "")
  String stopUID;

  @JsonKey(name: 'StopID', defaultValue: '')
  String stopID;

  @JsonKey(name: 'StopName')
  RouteNameBean stopName;

  @JsonKey(name: 'RouteUID', defaultValue: "")
  String routeUID;

  @JsonKey(name: 'RouteID', defaultValue: "")
  String routeID;

  @JsonKey(name: 'RouteName')
  RouteNameBean routeName;

  @JsonKey(name: 'SubRouteUID', defaultValue: '')
  String subRouteUID;

  @JsonKey(name: 'SubRouteID', defaultValue: '')
  String subRouteID;

  @JsonKey(name: 'SubRouteName')
  RouteNameBean subRouteName;

  @JsonKey(name: 'Direction', defaultValue: 0)
  int direction;

  @JsonKey(name: 'EstimateTime', defaultValue: null)
  int? estimateTime;

  @JsonKey(name: 'StopSequence', defaultValue: 0)
  int stopSequence;

  @JsonKey(name: 'StopStatus', defaultValue: 0)
  int stopStatus;

  @JsonKey(name: 'NextBusTime', defaultValue: null)
  String? nextBusTime;

  @JsonKey(name: 'Estimates', defaultValue: [])
  List<EstimateBean> estimates;

  @JsonKey(name: 'SrcUpdateTime', defaultValue: '')
  String srcUpdateTime;

  @JsonKey(name: 'UpdateTime', defaultValue: '')
  String updateTime;

  EstimatedTimeOfArrivalBean({
    required this.plateNumb,
    required this.stopUID,
    required this.stopID,
    required this.stopName,
    required this.routeUID,
    required this.routeID,
    required this.routeName,
    required this.subRouteUID,
    required this.subRouteID,
    required this.subRouteName,
    required this.direction,
    required this.estimateTime,
    required this.stopSequence,
    required this.stopStatus,
    required this.nextBusTime,
    required this.estimates,
    required this.srcUpdateTime,
    required this.updateTime,
  });

  factory EstimatedTimeOfArrivalBean.fromJson(Map<String, dynamic> json) =>
      _$EstimatedTimeOfArrivalBeanFromJson(json);

  Map<String, dynamic> toJson() => _$EstimatedTimeOfArrivalBeanToJson(this);
}

@JsonSerializable()
class EstimateBean {
  @JsonKey(name: 'PlateNumb', defaultValue: "")
  String plateNumb;

  @JsonKey(name: 'EstimateTime', defaultValue: 0)
  int estimateTime;

  @JsonKey(name: 'IsLastBus', defaultValue: false)
  bool isLastBus;

  EstimateBean({
    required this.plateNumb,
    required this.estimateTime,
    required this.isLastBus,
  });

  factory EstimateBean.fromJson(Map<String, dynamic> json) =>
      _$EstimateBeanFromJson(json);

  Map<String, dynamic> toJson() => _$EstimateBeanToJson(this);
}
