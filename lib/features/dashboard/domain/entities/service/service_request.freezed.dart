// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of service_request.dart;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ServiceRequestTearOff {
  const _$ServiceRequestTearOff();

  _ServiceRequest call(
      {required UniqueId<String?> id,
      required UniqueId<String?> customerId,
      ServiceType type = ServiceType.pickup,
      PaymentMethod paymentMethod = PaymentMethod.PENDING,
      OrderStatus status = OrderStatus.pending,
      required AmountField<double> amount,
      required BasicTextField<String?> items,
      required BasicTextField<String?> address,
      required BasicTextField<String?> reference,
      KtList<LaundryService> services = const KtList.empty(),
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return _ServiceRequest(
      id: id,
      customerId: customerId,
      type: type,
      paymentMethod: paymentMethod,
      status: status,
      amount: amount,
      items: items,
      address: address,
      reference: reference,
      services: services,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// @nodoc
const $ServiceRequest = _$ServiceRequestTearOff();

/// @nodoc
mixin _$ServiceRequest {
  UniqueId<String?> get id => throw _privateConstructorUsedError;
  UniqueId<String?> get customerId => throw _privateConstructorUsedError;
  ServiceType get type => throw _privateConstructorUsedError;
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  OrderStatus get status => throw _privateConstructorUsedError;
  AmountField<double> get amount => throw _privateConstructorUsedError;
  BasicTextField<String?> get items => throw _privateConstructorUsedError;
  BasicTextField<String?> get address => throw _privateConstructorUsedError;
  BasicTextField<String?> get reference => throw _privateConstructorUsedError;
  KtList<LaundryService> get services => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ServiceRequestCopyWith<ServiceRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceRequestCopyWith<$Res> {
  factory $ServiceRequestCopyWith(
          ServiceRequest value, $Res Function(ServiceRequest) then) =
      _$ServiceRequestCopyWithImpl<$Res>;
  $Res call(
      {UniqueId<String?> id,
      UniqueId<String?> customerId,
      ServiceType type,
      PaymentMethod paymentMethod,
      OrderStatus status,
      AmountField<double> amount,
      BasicTextField<String?> items,
      BasicTextField<String?> address,
      BasicTextField<String?> reference,
      KtList<LaundryService> services,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$ServiceRequestCopyWithImpl<$Res>
    implements $ServiceRequestCopyWith<$Res> {
  _$ServiceRequestCopyWithImpl(this._value, this._then);

  final ServiceRequest _value;
  // ignore: unused_field
  final $Res Function(ServiceRequest) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? customerId = freezed,
    Object? type = freezed,
    Object? paymentMethod = freezed,
    Object? status = freezed,
    Object? amount = freezed,
    Object? items = freezed,
    Object? address = freezed,
    Object? reference = freezed,
    Object? services = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UniqueId<String?>,
      customerId: customerId == freezed
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as UniqueId<String?>,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ServiceType,
      paymentMethod: paymentMethod == freezed
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as AmountField<double>,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as BasicTextField<String?>,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as BasicTextField<String?>,
      reference: reference == freezed
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as BasicTextField<String?>,
      services: services == freezed
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as KtList<LaundryService>,
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
abstract class _$ServiceRequestCopyWith<$Res>
    implements $ServiceRequestCopyWith<$Res> {
  factory _$ServiceRequestCopyWith(
          _ServiceRequest value, $Res Function(_ServiceRequest) then) =
      __$ServiceRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {UniqueId<String?> id,
      UniqueId<String?> customerId,
      ServiceType type,
      PaymentMethod paymentMethod,
      OrderStatus status,
      AmountField<double> amount,
      BasicTextField<String?> items,
      BasicTextField<String?> address,
      BasicTextField<String?> reference,
      KtList<LaundryService> services,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$ServiceRequestCopyWithImpl<$Res>
    extends _$ServiceRequestCopyWithImpl<$Res>
    implements _$ServiceRequestCopyWith<$Res> {
  __$ServiceRequestCopyWithImpl(
      _ServiceRequest _value, $Res Function(_ServiceRequest) _then)
      : super(_value, (v) => _then(v as _ServiceRequest));

  @override
  _ServiceRequest get _value => super._value as _ServiceRequest;

  @override
  $Res call({
    Object? id = freezed,
    Object? customerId = freezed,
    Object? type = freezed,
    Object? paymentMethod = freezed,
    Object? status = freezed,
    Object? amount = freezed,
    Object? items = freezed,
    Object? address = freezed,
    Object? reference = freezed,
    Object? services = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_ServiceRequest(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UniqueId<String?>,
      customerId: customerId == freezed
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as UniqueId<String?>,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ServiceType,
      paymentMethod: paymentMethod == freezed
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as AmountField<double>,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as BasicTextField<String?>,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as BasicTextField<String?>,
      reference: reference == freezed
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as BasicTextField<String?>,
      services: services == freezed
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as KtList<LaundryService>,
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

class _$_ServiceRequest extends _ServiceRequest {
  const _$_ServiceRequest(
      {required this.id,
      required this.customerId,
      this.type = ServiceType.pickup,
      this.paymentMethod = PaymentMethod.PENDING,
      this.status = OrderStatus.pending,
      required this.amount,
      required this.items,
      required this.address,
      required this.reference,
      this.services = const KtList.empty(),
      this.createdAt,
      this.updatedAt})
      : super._();

  @override
  final UniqueId<String?> id;
  @override
  final UniqueId<String?> customerId;
  @JsonKey()
  @override
  final ServiceType type;
  @JsonKey()
  @override
  final PaymentMethod paymentMethod;
  @JsonKey()
  @override
  final OrderStatus status;
  @override
  final AmountField<double> amount;
  @override
  final BasicTextField<String?> items;
  @override
  final BasicTextField<String?> address;
  @override
  final BasicTextField<String?> reference;
  @JsonKey()
  @override
  final KtList<LaundryService> services;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ServiceRequest(id: $id, customerId: $customerId, type: $type, paymentMethod: $paymentMethod, status: $status, amount: $amount, items: $items, address: $address, reference: $reference, services: $services, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServiceRequest &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.customerId, customerId) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.paymentMethod, paymentMethod) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.reference, reference) &&
            const DeepCollectionEquality().equals(other.services, services) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(customerId),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(paymentMethod),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(items),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(reference),
      const DeepCollectionEquality().hash(services),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$ServiceRequestCopyWith<_ServiceRequest> get copyWith =>
      __$ServiceRequestCopyWithImpl<_ServiceRequest>(this, _$identity);
}

abstract class _ServiceRequest extends ServiceRequest {
  const factory _ServiceRequest(
      {required UniqueId<String?> id,
      required UniqueId<String?> customerId,
      ServiceType type,
      PaymentMethod paymentMethod,
      OrderStatus status,
      required AmountField<double> amount,
      required BasicTextField<String?> items,
      required BasicTextField<String?> address,
      required BasicTextField<String?> reference,
      KtList<LaundryService> services,
      DateTime? createdAt,
      DateTime? updatedAt}) = _$_ServiceRequest;
  const _ServiceRequest._() : super._();

  @override
  UniqueId<String?> get id;
  @override
  UniqueId<String?> get customerId;
  @override
  ServiceType get type;
  @override
  PaymentMethod get paymentMethod;
  @override
  OrderStatus get status;
  @override
  AmountField<double> get amount;
  @override
  BasicTextField<String?> get items;
  @override
  BasicTextField<String?> get address;
  @override
  BasicTextField<String?> get reference;
  @override
  KtList<LaundryService> get services;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$ServiceRequestCopyWith<_ServiceRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
