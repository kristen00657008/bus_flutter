// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherBean _$WeatherBeanFromJson(Map<String, dynamic> json) => WeatherBean(
      success: json['success'] as String? ?? '',
      result: Result.fromJson(json['result'] as Map<String, dynamic>),
      records: Record.fromJson(json['records'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherBeanToJson(WeatherBean instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
      'records': instance.records,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      resourceId: json['resource_id'] as String? ?? '',
      fields: (json['fields'] as List<dynamic>?)
              ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'resource_id': instance.resourceId,
      'fields': instance.fields,
    };

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

Record _$RecordFromJson(Map<String, dynamic> json) => Record(
      locations: (json['locations'] as List<dynamic>?)
              ?.map((e) => Locations.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'locations': instance.locations,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) => Locations(
      datasetDescription: json['datasetDescription'] as String? ?? '',
      locationsName: json['locationsName'] as String? ?? '',
      dataid: json['dataid'] as String? ?? '',
      location: (json['location'] as List<dynamic>?)
              ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'datasetDescription': instance.datasetDescription,
      'locationsName': instance.locationsName,
      'dataid': instance.dataid,
      'location': instance.location,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      locationName: json['locationName'] as String? ?? '',
      geocode: json['geocode'] as String? ?? '',
      lat: json['lat'] as String? ?? '',
      lon: json['lon'] as String? ?? '',
      weatherElement: (json['weatherElement'] as List<dynamic>?)
              ?.map((e) => WeatherElement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'locationName': instance.locationName,
      'geocode': instance.geocode,
      'lat': instance.lat,
      'lon': instance.lon,
      'weatherElement': instance.weatherElement,
    };

WeatherElement _$WeatherElementFromJson(Map<String, dynamic> json) =>
    WeatherElement(
      elementName: json['elementName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      time: (json['time'] as List<dynamic>?)
              ?.map((e) => Time.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$WeatherElementToJson(WeatherElement instance) =>
    <String, dynamic>{
      'elementName': instance.elementName,
      'description': instance.description,
      'time': instance.time,
    };

Time _$TimeFromJson(Map<String, dynamic> json) => Time(
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
      elementValue: (json['elementValue'] as List<dynamic>?)
              ?.map((e) => ElementValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'elementValue': instance.elementValue,
    };

ElementValue _$ElementValueFromJson(Map<String, dynamic> json) => ElementValue(
      value: json['value'] as String? ?? '',
      measures: json['measures'] as String? ?? '',
    );

Map<String, dynamic> _$ElementValueToJson(ElementValue instance) =>
    <String, dynamic>{
      'value': instance.value,
      'measures': instance.measures,
    };
