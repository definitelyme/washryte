// GENERATED CODE - DO NOT MODIFY BY HAND

part of laundry_service_dto.dart;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LaundryServiceDTO _$$_LaundryServiceDTOFromJson(Map<String, dynamic> json) =>
    _$_LaundryServiceDTO(
      id: const StringSerializer().fromJson(json['id']),
      name: json['service_name'] as String?,
      quantity: const IntegerSerializer().fromJson(json['service_units']),
      price: const DoubleSerializer().fromJson(json['service_unit_price']),
      createdAt: const TimestampConverter().fromJson(json['created_at']),
      updatedAt: const TimestampConverter().fromJson(json['updated_at']),
    );

Map<String, dynamic> _$$_LaundryServiceDTOToJson(
    _$_LaundryServiceDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', const StringSerializer().toJson(instance.id));
  writeNotNull('service_name', instance.name);
  writeNotNull(
      'service_units', const IntegerSerializer().toJson(instance.quantity));
  writeNotNull(
      'service_unit_price', const DoubleSerializer().toJson(instance.price));
  writeNotNull(
      'created_at', const TimestampConverter().toJson(instance.createdAt));
  writeNotNull(
      'updated_at', const TimestampConverter().toJson(instance.updatedAt));
  return val;
}

_$_LaundryServiceListDTO _$$_LaundryServiceListDTOFromJson(
        Map<String, dynamic> json) =>
    _$_LaundryServiceListDTO(
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => LaundryServiceDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      links: json['links'] == null
          ? null
          : PaginationLinks.fromJson(json['links'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? null
          : MetaField.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_LaundryServiceListDTOToJson(
    _$_LaundryServiceListDTO instance) {
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
