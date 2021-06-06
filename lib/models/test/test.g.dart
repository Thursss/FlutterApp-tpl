// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) {
  return Test()
    ..num_ = json['num'] as num
    ..int_ = json['int'] as num
    ..double_ = json['double'] as num
    ..bool_ = json['bool'] as bool
    ..String_ = json['String'] as String
    ..List_ = json['List'] as String
    ..Map_ = json['Map'] as String
    ..import_ = json['import'] as String
    ..customize3 = json['customize3'] as num
    ..user1 = json['user1'] == null
        ? null
        : User.fromJson(json['user1'] as Map<String, dynamic>)
    ..user2 = json['user2'] == null
        ? null
        : User.fromJson(json['user2'] as Map<String, dynamic>)
    ..data = json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>)
    ..Listnum = (json['Listnum'] as List)?.map((e) => e as num)?.toList()
    ..Listint = (json['Listint'] as List)?.map((e) => e as int)?.toList()
    ..Listdouble = (json['Listdouble'] as List)
        ?.map((e) => (e as num)?.toDouble())
        ?.toList()
    ..Listbool = (json['Listbool'] as List)?.map((e) => e as bool)?.toList()
    ..ListString =
        (json['ListString'] as List)?.map((e) => e as String)?.toList()
    ..ListList = (json['ListList'] as List)?.map((e) => e as List)?.toList()
    ..ListMap = (json['ListMap'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList()
    ..ListUser1 = (json['ListUser1'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..ListUser2 = (json['ListUser2'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..ListData = (json['ListData'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..customize_ = json['customize_'] == null
        ? null
        : User.fromJson(json['customize_'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'num': instance.num_,
      'int': instance.int_,
      'double': instance.double_,
      'bool': instance.bool_,
      'String': instance.String_,
      'List': instance.List_,
      'Map': instance.Map_,
      'import': instance.import_,
      'customize3': instance.customize3,
      'user1': instance.user1,
      'user2': instance.user2,
      'data': instance.data,
      'Listnum': instance.Listnum,
      'Listint': instance.Listint,
      'Listdouble': instance.Listdouble,
      'Listbool': instance.Listbool,
      'ListString': instance.ListString,
      'ListList': instance.ListList,
      'ListMap': instance.ListMap,
      'ListUser1': instance.ListUser1,
      'ListUser2': instance.ListUser2,
      'ListData': instance.ListData,
      'customize_': instance.customize_,
    };
