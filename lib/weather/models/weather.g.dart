// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    condition: _$enumDecode(_$WeatherConditionEnumMap, json['condition']),
    state: _$enumDecode(_$WeatherStateEnumMap, json['state']),
    stateDescription: json['stateDescription'] as String,
    lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    location: json['location'] as String,
    temperature: (json['temperature'] as num).toDouble(),
    minTemp: (json['minTemp'] as num).toDouble(),
    maxTemp: (json['maxTemp'] as num).toDouble(),
    windSpeed: (json['windSpeed'] as num).toDouble(),
    airPressure: (json['airPressure'] as num).toDouble(),
    humidity: json['humidity'] as int,
  );
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'condition': _$WeatherConditionEnumMap[instance.condition],
      'state': _$WeatherStateEnumMap[instance.state],
      'stateDescription': instance.stateDescription,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'location': instance.location,
      'temperature': instance.temperature,
      'minTemp': instance.minTemp,
      'maxTemp': instance.maxTemp,
      'windSpeed': instance.windSpeed,
      'airPressure': instance.airPressure,
      'humidity': instance.humidity,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.rainy: 'rainy',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.snowy: 'snowy',
  WeatherCondition.unknown: 'unknown',
};

const _$WeatherStateEnumMap = {
  api.WeatherState.snow: 'sn',
  api.WeatherState.sleet: 'sl',
  api.WeatherState.hail: 'h',
  api.WeatherState.thunderstorm: 't',
  api.WeatherState.heavyRain: 'hr',
  api.WeatherState.lightRain: 'lr',
  api.WeatherState.showers: 's',
  api.WeatherState.heavyCloud: 'hc',
  api.WeatherState.lightCloud: 'lc',
  api.WeatherState.clear: 'c',
  api.WeatherState.unknown: 'unknown',
};
