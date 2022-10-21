import 'package:json_annotation/json_annotation.dart';

part 'weather_bean.g.dart';

@JsonSerializable()
class WeatherBean {
  @JsonKey(name: 'success', defaultValue: "")
  String success;

  @JsonKey(name: 'result', defaultValue: null)
  Result result;

  @JsonKey(name: 'records', defaultValue: null)
  Record records;

  WeatherBean({
    required this.success,
    required this.result,
    required this.records,
  });

  factory WeatherBean.fromJson(Map<String, dynamic> json) =>
      _$WeatherBeanFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherBeanToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: 'resource_id', defaultValue: "")
  String resourceId;

  @JsonKey(name: 'fields', defaultValue: [])
  List<Field> fields;

  Result({
    required this.resourceId,
    required this.fields,
  });

  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Field {
  @JsonKey(name: 'id', defaultValue: "")
  String id;

  @JsonKey(name: 'type', defaultValue: "")
  String type;

  Field({
    required this.id,
    required this.type,
  });

  factory Field.fromJson(Map<String, dynamic> json) =>
      _$FieldFromJson(json);

  Map<String, dynamic> toJson() => _$FieldToJson(this);
}

@JsonSerializable()
class Record {
  @JsonKey(name: 'locations', defaultValue: [])
  List<Locations> locations;

  Record({
    required this.locations,
  });

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  Map<String, dynamic> toJson() => _$RecordToJson(this);
}

@JsonSerializable()
class Locations {
  @JsonKey(name: 'datasetDescription', defaultValue: "")
  String datasetDescription;

  @JsonKey(name: 'locationsName', defaultValue: "")
  String locationsName;

  @JsonKey(name: 'dataid', defaultValue: "")
  String dataid;

  @JsonKey(name: 'location', defaultValue: [])
  List<Location> location;

  Locations({
    required this.datasetDescription,
    required this.locationsName,
    required this.dataid,
    required this.location,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);

  Map<String, dynamic> toJson() => _$LocationsToJson(this);
}

@JsonSerializable()
class Location {
  @JsonKey(name: 'locationName', defaultValue: "")
  String locationName;

  @JsonKey(name: 'geocode', defaultValue: "")
  String geocode;

  @JsonKey(name: 'lat', defaultValue: "")
  String lat;

  @JsonKey(name: 'lon', defaultValue: "")
  String lon;

  @JsonKey(name: 'weatherElement', defaultValue: [])
  List<WeatherElement> weatherElement;

  Location({
    required this.locationName,
    required this.geocode,
    required this.lat,
    required this.lon,
    required this.weatherElement,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class WeatherElement {
  @JsonKey(name: 'elementName', defaultValue: "")
  String elementName;

  @JsonKey(name: 'description', defaultValue: "")
  String description;

  @JsonKey(name: 'time', defaultValue: [])
  List<Time> time;

  WeatherElement({
    required this.elementName,
    required this.description,
    required this.time,
  });

  factory WeatherElement.fromJson(Map<String, dynamic> json) =>
      _$WeatherElementFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherElementToJson(this);
}

@JsonSerializable()
class Time {
  @JsonKey(name: 'startTime', defaultValue: "")
  String startTime;

  @JsonKey(name: 'endTime', defaultValue: "")
  String endTime;

  @JsonKey(name: 'elementValue', defaultValue: [])
  List<ElementValue> elementValue;

  Time({
    required this.startTime,
    required this.endTime,
    required this.elementValue,
  });

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  Map<String, dynamic> toJson() => _$TimeToJson(this);
}

@JsonSerializable()
class ElementValue {
  @JsonKey(name: 'value', defaultValue: "")
  String value;

  @JsonKey(name: 'measures', defaultValue: "")
  String measures;

  ElementValue({
    required this.value,
    required this.measures,
  });

  factory ElementValue.fromJson(Map<String, dynamic> json) =>
      _$ElementValueFromJson(json);

  Map<String, dynamic> toJson() => _$ElementValueToJson(this);
}
