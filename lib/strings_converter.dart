import 'dart:io';

import 'package:xml/xml.dart' as xml;

void convert() async {
  int startDate = DateTime.now().millisecondsSinceEpoch;
  final File file = File('strings.txt');
  final File resultFile = await File('result.txt').create();

  List<String> fileLines = await file.readAsLines();

  for (var line in fileLines) {
    var storeXml = line;
    var storeDocument = xml.parse(storeXml);
    resultFile.writeAsStringSync("\n", mode: FileMode.append);
    String varName =
        formateTheVariableName(storeDocument.rootElement.attributes[0].value);
    String value = storeDocument.rootElement.children[0].text;

    resultFile.writeAsStringSync(fromateTheFiled(varName, value),
        mode: FileMode.append);
    resultFile.writeAsStringSync("\n", mode: FileMode.append);
  }
  int endDate = DateTime.now().millisecondsSinceEpoch;
  print(endDate - startDate);
}

String fromateTheFiled(String varName, String value) {
  return """
   String get $varName {
    return Intl.message("$value", name: '$varName');
  }
  """;
}

String formateTheVariableName(String variableName) {
  final List<String> variableNameElements = variableName.split("_");
  if (variableNameElements.length == 1) {
    return charToCase(variableNameElements[0]);
  } else {
    String varName = charToCase(variableNameElements[0]);
    for (var i = 1; i < variableNameElements.length; i++) {
      varName += charToCase(variableNameElements[i], toLower: false);
    }

    return varName;
  }
}

String charToCase(String name, {bool toLower = true}) {
  String generatedName = "";
  for (var i = 0; i < name.length; i++) {
    if (i == 0 && toLower) {
      generatedName += name[0].toLowerCase();
    } else if (i == 0 && !toLower) {
      generatedName += name[0].toUpperCase();
    } else {
      generatedName += name[i].toLowerCase();
    }
  }

  return generatedName;
}
