// GENERATED CODE - DO NOT MODIFY BY HAND

part of service_request_dto.dart;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ServiceRequestDTO _$$_ServiceRequestDTOFromJson(Map<String, dynamic> json) =>
    _$_ServiceRequestDTO(
      id: const StringSerializer().fromJson(json['id']),
      customerId: json['customer_id'] as String?,
      items: json['items'] as String?,
      address: json['address'] as String?,
      reference: json['reference'] as String?,
      price: const DoubleSerializer().fromJson(json['price']),
      amount: const DoubleSerializer().fromJson(json['amount']),
      serviceType: const ServiceTypeSerializer()
          .fromJson(json['service_type'] as String?),
      paymentMethod: const PaymentMethodSerializer()
          .fromJson(json['payment_method'] as String?),
      status: const OrderStatusSerializer().fromJson(json['status'] as String?),
      services: (json['services'] as List<dynamic>?)
              ?.map(
                  (e) => LaundryServiceDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: const TimestampConverter().fromJson(json['created_at']),
      updatedAt: const TimestampConverter().fromJson(json['updated_at']),
      data: json['data'] == null
          ? null
          : ServiceRequestDTO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ServiceRequestDTOToJson(
    _$_ServiceRequestDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', const StringSerializer().toJson(instance.id));
  writeNotNull('customer_id', instance.customerId);
  writeNotNull('items', instance.items);
  writeNotNull('address', instance.address);
  writeNotNull('reference', instance.reference);
  writeNotNull('price', const DoubleSerializer().toJson(instance.price));
  writeNotNull('amount', const DoubleSerializer().toJson(instance.amount));
  writeNotNull('service_type',
      const ServiceTypeSerializer().toJson(instance.serviceType));
  writeNotNull('payment_method',
      const PaymentMethodSerializer().toJson(instance.paymentMethod));
  writeNotNull('status', const OrderStatusSerializer().toJson(instance.status));
  val['services'] = instance.services.map((e) => e.toJson()).toList();
  writeNotNull(
      'created_at', const TimestampConverter().toJson(instance.createdAt));
  writeNotNull(
      'updated_at', const TimestampConverter().toJson(instance.updatedAt));
  writeNotNull('data', instance.data?.toJson());
  return val;
}

_$_ServiceRequestListDTO _$$_ServiceRequestListDTOFromJson(
        Map<String, dynamic> json) =>
    _$_ServiceRequestListDTO(
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => ServiceRequestDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      links: json['links'] == null
          ? null
          : PaginationLinks.fromJson(json['links'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? null
          : MetaField.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ServiceRequestListDTOToJson(
    _$_ServiceRequestListDTO instance) {
  final val = <String, dynamic>{
    'data': instance.data.map((e) => e.toJson()).toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('links', instance.links?.toJson());
  writeNotNull('meta', instance.meta?.toJson());
  return val;
}
