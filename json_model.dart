import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as Path;

String srcDir = './jsons';
String distDir = './lib/models';
String distDirTpl = './modelsTpl';
String tag = '\$';
String tpl = '''
import 'package:json_annotation/json_annotation.dart';

%t
part '%s.g.dart';

/// 生成Model类
@JsonSerializable()
class %s {
    %s();

    %n
    factory %s.fromJson(Map<String,dynamic> json) => _\$%sFromJson(json);
    Map<String, dynamic> toJson() => _\$%sToJson(this);
}\n
''';

/// dart基本类型
List builtInType = [
  'int',
  'num',
  'string',
  'bool',
  'double',
  'map',
  'list',
  "String",
  "List",
  "Map"
];

/// dart内置标识符、保留字
List builtInDartWord = [
  'int',
  'num',
  'string',
  'bool',
  'double',
  'map',
  'list',
  "String",
  "List",
  "Map",
  "abstract",
  "do",
  "import",
  "super",
  "as",
  "dynamic",
  "in",
  "switch",
  "assert",
  "else",
  "interface",
  "sync",
  "async",
  "enum",
  "is",
  "this",
  "async",
  "export",
  "library",
  "throw",
  "await",
  "external",
  "mixin",
  "true",
  "break",
  "extends",
  "new",
  "try",
  "case",
  "factory",
  "null",
  "typedef",
  "catch",
  "false",
  "operator",
  "var",
  "class",
  "final",
  "part",
  "void",
  "const",
  "finally",
  "rethrow",
  "while",
  "continue",
  "for",
  "return",
  "with",
  "covariant",
  "get",
  "set",
  "yield",
  "default",
  "if",
  "static",
  "yield",
  "deferred",
  "implements"
];

void main(List<String> args) {
  walk(srcDir, distDir, tpl, tag: tag);
}

/// 遍历目录，读取json文件
void walk(String srcDir, String distDir, String tpl, {String tag = '\$'}) {
  Directory srcDirPath = Directory(srcDir);
  // 如果不存在srcDir目录
  if (!srcDirPath.existsSync()) return;

  List srcList = srcDirPath.listSync(recursive: true);
  // 如果srcDir目录为空
  if (srcList.isEmpty) return;

  // 如果不存在distDir目录，则创建它
  Directory disDirPath = Directory(distDir);
  if (!disDirPath.existsSync()) {
    disDirPath.createSync(recursive: true);
  } else {
    // disDirPath = Directory('./modelsTpl');
    // distDir = './modelsTpl';
    // if (!disDirPath.existsSync()) {
    //   disDirPath.createSync(recursive: true);
    // }
  }

  /// json文件
  File josnFile;

  // 遍历srcList
  srcList.forEach((f) {
    // 如果不是json文件不处理
    if (!FileSystemEntity.isFileSync(f.path)) return;
    List<String> basename = Path.basename(f.path).split(".");
    String fileName = basename.first;
    String fileType = basename.last.toLowerCase();
    if (fileType != "json" || fileName.startsWith("_")) return;

    /// json文件
    josnFile = File(f.path);

    /// 解析josn
    Map<String, dynamic> jsonData = json.decode(josnFile.readAsStringSync());

    /// 为了避免重复导入相同的包，用Set来保存生成的import语句。
    Set<String> importSet = new Set<String>();

    /// Model属性
    StringBuffer attrs = new StringBuffer();

    (jsonData as Map<String, dynamic>).forEach((key, val) {
      if (key == '') return;
      if (builtInDartWord.contains(key)) key = '${key}_';
      attrs.write('${getType(val, importSet, fileName, tag)} $key;\r\n    ');
    });

    /// 输出文件内容
    String distFilaData = format(tpl, {
      '%s': changeFirstChar(fileName),
      '%t': importSet.join(''),
      '%n': attrs.toString(),
    });

    /// 输出路径
    String p =
        f.path.replaceFirst(srcDir, distDir).replaceFirst(".json", ".dart");
    // 生成dart文件
    File(p)
      ..createSync(recursive: true)
      ..writeAsStringSync(distFilaData);
  });
}

///将JSON类型转为对应的dart类型
String getType(val, Set<String> importSet, String current, tag) {
  current = current.toLowerCase();
  if (val is bool) {
    return "bool";
  } else if (val is num) {
    return "num";
  } else if (val is Map) {
    return "Map<String,dynamic>";
  } else if (val is List) {
    return "List";
  } else if (val is String) {
    //处理特殊标志
    if (val.startsWith("$tag[]")) {
      String path = val.substring(3).trim();
      String type = val.substring(3).trim().split('/').last;
      if (type.toLowerCase() != current && !builtInType.contains(type)) {
        importSet.add("import '$path.dart';\n");
      }
      return "List<${builtInType.contains(type) ? type : changeFirstChar(type)}>";
    } else if (val.startsWith('${tag}_')) {
      return val.substring(2).trim();
    } else if (val.startsWith(tag)) {
      String path = val.substring(1).trim();
      String type = val.substring(1).trim().split('/').last;
      if (type.toLowerCase() != current && !builtInType.contains(type)) {
        importSet.add("import '$path.dart';\n");
      }
      return builtInType.contains(type) ? type : changeFirstChar(type);
    }
    return "String";
  } else {
    return "String";
  }
}

/// 替换模板占位符
String format(String tpl, Map<String, String> params) {
  if (params.isEmpty) new Exception("Missing parameter for string format");
  params.forEach((pla, fmt) {
    tpl = tpl.replaceAll(pla, fmt);
  });

  return tpl;
}

/// 首字母大小写
String changeFirstChar(String str, [bool upper = true]) {
  return (upper ? str[0].toUpperCase() : str[0].toLowerCase()) +
      str.substring(1);
}
