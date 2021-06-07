import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import '../user.dart';

part 'data.g.dart';

/// 生成Model类
@JsonSerializable()
class Data {
    Data();

    String name;
    String email;
    User mother;
    List<User> friends;
    
    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));
    String toRawJson() => json.encode(toJson());
    factory Data.fromJson(Map<String,dynamic> json) => _$DataFromJson(json);
    Map<String, dynamic> toJson() => _$DataToJson(this);
}

