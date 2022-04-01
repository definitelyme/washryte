library service_type.dart;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_type.g.dart';

class ServiceType extends EnumClass {
  @BuiltValueEnumConst(fallback: true)
  static const ServiceType pickup = _$pickup;
  static const ServiceType delivery = _$delivery;

  const ServiceType._(String name) : super(name);

  String get json {
    switch (this) {
      case ServiceType.pickup:
        return 'pickup';
      case ServiceType.delivery:
        return 'pickup-and-delivery';
    }

    return 'pickup';
  }

  String get formatted {
    switch (this) {
      case ServiceType.pickup:
        return 'Pick Up only';
      case ServiceType.delivery:
        return 'Pick Up and Delivery';
    }

    return 'Pick Up only';
  }

  static BuiltSet<ServiceType> get values => _$values;

  static List<ServiceType> get list => values.toList();

  static ServiceType valueOf(String name) => _$valueOf(name);

  static ServiceType fromJson(String json) {
    switch (json) {
      case 'pickup':
        return ServiceType.pickup;
      case 'pickup-and-delivery':
        return ServiceType.delivery;
    }

    return ServiceType.pickup;
  }
}

class ServiceTypeSerializer implements JsonConverter<ServiceType?, String?> {
  const ServiceTypeSerializer();

  @override
  ServiceType fromJson(String? value) => ServiceType.fromJson('$value');

  @override
  String? toJson(ServiceType? instance) => instance?.json;
}

extension ServiceTypeX on ServiceType {
  T when<T>({
    required T Function() pickup,
    required T Function() delivery,
  }) {
    switch (this) {
      case ServiceType.delivery:
        return delivery.call();
      case ServiceType.pickup:
      default:
        return pickup.call();
    }
  }
}
