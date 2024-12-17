import 'dart:convert';
import 'dart:io';

void main() {
  var l10nDir = "../lib/l10n";
  List<FileSystemEntity> fileList = Directory(l10nDir).listSync();

  for (var file in fileList) {
    formatJsonFile(file);
  }
}

void formatJsonFile(FileSystemEntity file) {
  if (file.path.contains('.bk.') || file.path.contains('.gitignore')) {
    return;
  }

  print("FormatJsonFile: ${file.path}");
  var myFile = File(file.path);
  myFile.copySync("${file.path}.bk.${DateTime.now()}");
  var linesSync = myFile.readAsLinesSync();
  var jsonMap = jsonDecode(linesSync.join("")) as Map<String, dynamic>;
  var content = toPrettyString(sortMap(jsonMap), 0);
  myFile.writeAsString(content);
}

Map<String, dynamic> sortMap(Map<String, dynamic> map) {
  var keys = map.keys.toList();
  keys.sort();
  Map<String, dynamic> newMap = {};
  for (var key in keys) {
    if (key.startsWith('@')) {
      continue;
    }
    newMap[key] = map[key];
    var descriptionKey = '@$key';
    if (map.containsKey(descriptionKey)) {
      newMap[descriptionKey] = map[descriptionKey];
    }
  }

  return newMap;
}

String toPrettyString(Map<String, dynamic> map, int tabCount) {
  var result = "{\n";
  var keys = map.keys.toList();
  var keyCount = keys.length;
  for (var i = 0; i < keyCount; i++) {
    var key = keys[i];
    var val = map[key];
    result += '${tabCountToSpaces(tabCount + 1)}"$key": ';
    if (val is Map) {
      result += toPrettyString(val as Map<String, dynamic>, tabCount + 1);
    } else if (val is int) {
      result += '$val';
    } else {
      result += '"$val"';
    }
    if (i < keys.length - 1) {
      result += ",";
    }
    result += "\n";
  }
  result += "${tabCountToSpaces(tabCount)}}";
  return result;
}

String tabCountToSpaces(int tabCount) {
  var tabContent = "  ";
  var result = "";
  for (var i = 0; i < tabCount; i++) {
    result += tabContent;
  }
  return result;
}
