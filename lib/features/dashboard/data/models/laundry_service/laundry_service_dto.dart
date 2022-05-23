library laundry_service_dto.dart;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';
import 'package:washryte/core/data/models/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/features/dashboard/domain/domain.dart';
import 'package:washryte/manager/serializer/serializers.dart';

part 'laundry_service_dto.freezed.dart';
part 'laundry_service_dto.g.dart';

LaundryServiceDTO deserializeLaundryServiceDTO(Map<String, dynamic> json) => LaundryServiceDTO.fromJson(json);
Map<String, dynamic> serializeLaundryServiceDTO(LaundryServiceDTO object) => object.toJson();

@freezed
@immutable
class LaundryServiceDTO with _$LaundryServiceDTO {
  const LaundryServiceDTO._();

  const factory LaundryServiceDTO({
    @StringSerializer() String? id,
    @JsonKey(name: 'service_name') String? name,
    @JsonKey(name: 'service_units') @IntegerSerializer() int? quantity,
    @JsonKey(name: 'service_unit_price') @DoubleSerializer() double? price,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _LaundryServiceDTO;

  /// Maps the incoming Json to a Data Transfer Object (DTO).
  factory LaundryServiceDTO.fromJson(Map<String, dynamic> json) => _$LaundryServiceDTOFromJson(json);

  /// Maps the Data Transfer Object to a LaundryService Object.
  LaundryService get domain => LaundryService(
        id: UniqueId.fromExternal(id),
        name: BasicTextField(name),
        quantity: AmountField(quantity ?? 1),
        price: AmountField(price ?? 0),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

LaundryServiceListDTO deserializeLaundryServiceListDTO(Map<String, dynamic> json) => LaundryServiceListDTO.fromJson(json);
Map<String, dynamic> serializeLaundryServiceListDTO(LaundryServiceListDTO object) => object.toJson();

@freezed
@immutable
class LaundryServiceListDTO with _$LaundryServiceListDTO {
  const LaundryServiceListDTO._();

  const factory LaundryServiceListDTO({
    @Default([]) List<LaundryServiceDTO> data,
    PaginationLinks? links,
    MetaField? meta,
  }) = _LaundryServiceListDTO;

  /// Maps the incoming Json to a Data Transfer Object (DTO).
  factory LaundryServiceListDTO.fromJson(Map<String, dynamic> json) => _$LaundryServiceListDTOFromJson(json);

  /// Maps the Data Transfer Object to a KtList<LaundryService> Object.
  KtList<LaundryService> get domain => KtList.from(data.map((e) => e.domain));
}
