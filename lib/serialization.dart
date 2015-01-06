library dart_serialization_no_mirrors.serialization;

/// This file bootstraps the serialization package and provides
/// utility methods to serialize and deserialize to/from JSON

import 'dart:convert';
import 'package:serialization/serialization.dart';
import 'package:dart_serialization_no_mirrors/serialization_rules.dart' as serialization_rules;

var serialization = new Serialization()
  ..selfDescribing = false
  ..defaultFormat = const SimpleJsonFormat(storeRoundTripInfo: true);

void bootstrap_serialization() {

  serialization_rules.rules.forEach(serialization.addRule);

}

String serialize(Object toSerialize) {

  var out = serialization.write(toSerialize);
  var outJson = JSON.encode(out);
  return outJson;

}

Object deserialize(dynamic body) {

  var reconstituted = JSON.decode(body);
  var deserializedObject = serialization.read(reconstituted);
  return deserializedObject;

}
