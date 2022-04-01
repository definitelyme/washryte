library payment_method.dart;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_method.g.dart';

class PaymentMethod extends EnumClass {
  static const PaymentMethod CASH = _$CASH;
  static const PaymentMethod TRANSFER = _$TRANSFER;
  static const PaymentMethod POS = _$POS;
  @BuiltValueEnumConst(fallback: true)
  static const PaymentMethod PENDING = _$PENDING;
  static const PaymentMethod WALLET = _$WALLET;

  const PaymentMethod._(String name) : super(name);

  static BuiltSet<PaymentMethod> get values => _$values;

  static PaymentMethod valueOf(String name) => _$valueOf(name);

  String get formatted {
    return when(
      cash: () => 'Cash',
      transfer: () => 'Bank Transfer',
      pos: () => 'POS',
      pending: () => 'Pending',
      wallet: () => 'Wallet',
    );
  }
}

class PaymentMethodSerializer implements JsonConverter<PaymentMethod?, String?> {
  const PaymentMethodSerializer();

  @override
  PaymentMethod fromJson(String? value) => PaymentMethod.valueOf('$value');

  @override
  String? toJson(PaymentMethod? instance) => instance?.name;
}

extension PaymentMethodX on PaymentMethod {
  T maybeWhen<T>({
    T Function()? cash,
    T Function()? transfer,
    T Function()? pos,
    T Function()? pending,
    T Function()? wallet,
    required T Function() orElse,
  }) {
    if (this == PaymentMethod.CASH)
      return cash?.call() ?? orElse.call();
    else if (this == PaymentMethod.TRANSFER)
      return transfer?.call() ?? orElse.call();
    else if (this == PaymentMethod.POS)
      return pos?.call() ?? orElse.call();
    else if (this == PaymentMethod.PENDING)
      return pending?.call() ?? orElse.call();
    else if (this == PaymentMethod.WALLET)
      return wallet?.call() ?? orElse.call();
    else
      return orElse.call();
  }

  T when<T>({
    required T Function() cash,
    required T Function() transfer,
    required T Function() pos,
    required T Function() pending,
    required T Function() wallet,
  }) {
    switch (this) {
      case PaymentMethod.CASH:
        return cash.call();
      case PaymentMethod.TRANSFER:
        return transfer.call();
      case PaymentMethod.POS:
        return pos.call();
      case PaymentMethod.WALLET:
        return wallet.call();
      case PaymentMethod.PENDING:
      default:
        return pending.call();
    }
  }
}
