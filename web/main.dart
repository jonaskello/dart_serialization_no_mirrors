// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:dart_serialization_no_mirrors/serialization.dart';

void main() {

  bootstrap_serialization();

  querySelector('#sendButton').onClick.listen(send);
}

void send(MouseEvent event) {


  querySelector('#output').text = 'Message sent and recieved. Trace network activity to see what was transfered.';
}

