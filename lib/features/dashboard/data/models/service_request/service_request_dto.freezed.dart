// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of service_request_dto.dart;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ServiceRequestDTO _$ServiceRequestDTOFromJson(Map<String, dynamic> json) {
  return _ServiceRequestDTO.fromJson(json);
}

/// @nodoc
class _$ServiceRequestDTOTearOff {
  const _$ServiceRequestDTOTearOff();

  _ServiceRequestDTO call(
      {@StringSerializer() String? id,
      @StringSerializer() String? customerId,
      String? items,
      String? address,
      String? reference,
      @DoubleSerializer() double? price,
      @DoubleSerializer() double? amount,
      @ServiceTypeSerializer() ServiceType? serviceType,
      @PaymentMethodSerializer() PaymentMethod? paymentMethod,
      @OrderStatusSerializer() OrderStatus? status,
      List<LaundryServiceDTO> services = const [],
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      ServiceRequestDTO? data}) {
    return _ServiceRequestDTO(
      id: id,
      customerId: customerId,
      items: items,
      address: address,
      reference: reference,
      price: price,
      amount: amount,
      serviceType: serviceType,
      paymentMethod: paymentMethod,
      status: status,
      services: services,
      createdAt: createdAt,
      updatedAt: updatedAt,
      data: data,
    );
  }

  ServiceRequestDTO fromJson(Map<String, Object?> json) {
    return ServiceRequestDTO.fromJson(json);
  }
}

/// @nodoc
const $ServiceRequestDTO = _$ServiceRequestDTOTearOff();

/// @nodoc
mixin _$ServiceRequestDTO {
  @StringSerializer()
  String? get id => throw _privateConstructorUsedError;
  @StringSerializer()
  String? get customerId => throw _privateConstructorUsedError;
  String? get items => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;
  @DoubleSerializer()
  double? get price => throw _privateConstructorUsedError;
  @DoubleSerializer()
  double? get amount => throw _privateConstructorUsedError;
  @ServiceTypeSerializer()
  ServiceType? get serviceType => throw _privateConstructorUsedError;
  @PaymentMethodSerializer()
  PaymentMethod? get paymentMethod => throw _privateConstructorUsedError;
  @OrderStatusSerializer()
  OrderStatus? get status => throw _privateConstructorUsedError;
  List<LaundryServiceDTO> get services => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError; //
  ServiceRequestDTO? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceRequestDTOCopyWith<ServiceRequestDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceRequestDTOCopyWith<$Res> {
  factory $ServiceRequestDTOCopyWith(
          ServiceRequestDTO value, $Res Function(ServiceRequestDTO) then) =
      _$ServiceRequestDTOCopyWithImpl<$Res>;
  $Res call(
      {@StringSerializer() String? id,
      @StringSerializer() String? customerId,
      String? items,
      String? address,
      String? reference,
      @DoubleSerializer() double? price,
      @DoubleSerializer() double? amount,
      @ServiceTypeSerializer() ServiceType? serviceType,
      @PaymentMethodSerializer() PaymentMethod? paymentMethod,
      @OrderStatusSerializer() OrderStatus? status,
      List<LaundryServiceDTO> services,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      ServiceRequestDTO? data});

  $ServiceRequestDTOCopyWith<$Res>? get data;
}

/// @nodoc
class _$ServiceRequestDTOCopyWithImpl<$Res>
    implements $ServiceRequestDTOCopyWith<$Res> {
  _$ServiceRequestDTOCopyWithImpl(this._value, this._then);

  final ServiceRequestDTO _value;
  // ignore: unused_field
  final $Res Function(ServiceRequestDTO) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? customerId = freezed,
    Object? items = freezed,
    Object? address = freezed,
    Object? reference = freezed,
    Object? price = freezed,
    Object? amount = freezed,
    Object? serviceType = freezed,
    Object? paymentMethod = freezed,
    Object? status = freezed,
    Object? services = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: customerId == freezed
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as String?,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      reference: reference == freezed
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      serviceType: serviceType == freezed
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as ServiceType?,
      paymentMethod: paymentMethod == freezed
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus?,
      services: services == freezed
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<LaundryServiceDTO>,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ServiceRequestDTO?,
    ));
  }

  @override
  $ServiceRequestDTOCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $ServiceRequestDTOCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value));
    });
  }
}

/// @nodoc
abstract class _$ServiceRequestDTOCopyWith<$Res>
    implements $ServiceRequestDTOCopyWith<$Res> {
  factory _$ServiceRequestDTOCopyWith(
          _ServiceRequestDTO value, $Res Function(_ServiceRequestDTO) then) =
      __$ServiceRequestDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {@StringSerializer() String? id,
      @StringSerializer() String? customerId,
      String? items,
      String? address,
      String? reference,
      @DoubleSerializer() double? price,
      @DoubleSerializer() double? amount,
      @ServiceTypeSerializer() ServiceType? serviceType,
      @PaymentMethodSerializer() PaymentMethod? paymentMethod,
      @OrderStatusSerializer() OrderStatus? status,
      List<LaundryServiceDTO> services,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      ServiceRequestDTO? data});

  @override
  $ServiceRequestDTOCopyWith<$Res>? get data;
}

