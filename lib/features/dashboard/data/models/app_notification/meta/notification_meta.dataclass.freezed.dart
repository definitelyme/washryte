// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of notification_meta.dataclass.dart;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationMetaDTO _$NotificationMetaDTOFromJson(Map<String, dynamic> json) {
  return _NotificationServiceMeta.fromJson(json);
}

/// @nodoc
class _$NotificationMetaDTOTearOff {
  const _$NotificationMetaDTOTearOff();

  _NotificationServiceMeta service(
      {@NotificationTypeSerializer() required NotificationType type,
      required ServiceRequestDTO order}) {
    return _NotificationServiceMeta(
      type: type,
      order: order,
    );
  }

  NotificationMetaDTO fromJson(Map<String, Object?> json) {
    return NotificationMetaDTO.fromJson(json);
  }
}

/// @nodoc
const $NotificationMetaDTO = _$NotificationMetaDTOTearOff();

/// @nodoc
mixin _$NotificationMetaDTO {
  @NotificationTypeSerializer()
  NotificationType get type => throw _privateConstructorUsedError;
  ServiceRequestDTO get order => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @NotificationTypeSerializer() NotificationType type,
            ServiceRequestDTO order)
        service,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(@NotificationTypeSerializer() NotificationType type,
            ServiceRequestDTO order)?
        service,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(@NotificationTypeSerializer() NotificationType type,
            ServiceRequestDTO order)?
        service,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotificationServiceMeta value) service,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NotificationServiceMeta value)? service,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotificationServiceMeta value)? service,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationMetaDTOCopyWith<NotificationMetaDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationMetaDTOCopyWith<$Res> {
  factory $NotificationMetaDTOCopyWith(
          NotificationMetaDTO value, $Res Function(NotificationMetaDTO) then) =
      _$NotificationMetaDTOCopyWithImpl<$Res>;
  $Res call(
      {@NotificationTypeSerializer() NotificationType type,
      ServiceRequestDTO order});

  $ServiceRequestDTOCopyWith<$Res> get order;
}

/// @nodoc
class _$NotificationMetaDTOCopyWithImpl<$Res>
    implements $NotificationMetaDTOCopyWith<$Res> {
  _$NotificationMetaDTOCopyWithImpl(this._value, this._then);

  final NotificationMetaDTO _value;
  // ignore: unused_field
  final $Res Function(NotificationMetaDTO) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? order = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      order: order == freezed
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as ServiceRequestDTO,
    ));
  }

  @override
  $ServiceRequestDTOCopyWith<$Res> get order {
    return $ServiceRequestDTOCopyWith<$Res>(_value.order, (value) {
      return _then(_value.copyWith(order: value));
    });
  }
}

/// @nodoc
abstract class _$NotificationServiceMetaCopyWith<$Res>
    implements $NotificationMetaDTOCopyWith<$Res> {
  factory _$NotificationServiceMetaCopyWith(_NotificationServiceMeta value,
          $Res Function(_NotificationServiceMeta) then) =
      __$NotificationServiceMetaCopyWithImpl<$Res>;
  @override
  $Res call(
      {@NotificationTypeSerializer() NotificationType type,
      ServiceRequestDTO order});

  @override
  $ServiceRequestDTOCopyWith<$Res> get order;
}

/// @nodoc
class __$NotificationServiceMetaCopyWithImpl<$Res>
    extends _$NotificationMetaDTOCopyWithImpl<$Res>
    implements _$NotificationServiceMetaCopyWith<$Res> {
  __$NotificationServiceMetaCopyWithImpl(_NotificationServiceMeta _value,
      $Res Function(_NotificationServiceMeta) _then)
      : super(_value, (v) => _then(v as _NotificationServiceMeta));

  @override
  _NotificationServiceMeta get _value =>
      super._value as _NotificationServiceMeta;

  @override
  $Res call({
    Object? type = freezed,
    Object? order = freezed,
  }) {
    return _then(_NotificationServiceMeta(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      order: order == freezed
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as ServiceRequestDTO,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('${NotificationType.service_request}')
class _$_NotificationServiceMeta extends _NotificationServiceMeta {
  const _$_NotificationServiceMeta(
      {@NotificationTypeSerializer() required this.type, required this.order})
      : super._();

  factory _$_NotificationServiceMeta.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationServiceMetaFromJson(json);

  @override
  @NotificationTypeSerializer()
  final NotificationType type;
  @override
  final ServiceRequestDTO order;

  @override
  String toString() {
    return 'NotificationMetaDTO.service(type: $type, order: $order)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationServiceMeta &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.order, order));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(order));

  @JsonKey(ignore: true)
  @override
  _$NotificationServiceMetaCopyWith<_NotificationServiceMeta> get copyWith =>
      __$NotificationServiceMetaCopyWithImpl<_NotificationServiceMeta>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @NotificationTypeSerializer() NotificationType type,
            ServiceRequestDTO order)
        service,
  }) {
    return service(type, order);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(@NotificationTypeSerializer() NotificationType type,
            ServiceRequestDTO order)?
        service,
  }) {
    return service?.call(type, order);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(@NotificationTypeSerializer() NotificationType type,
            ServiceRequestDTO order)?
        service,
    required TResult orElse(),
  }) {
    if (service != null) {
      return service(type, order);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotificationServiceMeta value) service,
  }) {
    return service(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NotificationServiceMeta value)? service,
  }) {
    return service?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotificationServiceMeta value)? service,
    required TResult orElse(),
  }) {
    if (service != null) {
      return service(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationServiceMetaToJson(this);
  }
}

abstract class _NotificationServiceMeta extends NotificationMetaDTO {
  const factory _NotificationServiceMeta(
      {@NotificationTypeSerializer() required NotificationType type,
      required ServiceRequestDTO order}) = _$_NotificationServiceMeta;
  const _NotificationServiceMeta._() : super._();

  factory _NotificationServiceMeta.fromJson(Map<String, dynamic> json) =
      _$_NotificationServiceMeta.fromJson;

  @override
  @NotificationTypeSerializer()
  NotificationType get type;
  @override
  ServiceRequestDTO get order;
  @override
  @JsonKey(ignore: true)
  _$NotificationServiceMetaCopyWith<_NotificationServiceMeta> get copyWith =>
      throw _privateConstructorUsedError;
}
