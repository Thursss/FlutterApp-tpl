import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';


part 'user.g.dart';

/// 生成Model类
@JsonSerializable()
class User {
    User();

    String name;
    String email;
    
    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);

    Map<String, dynamic> toJson() => _$UserToJson(this);
}

