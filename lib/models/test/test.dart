import 'package:json_annotation/json_annotation.dart';

import 'user.dart';
import './user.dart';
import './datas/data.dart';

part 'test.g.dart';

/// 生成Model类
@JsonSerializable()
class Test {
    Test();

    @JsonKey(name: 'num')
    num num_;
    @JsonKey(name: 'int')
    num int_;
    @JsonKey(name: 'double')
    num double_;
    @JsonKey(name: 'bool')
    bool bool_;
    @JsonKey(name: 'String')
    String String_;
    @JsonKey(name: 'List')
    String List_;
    @JsonKey(name: 'Map')
    String Map_;
    @JsonKey(name: 'import')
    String import_;
    num customize3;
    User user1;
    User user2;
    Data data;
    List<num> Listnum;
    List<int> Listint;
    List<double> Listdouble;
    List<bool> Listbool;
    List<String> ListString;
    List<List> ListList;
    List<Map> ListMap;
    List<User> ListUser1;
    List<User> ListUser2;
    List<Data> ListData;
    User customize_;
    
    factory Test.fromJson(Map<String,dynamic> json) => _$TestFromJson(json);
    Map<String, dynamic> toJson() => _$TestToJson(this);
}

