library order_status.dart;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_status.g.dart';

class OrderStatus extends EnumClass {
  @BuiltValueEnumConst(fallback: true)
  static const OrderStatus pending = _$pending;
  static const OrderStatus enroute = _$enroute;
  static const OrderStatus processing = _$processing;
  static const OrderStatus washing = _$washing;
  static const OrderStatus delivering = _$delivering;
  static const OrderStatus done = _$done;
  static const OrderStatus cancelled = _$cancelled;
  static const OrderStatus delivered = _$delivered;
  static const OrderStatus paid = _$paid;

  const OrderStatus._(String name) : super(name);

  @override
  String get name {
    switch (this) {
      case pending:
        return 'Pending';
      case enroute:
        return 'Enroute to Pickup';
      case processing:
        return 'Processing your request';
      case washing:
        return 'Washing and Cleaning';
      case delivering:
        return 'Enroute to Delivery';
      case done:
        return 'Ready for Pickup';
      case cancelled:
        return 'Cancelled';
      case delivered:
        return 'Delivered';
      case paid:
        return 'Washing and Cleaning';
    }

    return 'Pending';
  }

  static BuiltSet<OrderStatus> get values => _$values;

  static OrderStatus valueOf(String name) => _$valueOf(name);
}

class OrderStatusSerializer implements JsonConverter<OrderStatus?, String?> {
  const OrderStatusSerializer();

  @override
  OrderStatus fromJson(String? value) => OrderStatus.valueOf('$value');

  @override
  String? toJson(OrderStatus? instance) => instance?.name;
}

extension OrderStatusX on OrderStatus {
  T when<T>({
    required T Function() pending,
    required T Function() enroute,
    required T Function() processing,
    required T Function() washing,
    required T Function() delivering,
    required T Function() done,
    required T Function() cancelled,
    required T Function() delivered,
    required T Function() paid,
  }) {
    switch (this) {
      case OrderStatus.enroute:
        return enroute.call();
      case OrderStatus.processing:
        return processing.call();
      case OrderStatus.washing:
        return washing.call();
      case OrderStatus.delivering:
        return delivering.call();
      case OrderStatus.done:
        return done.call();
      case OrderStatus.cancelled:
        return cancelled.call();
      case OrderStatus.delivered:
        return delivered.call();
      case OrderStatus.paid:
        return paid.call();
      case OrderStatus.pending:
      default:
        return pending.call();
    }
  }

  T maybeWhen<T>({
    T Function()? pending,
    T Function()? enroute,
    T Function()? processing,
    T Function()? washing,
    T Function()? delivering,
    T Function()? done,
    T Function()? cancelled,
    T Function()? delivered,
    T Function()? paid,
    required T Function() orElse,
  }) {
    switch (this) {
      case OrderStatus.enroute:
        return enroute?.call() ?? orElse();
      case OrderStatus.processing:
        return processing?.call() ?? orElse();
      case OrderStatus.washing:
        return washing?.call() ?? orElse();
      case OrderStatus.delivering:
        return delivering?.call() ?? orElse();
      case OrderStatus.done:
        return done?.call() ?? orElse();
      case OrderStatus.cancelled:
        return cancelled?.call() ?? orElse();
      case OrderStatus.delivered:
        return delivered?.call() ?? orElse();
      case OrderStatus.paid:
        return paid?.call() ?? orElse();
      case OrderStatus.pending:
        return pending?.call() ?? orElse();
      default:
        return orElse();
    }
  }
}
