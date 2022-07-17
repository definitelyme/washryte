// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of notification_meta.dart;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NotificationMetaTearOff {
  const _$NotificationMetaTearOff();

  _NotificationRequestMeta order(ServiceRequest? request) {
    return _NotificationRequestMeta(
      request,
    );
  }
}

/// @nodoc
const $NotificationMeta = _$NotificationMetaTearOff();

/// @nodoc
mixin _$NotificationMeta {
  ServiceRequest? get request => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ServiceRequest? request) order,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ServiceRequest? request)? order,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ServiceRequest? request)? order,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotificationRequestMeta value) order,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NotificationRequestMeta value)? order,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotificationRequestMeta value)? order,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NotificationMetaCopyWith<NotificationMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationMetaCopyWith<$Res> {
  factory $NotificationMetaCopyWith(
          NotificationMeta value, $Res Function(NotificationMeta) then) =
      _$NotificationMetaCopyWithImpl<$Res>;
  $Res call({ServiceRequest? request});

  $ServiceRequestCopyWith<$Res>? get request;
}

/// @nodoc
class _$NotificationMetaCopyWithImpl<$Res>
    implements $NotificationMetaCopyWith<$Res> {
  _$NotificationMetaCopyWithImpl(this._value, this._then);

  final NotificationMeta _value;
  // ignore: unused_field
  final $Res Function(NotificationMeta) _then;

  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_value.copyWith(
      request: request == freezed
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as ServiceRequest?,
    ));
  }

  @override
  $ServiceRequestCopyWith<$Res>? get request {
    if (_value.request == null) {
      return null;
    }

    return $ServiceRequestCopyWith<$Res>(_value.request!, (value) {
      return _then(_value.copyWith(request: value));
    });
  }
}

/// @nodoc
abstract class _$NotificationRequestMetaCopyWith<$Res>
    implements $NotificationMetaCopyWith<$Res> {
  factory _$NotificationRequestMetaCopyWith(_NotificationRequestMeta value,
          $Res Function(_NotificationRequestMeta) then) =
      __$NotificationRequestMetaCopyWithImpl<$Res>;
  @override
  $Res call({ServiceRequest? request});

  @override
  $ServiceRequestCopyWith<$Res>? get request;
}

/// @nodoc
class __$NotificationRequestMetaCopyWithImpl<$Res>
    extends _$NotificationMetaCopyWithImpl<$Res>
    implements _$NotificationRequestMetaCopyWith<$Res> {
  __$NotificationRequestMetaCopyWithImpl(_NotificationRequestMeta _value,
      $Res Function(_NotificationRequestMeta) _then)
      : super(_value, (v) => _then(v as _NotificationRequestMeta));

  @override
  _NotificationRequestMeta get _value =>
      super._value as _NotificationRequestMeta;

  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_NotificationRequestMeta(
      request == freezed
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as ServiceRequest?,
    ));
  }
}

/// @nodoc

class _$_NotificationRequestMeta extends _NotificationRequestMeta {
  const _$_NotificationRequestMeta(this.request) : super._();

  @override
  final ServiceRequest? request;

  @override
  String toString() {
    return 'NotificationMeta.order(request: $request)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationRequestMeta &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @JsonKey(ignore: true)
  @override
  _$NotificationRequestMetaCopyWith<_NotificationRequestMeta> get copyWith =>
      __$NotificationRequestMetaCopyWithImpl<_NotificationRequestMeta>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ServiceRequest? request) order,
  }) {
    return order(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ServiceRequest? request)? order,
  }) {
    return order?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ServiceRequest? request)? order,
    required TResult orElse(),
  }) {
    if (order != null) {
      return order(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotificationRequestMeta value) order,
  }) {
    return order(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NotificationRequestMeta value)? order,
  }) {
    return order?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotificationRequestMeta value)? order,
    required TResult orElse(),
  }) {
    if (order != null) {
      return order(this);
    }
    return orElse();
  }
}

abstract class _NotificationRequestMeta extends NotificationMeta {
  const factory _NotificationRequestMeta(ServiceRequest? request) =
      _$_NotificationRequestMeta;
  const _NotificationRequestMeta._() : super._();

  @override
  ServiceRequest? get request;
  @override
  @JsonKey(ignore: true)
  _$NotificationRequestMetaCopyWith<_NotificationRequestMeta> get copyWith =>
      throw _privateConstructorUsedError;
}
