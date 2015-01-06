// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:async';

import 'package:args/args.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;

import 'package:dart_serialization_no_mirrors/serialization.dart';
import 'package:dart_serialization_no_mirrors/person.dart';
import 'package:dart_serialization_no_mirrors/address.dart';

void main(List<String> args) {

  bootstrap_serialization();

  var parser = new ArgParser()
    ..addOption('port', abbr: 'p', defaultsTo: '8081');

  var result = parser.parse(args);

  var port = int.parse(result['port'], onError: (val) {
    stdout.writeln('Could not parse port value "$val" into a number.');
    exit(1);
  });

  var handler = const shelf.Pipeline()
  .addMiddleware(shelf.logRequests())
  .addHandler(_handleRequest);

  io.serve(handler, 'localhost', port).then((server) {
    print('Serving at http://${server.address.host}:${server.port}');
  });
}

Future<shelf.Response> _handleRequest(shelf.Request request) {

  var completer = new Completer<shelf.Response>();

  request.readAsString().then((body) {

    var person = deserialize(body);
    var serializedPerson = serialize(person);

    completer.complete(new shelf.Response.ok(serializedPerson, headers: {
        "Access-Control-Allow-Origin": "*"
    }));

  });

  return completer.future;

}
