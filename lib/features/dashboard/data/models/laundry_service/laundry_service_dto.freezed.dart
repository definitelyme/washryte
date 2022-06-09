// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of laundry_service_dto.dart;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LaundryServiceDTO _$LaundryServiceDTOFromJson(Map<String, dynamic> json) {
  return _LaundryServiceDTO.fromJson(json);
}

/// @nodoc
class _$LaundryServiceDTOTearOff {
  const _$LaundryServiceDTOTearOff();

  _LaundryServiceDTO call(
      {@StringSerializer() String? id,
      @JsonKey(name: 'service_name') String? name,
      @JsonKey(name: 'service_units') @IntegerSerializer() int? quantity,
      @JsonKey(name: 'service_unit_price') @DoubleSerializer() double? price,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt}) {
    return _LaundryServiceDTO(
      id: id,
      name: name,
      quantity: quantity,
      price: price,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  LaundryServiceDTO fromJson(Map<String, Object?> json) {
    return LaundryServiceDTO.fromJson(json);
  }
}

/// @nodoc
const $LaundryServiceDTO = _$LaundryServiceDTOTearOff();

/// @nodoc
mixin _$LaundryServiceDTO {
  @StringSerializer()
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_units')
  @IntegerSerializer()
  int? get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_unit_price')
  @DoubleSerializer()
  double? get price => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LaundryServiceDTOCopyWith<LaundryServiceDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaundryServiceDTOCopyWith<$Res> {
  factory $LaundryServiceDTOCopyWith(
          LaundryServiceDTO value, $Res Function(LaundryServiceDTO) then) =
      _$LaundryServiceDTOCopyWithImpl<$Res>;
  $Res call(
      {@StringSerializer() String? id,
      @JsonKey(name: 'service_name') String? name,
      @JsonKey(name: 'service_units') @IntegerSerializer() int? quantity,
      @JsonKey(name: 'service_unit_price') @DoubleSerializer() double? price,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$LaundryServiceDTOCopyWithImpl<$Res>
    implements $LaundryServiceDTOCopyWith<$Res> {
  _$LaundryServiceDTOCopyWithImpl(this._value, this._then);

  final LaundryServiceDTO _value;
  // ignore: unused_field
  final $Res Function(LaundryServiceDTO) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$LaundryServiceDTOCopyWith<$Res>
    implements $LaundryServiceDTOCopyWith<$Res> {
  factory _$LaundryServiceDTOCopyWith(
          _LaundryServiceDTO value, $Res Function(_LaundryServiceDTO) then) =
      __$LaundryServiceDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {@StringSerializer() String? id,
      @JsonKey(name: 'service_name') String? name,
      @JsonKey(name: 'service_units') @IntegerSerializer() int? quantity,
      @JsonKey(name: 'service_unit_price') @DoubleSerializer() double? price,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$LaundryServiceDTOCopyWithImpl<$Res>
    extends _$LaundryServiceDTOCopyWithImpl<$Res>
    implements _$LaundryServiceDTOCopyWith<$Res> {
  __$LaundryServiceDTOCopyWithImpl(
      _LaundryServiceDTO _value, $Res Function(_LaundryServiceDTO) _then)
      : super(_value, (v) => _then(v as _LaundryServiceDTO));

  @override
  _LaundryServiceDTO get _value => super._value as _LaundryServiceDTO;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_LaundryServiceDTO(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LaundryServiceDTO extends _LaundryServiceDTO {
  const _$_LaundryServiceDTO(
      {@StringSerializer() this.id,
      @JsonKey(name: 'service_name') this.name,
      @JsonKey(name: 'service_units') @IntegerSerializer() this.quantity,
      @JsonKey(name: 'service_unit_price') @DoubleSerializer() this.price,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : super._();

  factory _$_LaundryServiceDTO.fromJson(Map<String, dynamic> json) =>
      _$$_LaundryServiceDTOFromJson(json);

  @override
  @StringSerializer()
  final String? id;
  @override
  @JsonKey(name: 'service_name')
  final String? name;
  @override
  @JsonKey(name: 'service_units')
  @IntegerSerializer()
  final int? quantity;
  @override
  @JsonKey(name: 'service_unit_price')
  @DoubleSerializer()
  final double? price;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'LaundryServiceDTO(id: $id, name: $name, quantity: $quantity, price: $price, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LaundryServiceDTO &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.quantity, quantity) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(quantity),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$LaundryServiceDTOCopyWith<_LaundryServiceDTO> get copyWith =>
      __$LaundryServiceDTOCopyWithImpl<_LaundryServiceDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LaundryServiceDTOToJson(this);
  }
}

abstract class _LaundryServiceDTO extends LaundryServiceDTO {
  const factory _LaundryServiceDTO(
      {@StringSerializer() String? id,
      @JsonKey(name: 'service_name') String? name,
      @JsonKey(name: 'service_units') @IntegerSerializer() int? quantity,
      @JsonKey(name: 'service_unit_price') @DoubleSerializer() double? price,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt}) = _$_LaundryServiceDTO;
  const _LaundryServiceDTO._() : super._();

  factory _LaundryServiceDTO.fromJson(Map<String, dynamic> json) =
      _$_LaundryServiceDTO.fromJson;

  @override
  @StringSerializer()
  String? get id;
  @override
  @JsonKey(name: 'service_name')
  String? get name;
  @override
  @JsonKey(name: 'service_units')
  @IntegerSerializer()
  int? get quantity;
  @override
  @JsonKey(name: 'service_unit_price')
  @DoubleSerializer()
  double? get price;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$LaundryServiceDTOCopyWith<_LaundryServiceDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

LaundryServiceListDTO _$LaundryServiceListDTOFromJson(
    Map<String, dynamic> json) {
  return _LaundryServiceListDTO.fromJson(json);
}

/// @nodoc
class _$LaundryServiceListDTOTearOff {
  const _$LaundryServiceListDTOTearOff();

  _LaundryServiceListDTO call(
      {List<LaundryServiceDTO> data = const [],
      PaginationLinks? links,
      MetaField? meta}) {
    return _LaundryServiceListDTO(
      data: data,
      links: links,
      meta: meta,
    );
  }

  LaundryServiceListDTO fromJson(Map<String, Object?> json) {
    return LaundryServiceListDTO.fromJson(json);
  }
}

/// @nodoc
const $LaundryServiceListDTO = _$LaundryServiceListDTOTearOff();

/// @nodoc
mixin _$LaundryServiceListDTO {
  List<LaundryServiceDTO> get data => throw _privateConstructorUsedError;
  PaginationLinks? get links => throw _privateConstructorUsedError;
  MetaField? get meta => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LaundryServiceListDTOCopyWith<LaundryServiceListDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaundryServiceListDTOCopyWith<$Res> {
  factory $LaundryServiceListDTOCopyWith(LaundryServiceListDTO value,
          $Res Function(LaundryServiceListDTO) then) =
      _$LaundryServiceListDTOCopyWithImpl<$Res>;
  $Res call(
      {List<LaundryServiceDTO> data, PaginationLinks? links, MetaField? meta});

  $PaginationLinksCopyWith<$Res>? get links;
  $MetaFieldCopyWith<$Res>? get meta;
}

/// @nodoc
class _$LaundryServiceListDTOCopyWithImpl<$Res>
    implements $LaundryServiceListDTOCopyWith<$Res> {
  _$LaundryServiceListDTOCopyWithImpl(this._value, this._then);

  final LaundryServiceListDTO _value;
  // ignore: unused_field
  final $Res Function(LaundryServiceListDTO) _then;

  @override
  $Res call({
    Object? data = freezed,
    Object? links = freezed,
    Object? meta = freezed,
  }) {
    return _then(_value.copyWith(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<LaundryServiceDTO>,
      links: links == freezed
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as PaginationLinks?,
      meta: meta == freezed
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as MetaField?,
    ));
  }

  @override
  $PaginationLinksCopyWith<$Res>? get links {
    if (_value.links == null) {
      return null;
    }

    return $PaginationLinksCopyWith<$Res>(_value.links!, (value) {
      return _then(_value.copyWith(links: value));
    });
  }

  @override
  $MetaFieldCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $MetaFieldCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value));
    });
  }
}

/// @nodoc
abstract class _$LaundryServiceListDTOCopyWith<$Res>
    implements $LaundryServiceListDTOCopyWith<$Res> {
  factory _$LaundryServiceListDTOCopyWith(_LaundryServiceListDTO value,
          $Res Function(_LaundryServiceListDTO) then) =
      __$LaundryServiceListDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<LaundryServiceDTO> data, PaginationLinks? links, MetaField? meta});

  @override
  $PaginationLinksCopyWith<$Res>? get links;
  @override
  $MetaFieldCopyWith<$Res>? get meta;
}

/// @nodoc
class __$LaundryServiceListDTOCopyWithImpl<$Res>
    extends _$LaundryServiceListDTOCopyWithImpl<$Res>
    implements _$LaundryServiceListDTOCopyWith<$Res> {
  __$LaundryServiceListDTOCopyWithImpl(_LaundryServiceListDTO _value,
      $Res Function(_LaundryServiceListDTO) _then)
      : super(_value, (v) => _then(v as _LaundryServiceListDTO));

  @override
  _LaundryServiceListDTO get _value => super._value as _LaundryServiceListDTO;

  @override
  $Res call({
    Object? data = freezed,
    Object? links = freezed,
    Object? meta = freezed,
  }) {
    return _then(_LaundryServiceListDTO(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<LaundryServiceDTO>,
      links: links == freezed
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as PaginationLinks?,
      meta: meta == freezed
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as MetaField?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LaundryServiceListDTO extends _LaundryServiceListDTO {
  const _$_LaundryServiceListDTO({this.data = const [], this.links, this.meta})
      : super._();

  factory _$_LaundryServiceListDTO.fromJson(Map<String, dynamic> json) =>
      _$$_LaundryServiceListDTOFromJson(json);

  @JsonKey()
  @override
  final List<LaundryServiceDTO> data;
  @override
  final PaginationLinks? links;
  @override
  final MetaField? meta;

  @override
  String toString() {
    return 'LaundryServiceListDTO(data: $data, links: $links, meta: $meta)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LaundryServiceListDTO &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.links, links) &&
            const DeepCollectionEquality().equals(other.meta, meta));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(links),
      const DeepCollectionEquality().hash(meta));

  @JsonKey(ignore: true)
  @override
  _$LaundryServiceListDTOCopyWith<_LaundryServiceListDTO> get copyWith =>
      __$LaundryServiceListDTOCopyWithImpl<_LaundryServiceListDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LaundryServiceListDTOToJson(this);
  }
}

abstract class _LaundryServiceListDTO extends LaundryServiceListDTO {
  const factory _LaundryServiceListDTO(
      {List<LaundryServiceDTO> data,
      PaginationLinks? links,
      MetaField? meta}) = _$_LaundryServiceListDTO;
  const _LaundryServiceListDTO._() : super._();

  factory _LaundryServiceListDTO.fromJson(Map<String, dynamic> json) =
      _$_LaundryServiceListDTO.fromJson;

  @override
  List<LaundryServiceDTO> get data;
  @override
  PaginationLinks? get links;
  @override
  MetaField? get meta;
  @override
  @JsonKey(ignore: true)
  _$LaundryServiceListDTOCopyWith<_LaundryServiceListDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