/// @nodoc
class __$ServiceRequestDTOCopyWithImpl<$Res>
    extends _$ServiceRequestDTOCopyWithImpl<$Res>
    implements _$ServiceRequestDTOCopyWith<$Res> {
  __$ServiceRequestDTOCopyWithImpl(
      _ServiceRequestDTO _value, $Res Function(_ServiceRequestDTO) _then)
      : super(_value, (v) => _then(v as _ServiceRequestDTO));

  @override
  _ServiceRequestDTO get _value => super._value as _ServiceRequestDTO;

  @override
  $Res call({
    Object? id = freezed,
    Object? customerId = freezed,
    Object? items = freezed,
    Object? address = freezed,
    Object? reference = freezed,
    Object? price = freezed,
    Object? amount = freezed,
    Object? serviceType = freezed,
    Object? paymentMethod = freezed,
    Object? status = freezed,
    Object? services = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? data = freezed,
  }) {
    return _then(_ServiceRequestDTO(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: customerId == freezed
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as String?,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      reference: reference == freezed
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      serviceType: serviceType == freezed
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as ServiceType?,
      paymentMethod: paymentMethod == freezed
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus?,
      services: services == freezed
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<LaundryServiceDTO>,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ServiceRequestDTO?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ServiceRequestDTO extends _ServiceRequestDTO {
  const _$_ServiceRequestDTO(
      {@StringSerializer() this.id,
      @StringSerializer() this.customerId,
      this.items,
      this.address,
      this.reference,
      @DoubleSerializer() this.price,
      @DoubleSerializer() this.amount,
      @ServiceTypeSerializer() this.serviceType,
      @PaymentMethodSerializer() this.paymentMethod,
      @OrderStatusSerializer() this.status,
      this.services = const [],
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt,
      this.data})
      : super._();

  factory _$_ServiceRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$$_ServiceRequestDTOFromJson(json);

  @override
  @StringSerializer()
  final String? id;
  @override
  @StringSerializer()
  final String? customerId;
  @override
  final String? items;
  @override
  final String? address;
  @override
  final String? reference;
  @override
  @DoubleSerializer()
  final double? price;
  @override
  @DoubleSerializer()
  final double? amount;
  @override
  @ServiceTypeSerializer()
  final ServiceType? serviceType;
  @override
  @PaymentMethodSerializer()
  final PaymentMethod? paymentMethod;
  @override
  @OrderStatusSerializer()
  final OrderStatus? status;
  @JsonKey()
  @override
  final List<LaundryServiceDTO> services;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;
  @override //
  final ServiceRequestDTO? data;

  @override
  String toString() {
    return 'ServiceRequestDTO(id: $id, customerId: $customerId, items: $items, address: $address, reference: $reference, price: $price, amount: $amount, serviceType: $serviceType, paymentMethod: $paymentMethod, status: $status, services: $services, createdAt: $createdAt, updatedAt: $updatedAt, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServiceRequestDTO &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.customerId, customerId) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.reference, reference) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality()
                .equals(other.serviceType, serviceType) &&
            const DeepCollectionEquality()
                .equals(other.paymentMethod, paymentMethod) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.services, services) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(customerId),
      const DeepCollectionEquality().hash(items),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(reference),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(serviceType),
      const DeepCollectionEquality().hash(paymentMethod),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(services),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$ServiceRequestDTOCopyWith<_ServiceRequestDTO> get copyWith =>
      __$ServiceRequestDTOCopyWithImpl<_ServiceRequestDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ServiceRequestDTOToJson(this);
  }
}

abstract class _ServiceRequestDTO extends ServiceRequestDTO {
  const factory _ServiceRequestDTO(
      {@StringSerializer() String? id,
      @StringSerializer() String? customerId,
      String? items,
      String? address,
      String? reference,
      @DoubleSerializer() double? price,
      @DoubleSerializer() double? amount,
      @ServiceTypeSerializer() ServiceType? serviceType,
      @PaymentMethodSerializer() PaymentMethod? paymentMethod,
      @OrderStatusSerializer() OrderStatus? status,
      List<LaundryServiceDTO> services,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      ServiceRequestDTO? data}) = _$_ServiceRequestDTO;
  const _ServiceRequestDTO._() : super._();

  factory _ServiceRequestDTO.fromJson(Map<String, dynamic> json) =
      _$_ServiceRequestDTO.fromJson;

  @override
  @StringSerializer()
  String? get id;
  @override
  @StringSerializer()
  String? get customerId;
  @override
  String? get items;
  @override
  String? get address;
  @override
  String? get reference;
  @override
  @DoubleSerializer()
  double? get price;
  @override
  @DoubleSerializer()
  double? get amount;
  @override
  @ServiceTypeSerializer()
  ServiceType? get serviceType;
  @override
  @PaymentMethodSerializer()
  PaymentMethod? get paymentMethod;
  @override
  @OrderStatusSerializer()
  OrderStatus? get status;
  @override
  List<LaundryServiceDTO> get services;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override //
  ServiceRequestDTO? get data;
  @override
  @JsonKey(ignore: true)
  _$ServiceRequestDTOCopyWith<_ServiceRequestDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceRequestListDTO _$ServiceRequestListDTOFromJson(
    Map<String, dynamic> json) {
  return _ServiceRequestListDTO.fromJson(json);
}

/// @nodoc
class _$ServiceRequestListDTOTearOff {
  const _$ServiceRequestListDTOTearOff();

  _ServiceRequestListDTO call(
      {List<ServiceRequestDTO> data = const [],
      PaginationLinks? links,
      MetaField? meta}) {
    return _ServiceRequestListDTO(
      data: data,
      links: links,
      meta: meta,
    );
  }

  ServiceRequestListDTO fromJson(Map<String, Object?> json) {
    return ServiceRequestListDTO.fromJson(json);
  }
}

/// @nodoc
const $ServiceRequestListDTO = _$ServiceRequestListDTOTearOff();

/// @nodoc
mixin _$ServiceRequestListDTO {
  List<ServiceRequestDTO> get data => throw _privateConstructorUsedError;
  PaginationLinks? get links => throw _privateConstructorUsedError;
  MetaField? get meta => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceRequestListDTOCopyWith<ServiceRequestListDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceRequestListDTOCopyWith<$Res> {
  factory $ServiceRequestListDTOCopyWith(ServiceRequestListDTO value,
          $Res Function(ServiceRequestListDTO) then) =
      _$ServiceRequestListDTOCopyWithImpl<$Res>;
  $Res call(
      {List<ServiceRequestDTO> data, PaginationLinks? links, MetaField? meta});

  $PaginationLinksCopyWith<$Res>? get links;
  $MetaFieldCopyWith<$Res>? get meta;
}

/// @nodoc
class _$ServiceRequestListDTOCopyWithImpl<$Res>
    implements $ServiceRequestListDTOCopyWith<$Res> {
  _$ServiceRequestListDTOCopyWithImpl(this._value, this._then);

  final ServiceRequestListDTO _value;
  // ignore: unused_field
  final $Res Function(ServiceRequestListDTO) _then;

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
              as List<ServiceRequestDTO>,
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
abstract class _$ServiceRequestListDTOCopyWith<$Res>
    implements $ServiceRequestListDTOCopyWith<$Res> {
  factory _$ServiceRequestListDTOCopyWith(_ServiceRequestListDTO value,
          $Res Function(_ServiceRequestListDTO) then) =
      __$ServiceRequestListDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<ServiceRequestDTO> data, PaginationLinks? links, MetaField? meta});

  @override
  $PaginationLinksCopyWith<$Res>? get links;
  @override
  $MetaFieldCopyWith<$Res>? get meta;
}

/// @nodoc
class __$ServiceRequestListDTOCopyWithImpl<$Res>
    extends _$ServiceRequestListDTOCopyWithImpl<$Res>
    implements _$ServiceRequestListDTOCopyWith<$Res> {
  __$ServiceRequestListDTOCopyWithImpl(_ServiceRequestListDTO _value,
      $Res Function(_ServiceRequestListDTO) _then)
      : super(_value, (v) => _then(v as _ServiceRequestListDTO));

  @override
  _ServiceRequestListDTO get _value => super._value as _ServiceRequestListDTO;

  @override
  $Res call({
    Object? data = freezed,
    Object? links = freezed,
    Object? meta = freezed,
  }) {
    return _then(_ServiceRequestListDTO(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ServiceRequestDTO>,
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
class _$_ServiceRequestListDTO extends _ServiceRequestListDTO {
  const _$_ServiceRequestListDTO({this.data = const [], this.links, this.meta})
      : super._();

  factory _$_ServiceRequestListDTO.fromJson(Map<String, dynamic> json) =>
      _$$_ServiceRequestListDTOFromJson(json);

  @JsonKey()
  @override
  final List<ServiceRequestDTO> data;
  @override
  final PaginationLinks? links;
  @override
  final MetaField? meta;

  @override
  String toString() {
    return 'ServiceRequestListDTO(data: $data, links: $links, meta: $meta)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServiceRequestListDTO &&
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
  _$ServiceRequestListDTOCopyWith<_ServiceRequestListDTO> get copyWith =>
      __$ServiceRequestListDTOCopyWithImpl<_ServiceRequestListDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ServiceRequestListDTOToJson(this);
  }
}

abstract class _ServiceRequestListDTO extends ServiceRequestListDTO {
  const factory _ServiceRequestListDTO(
      {List<ServiceRequestDTO> data,
      PaginationLinks? links,
      MetaField? meta}) = _$_ServiceRequestListDTO;
  const _ServiceRequestListDTO._() : super._();

  factory _ServiceRequestListDTO.fromJson(Map<String, dynamic> json) =
      _$_ServiceRequestListDTO.fromJson;

  @override
  List<ServiceRequestDTO> get data;
  @override
  PaginationLinks? get links;
  @override
  MetaField? get meta;
  @override
  @JsonKey(ignore: true)
  _$ServiceRequestListDTOCopyWith<_ServiceRequestListDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
