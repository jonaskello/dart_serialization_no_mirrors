library dart_serialization_no_mirrors.person;

import 'package:dart_serialization_no_mirrors/address.dart';

class Person {

  final String firstName;
  final String lastName;
  final Address address;

  Person({this.firstName, this.lastName, this.address});

}
