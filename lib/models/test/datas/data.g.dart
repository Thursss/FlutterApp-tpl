// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data()
    ..name = json['name'] as String
    ..email = json['email'] as String
    ..mother = json['mother'] == null
        ? null
        : User.fromJson(json['mother'] as Map<String, dynamic>)
    ..friends = (json['friends'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'mother': instance.mother,
      'friends': instance.friends,
    };
