library service_request.dart;

import 'package:dartz/dartz.dart' hide id;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/core/domain/response/index.dart';
import 'package:washryte/features/dashboard/domain/domain.dart';

part 'service_request.freezed.dart';

@freezed
@immutable
class ServiceRequest extends BaseEntity with _$ServiceRequest {
  static DateTime firstDate = DateTime(DateTime.now().year - 5);
  static DateTime lastDate = DateTime.now();

  const ServiceRequest._();

  const factory ServiceRequest({
    required UniqueId<String?> id,
    required UniqueId<String?> customerId,
    @Default(ServiceType.pickup) ServiceType type,
    @Default(PaymentMethod.PENDING) PaymentMethod paymentMethod,
    @Default(OrderStatus.pending) OrderStatus status,
    required AmountField<double> amount,
    required BasicTextField<String?> items,
    required BasicTextField<String?> address,
    required BasicTextField<String?> reference,
    @Default(KtList.empty()) KtList<LaundryService> services,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ServiceRequest;

  factory ServiceRequest.blank() => ServiceRequest(
        id: UniqueId.fromExternal(null),
        customerId: UniqueId.fromExternal(null),
        amount: AmountField(0),
        items: BasicTextField(null),
        address: BasicTextField(null),
        reference: BasicTextField(null),
      );

  ServiceRequest merge(ServiceRequest? other) => copyWith(
        id: other?.id.value != null ? other!.id : id,
        customerId: other?.customerId.value != null ? other!.customerId : customerId,
        type: other?.type ?? type,
        paymentMethod: other?.paymentMethod ?? paymentMethod,
        status: other?.status ?? status,
        amount: other?.amount.isNotNull((it) => it as AmountField<double>, orElse: (_) => amount) ?? amount,
        items: other?.items.isNotNull((it) => it as BasicTextField<String?>, orElse: (_) => items) ?? items,
        address: other?.address.isNotNull((it) => it as BasicTextField<String?>, orElse: (_) => address) ?? address,
        reference: other?.reference.isNotNull((it) => it as BasicTextField<String?>, orElse: (_) => reference) ?? reference,
        services: other?.services ?? services,
        createdAt: other?.createdAt ?? createdAt,
        updatedAt: other?.updatedAt ?? updatedAt,
      );

  Option<FieldObjectException<dynamic>> get failure => items.mapped.andThen(address.mapped).fold((f) => some(f), (_) => none());
}
