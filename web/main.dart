// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:dart_serialization_no_mirrors/serialization.dart';
import 'package:dart_serialization_no_mirrors/person.dart';
import 'package:dart_serialization_no_mirrors/address.dart';
import 'package:http/browser_client.dart';

void main() {

  bootstrap_serialization();

  querySelector('#sendButton').onClick.listen(send);
}

void send(MouseEvent event) {

  var person = new Person(firstName: "Dartisian", lastName: "Dartus", address: new Address(street: "Dartway", city: "Dartoplis"));
  var serializedPerson = serialize(person);

  var client = new BrowserClient();
  var url = "http://localhost:8081";
  client.post(url, body: serializedPerson)
  .then((response) {
    String message;
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
    if (response.statusCode == 200) {
      try {
        var deserializedPerson = deserialize(response.body);
        message = 'Message serialized, sent, recieved, and deserialized. Trace network activity to see what was transfered.';
      }
      catch (ex) {
        message = 'Deserialiaztion failed.';
      }
    }
    else {
      message = 'Send failed. Maybe wrong server URL or server is not running. StatusCode of respone was ${response.statusCode}.';
    }

    querySelector('#output').text = message;

  });

}

