// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of laundry_service.dart;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LaundryServiceTearOff {
  const _$LaundryServiceTearOff();

  _LaundryService call(
      {required UniqueId<String?> id,
      required BasicTextField<String?> name,
      required AmountField<int> quantity,
      required AmountField<double> price,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return _LaundryService(
      id: id,
      name: name,
      quantity: quantity,
      price: price,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// @nodoc
const $LaundryService = _$LaundryServiceTearOff();

/// @nodoc
mixin _$LaundryService {
  UniqueId<String?> get id => throw _privateConstructorUsedError;
  BasicTextField<String?> get name => throw _privateConstructorUsedError;
  AmountField<int> get quantity => throw _privateConstructorUsedError;
  AmountField<double> get price => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LaundryServiceCopyWith<LaundryService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaundryServiceCopyWith<$Res> {
  factory $LaundryServiceCopyWith(
          LaundryService value, $Res Function(LaundryService) then) =
      _$LaundryServiceCopyWithImpl<$Res>;
  $Res call(
      {UniqueId<String?> id,
      BasicTextField<String?> name,
      AmountField<int> quantity,
      AmountField<double> price,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$LaundryServiceCopyWithImpl<$Res>
    implements $LaundryServiceCopyWith<$Res> {
  _$LaundryServiceCopyWithImpl(this._value, this._then);

  final LaundryService _value;
  // ignore: unused_field
  final $Res Function(LaundryService) _then;

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
              as UniqueId<String?>,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as BasicTextField<String?>,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as AmountField<int>,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as AmountField<double>,
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
abstract class _$LaundryServiceCopyWith<$Res>
    implements $LaundryServiceCopyWith<$Res> {
  factory _$LaundryServiceCopyWith(
          _LaundryService value, $Res Function(_LaundryService) then) =
      __$LaundryServiceCopyWithImpl<$Res>;
  @override
  $Res call(
      {UniqueId<String?> id,
      BasicTextField<String?> name,
      AmountField<int> quantity,
      AmountField<double> price,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$LaundryServiceCopyWithImpl<$Res>
    extends _$LaundryServiceCopyWithImpl<$Res>
    implements _$LaundryServiceCopyWith<$Res> {
  __$LaundryServiceCopyWithImpl(
      _LaundryService _value, $Res Function(_LaundryService) _then)
      : super(_value, (v) => _then(v as _LaundryService));

  @override
  _LaundryService get _value => super._value as _LaundryService;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_LaundryService(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UniqueId<String?>,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as BasicTextField<String?>,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as AmountField<int>,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as AmountField<double>,
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

class _$_LaundryService extends _LaundryService {
  const _$_LaundryService(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.price,
      this.createdAt,
      this.updatedAt})
      : super._();

  @override
  final UniqueId<String?> id;
  @override
  final BasicTextField<String?> name;
  @override
  final AmountField<int> quantity;
  @override
  final AmountField<double> price;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'LaundryService(id: $id, name: $name, quantity: $quantity, price: $price, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LaundryService &&
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
  _$LaundryServiceCopyWith<_LaundryService> get copyWith =>
      __$LaundryServiceCopyWithImpl<_LaundryService>(this, _$identity);
}

abstract class _LaundryService extends LaundryService {
  const factory _LaundryService(
      {required UniqueId<String?> id,
      required BasicTextField<String?> name,
      required AmountField<int> quantity,
      required AmountField<double> price,
      DateTime? createdAt,
      DateTime? updatedAt}) = _$_LaundryService;
  const _LaundryService._() : super._();

  @override
  UniqueId<String?> get id;
  @override
  BasicTextField<String?> get name;
  @override
  AmountField<int> get quantity;
  @override
  AmountField<double> get price;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$LaundryServiceCopyWith<_LaundryService> get copyWith =>
      throw _privateConstructorUsedError;
}
