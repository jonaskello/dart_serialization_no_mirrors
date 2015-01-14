// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:dart_serialization_no_mirrors/serialization.dart';
import 'package:dart_serialization_no_mirrors/person.dart';
import 'package:dart_serialization_no_mirrors/address.dart';

void main() {

  bootstrap_serialization();

  querySelector('#sendButton').onClick.listen(send);
}

void send(MouseEvent event) {

  var person = new Person(firstName: "Dartisian", lastName: "Dartus", address: new Address(street: "Dartway", city: "Dartoplis"));
  var serializedPerson = serialize(person);

  var url = "http://localhost:8081";
  String message;
  HttpRequest.request(url, method: "POST", sendData: serializedPerson)
  .then((HttpRequest response) {

    try {
      var deserializedPerson = deserialize(response.response);
      message = 'Message serialized, sent, recieved, and deserialized. Trace network activity to see what was transfered.';
    }
    catch (ex) {
      message = 'Deserialiaztion failed.';
    }
    querySelector('#output').text = message;

  }).catchError((_) {

    message = 'Send failed. Maybe wrong server URL or server is not running.';
    querySelector('#output').text = message;

  }) ;

}

