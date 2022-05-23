library service_request_dto.dart;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';
import 'package:washryte/core/data/models/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/features/dashboard/data/data.dart';
import 'package:washryte/features/dashboard/domain/domain.dart';
import 'package:washryte/manager/serializer/serializers.dart';

part 'service_request_dto.g.dart';
part 'service_request_dto.freezed.dart';

ServiceRequestDTO deserializeServiceRequestDTO(Map<String, dynamic> json) => ServiceRequestDTO.fromJson(json);
Map<String, dynamic> serializeServiceRequestDTO(ServiceRequestDTO object) => object.toJson();

@freezed
@immutable
class ServiceRequestDTO with _$ServiceRequestDTO {
  const ServiceRequestDTO._();

  const factory ServiceRequestDTO({
    @StringSerializer() String? id,
    String? customerId,
    String? items,
    String? address,
    String? reference,
    @DoubleSerializer() double? price,
    @DoubleSerializer() double? amount,
    @ServiceTypeSerializer() ServiceType? serviceType,
    @PaymentMethodSerializer() PaymentMethod? paymentMethod,
    @OrderStatusSerializer() OrderStatus? status,
    @Default([]) List<LaundryServiceDTO> services,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    //
    ServiceRequestDTO? data,
  }) = _ServiceRequestDTO;

  /// Maps ServiceRequest to a Data Transfer Object.
  factory ServiceRequestDTO.fromDomain(ServiceRequest instance) => ServiceRequestDTO(
        serviceType: instance.type,
        items: instance.items.getOrNull,
        address: instance.address.getOrNull,
      );

  /// Maps the incoming Json to a Data Transfer Object (DTO).
  factory ServiceRequestDTO.fromJson(Map<String, dynamic> json) => _$ServiceRequestDTOFromJson(json);

  /// Maps the Data Transfer Object to a ServiceRequest Object.
  ServiceRequest get domain => ServiceRequest(
        id: UniqueId.fromExternal(id),
        customerId: UniqueId.fromExternal(customerId),
        type: serviceType!,
        address: BasicTextField(address),
        amount: AmountField(price ?? amount ?? 0),
        reference: BasicTextField(reference),
        items: BasicTextField(items),
        paymentMethod: paymentMethod!,
        status: status!,
        services: services.map((e) => e.domain).toImmutableList(),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

ServiceRequestListDTO deserializeServiceRequestListDTO(Map<String, dynamic> json) => ServiceRequestListDTO.fromJson(json);
Map<String, dynamic> serializeServiceRequestListDTO(ServiceRequestListDTO object) => object.toJson();

@freezed
@immutable
class ServiceRequestListDTO with _$ServiceRequestListDTO {
  const ServiceRequestListDTO._();

  const factory ServiceRequestListDTO({
    @Default([]) List<ServiceRequestDTO> data,
    PaginationLinks? links,
    MetaField? meta,
  }) = _ServiceRequestListDTO;

  /// Maps the incoming Json to a Data Transfer Object (DTO).
  factory ServiceRequestListDTO.fromJson(Map<String, dynamic> json) => _$ServiceRequestListDTOFromJson(json);

  /// Maps the Data Transfer Object to a KtList<ServiceRequest> Object.
  KtList<ServiceRequest> get domain => KtList.from(data.map((e) => e.domain));
}
