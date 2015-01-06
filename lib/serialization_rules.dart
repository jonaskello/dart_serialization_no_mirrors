library dart_serialization_no_mirrors.serialization_rules;

/// This file contains the serialization rules
/// Using the serialization package without mirrors requires that you
/// have these rules statically defined.
/// The serialization package supports three ways to
/// handle these rules:
/// 1. Dynamic code-gen with the transformer (then this file is not needed).
/// 2. Static code-gen using the transformer coda as stand-alone (will generate something like this file).
/// 3. Manually authoring the rules (as is done in this file).
/// You can of course also write your own code-gen to generate something similar to this file.

import 'package:serialization/serialization.dart';
import 'package:dart_serialization_no_mirrors/person.dart';
import 'package:dart_serialization_no_mirrors/address.dart';

get rules => [
    new PersonSerializationRule(),
    new AddressSerializationRule()
];

abstract class ImmutableSerializationRule extends CustomRule {

  bool appliesTo(instance, Writer w);

  create(List state);

  List getState(instance);

  void setState(object, List state) {
    // Do nothing because immutable
  }

}

class PersonSerializationRule extends ImmutableSerializationRule {
  bool appliesTo(instance, _) => instance.runtimeType == Person;

  create(state) => new Person(
      firstName: state[0],
      lastName: state[1],
      address: state[2]
  );

  getState(Person instance) => [
      instance.firstName,
      instance.lastName,
      instance.address,
  ];
}

class AddressSerializationRule extends ImmutableSerializationRule {
  bool appliesTo(instance, _) => instance.runtimeType == Address;

  create(state) => new Address(
      street: state[0],
      city: state[1]
  );

  getState(Address instance) => [
      instance.street,
      instance.city
  ];

}
