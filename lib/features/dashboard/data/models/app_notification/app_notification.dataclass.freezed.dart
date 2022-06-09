// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of app_notification.dataclass.dart;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppNotificationDTO _$AppNotificationDTOFromJson(Map<String, dynamic> json) {
  return _AppNotificationDTO.fromJson(json);
}

/// @nodoc
class _$AppNotificationDTOTearOff {
  const _$AppNotificationDTOTearOff();

  _AppNotificationDTO call(
      {@StringSerializer() String? id,
      String? title,
      String? message,
      NotificationMetaDTO? meta,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      @TimestampConverter() DateTime? deletedAt}) {
    return _AppNotificationDTO(
      id: id,
      title: title,
      message: message,
      meta: meta,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }

  AppNotificationDTO fromJson(Map<String, Object?> json) {
    return AppNotificationDTO.fromJson(json);
  }
}

/// @nodoc
const $AppNotificationDTO = _$AppNotificationDTOTearOff();

/// @nodoc
mixin _$AppNotificationDTO {
  @StringSerializer()
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  NotificationMetaDTO? get meta => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppNotificationDTOCopyWith<AppNotificationDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNotificationDTOCopyWith<$Res> {
  factory $AppNotificationDTOCopyWith(
          AppNotificationDTO value, $Res Function(AppNotificationDTO) then) =
      _$AppNotificationDTOCopyWithImpl<$Res>;
  $Res call(
      {@StringSerializer() String? id,
      String? title,
      String? message,
      NotificationMetaDTO? meta,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      @TimestampConverter() DateTime? deletedAt});

  $NotificationMetaDTOCopyWith<$Res>? get meta;
}

/// @nodoc
class _$AppNotificationDTOCopyWithImpl<$Res>
    implements $AppNotificationDTOCopyWith<$Res> {
  _$AppNotificationDTOCopyWithImpl(this._value, this._then);

  final AppNotificationDTO _value;
  // ignore: unused_field
  final $Res Function(AppNotificationDTO) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? message = freezed,
    Object? meta = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      meta: meta == freezed
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as NotificationMetaDTO?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: deletedAt == freezed
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  @override
  $NotificationMetaDTOCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $NotificationMetaDTOCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value));
    });
  }
}

/// @nodoc
abstract class _$AppNotificationDTOCopyWith<$Res>
    implements $AppNotificationDTOCopyWith<$Res> {
  factory _$AppNotificationDTOCopyWith(
          _AppNotificationDTO value, $Res Function(_AppNotificationDTO) then) =
      __$AppNotificationDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {@StringSerializer() String? id,
      String? title,
      String? message,
      NotificationMetaDTO? meta,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      @TimestampConverter() DateTime? deletedAt});

  @override
  $NotificationMetaDTOCopyWith<$Res>? get meta;
}

/// @nodoc
class __$AppNotificationDTOCopyWithImpl<$Res>
    extends _$AppNotificationDTOCopyWithImpl<$Res>
    implements _$AppNotificationDTOCopyWith<$Res> {
  __$AppNotificationDTOCopyWithImpl(
      _AppNotificationDTO _value, $Res Function(_AppNotificationDTO) _then)
      : super(_value, (v) => _then(v as _AppNotificationDTO));

  @override
  _AppNotificationDTO get _value => super._value as _AppNotificationDTO;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? message = freezed,
    Object? meta = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_AppNotificationDTO(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      meta: meta == freezed
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as NotificationMetaDTO?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: deletedAt == freezed
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppNotificationDTO extends _AppNotificationDTO {
  const _$_AppNotificationDTO(
      {@StringSerializer() this.id,
      this.title,
      this.message,
      this.meta,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt,
      @TimestampConverter() this.deletedAt})
      : super._();

  factory _$_AppNotificationDTO.fromJson(Map<String, dynamic> json) =>
      _$$_AppNotificationDTOFromJson(json);

  @override
  @StringSerializer()
  final String? id;
  @override
  final String? title;
  @override
  final String? message;
  @override
  final NotificationMetaDTO? meta;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;
  @override
  @TimestampConverter()
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'AppNotificationDTO(id: $id, title: $title, message: $message, meta: $meta, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppNotificationDTO &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.meta, meta) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other.deletedAt, deletedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(meta),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(deletedAt));

  @JsonKey(ignore: true)
  @override
  _$AppNotificationDTOCopyWith<_AppNotificationDTO> get copyWith =>
      __$AppNotificationDTOCopyWithImpl<_AppNotificationDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppNotificationDTOToJson(this);
  }
}

abstract class _AppNotificationDTO extends AppNotificationDTO {
  const factory _AppNotificationDTO(
      {@StringSerializer() String? id,
      String? title,
      String? message,
      NotificationMetaDTO? meta,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      @TimestampConverter() DateTime? deletedAt}) = _$_AppNotificationDTO;
  const _AppNotificationDTO._() : super._();

  factory _AppNotificationDTO.fromJson(Map<String, dynamic> json) =
      _$_AppNotificationDTO.fromJson;

  @override
  @StringSerializer()
  String? get id;
  @override
  String? get title;
  @override
  String? get message;
  @override
  NotificationMetaDTO? get meta;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @TimestampConverter()
  DateTime? get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$AppNotificationDTOCopyWith<_AppNotificationDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

AppNotificationListDTO _$AppNotificationListDTOFromJson(
    Map<String, dynamic> json) {
  return _AppNotificationListDTO.fromJson(json);
}

/// @nodoc
class _$AppNotificationListDTOTearOff {
  const _$AppNotificationListDTOTearOff();

  _AppNotificationListDTO call(
      {List<AppNotificationDTO> data = const [],
      PaginationLinks? links,
      MetaField? meta}) {
    return _AppNotificationListDTO(
      data: data,
      links: links,
      meta: meta,
    );
  }

  AppNotificationListDTO fromJson(Map<String, Object?> json) {
    return AppNotificationListDTO.fromJson(json);
  }
}

/// @nodoc
const $AppNotificationListDTO = _$AppNotificationListDTOTearOff();

/// @nodoc
mixin _$AppNotificationListDTO {
  List<AppNotificationDTO> get data => throw _privateConstructorUsedError;
  PaginationLinks? get links => throw _privateConstructorUsedError;
  MetaField? get meta => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppNotificationListDTOCopyWith<AppNotificationListDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNotificationListDTOCopyWith<$Res> {
  factory $AppNotificationListDTOCopyWith(AppNotificationListDTO value,
          $Res Function(AppNotificationListDTO) then) =
      _$AppNotificationListDTOCopyWithImpl<$Res>;
  $Res call(
      {List<AppNotificationDTO> data, PaginationLinks? links, MetaField? meta});

  $PaginationLinksCopyWith<$Res>? get links;
  $MetaFieldCopyWith<$Res>? get meta;
}

/// @nodoc
class _$AppNotificationListDTOCopyWithImpl<$Res>
    implements $AppNotificationListDTOCopyWith<$Res> {
  _$AppNotificationListDTOCopyWithImpl(this._value, this._then);

  final AppNotificationListDTO _value;
  // ignore: unused_field
  final $Res Function(AppNotificationListDTO) _then;

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
              as List<AppNotificationDTO>,
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
abstract class _$AppNotificationListDTOCopyWith<$Res>
    implements $AppNotificationListDTOCopyWith<$Res> {
  factory _$AppNotificationListDTOCopyWith(_AppNotificationListDTO value,
          $Res Function(_AppNotificationListDTO) then) =
      __$AppNotificationListDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<AppNotificationDTO> data, PaginationLinks? links, MetaField? meta});

  @override
  $PaginationLinksCopyWith<$Res>? get links;
  @override
  $MetaFieldCopyWith<$Res>? get meta;
}

/// @nodoc
class __$AppNotificationListDTOCopyWithImpl<$Res>
    extends _$AppNotificationListDTOCopyWithImpl<$Res>
    implements _$AppNotificationListDTOCopyWith<$Res> {
  __$AppNotificationListDTOCopyWithImpl(_AppNotificationListDTO _value,
      $Res Function(_AppNotificationListDTO) _then)
      : super(_value, (v) => _then(v as _AppNotificationListDTO));

  @override
  _AppNotificationListDTO get _value => super._value as _AppNotificationListDTO;

  @override
  $Res call({
    Object? data = freezed,
    Object? links = freezed,
    Object? meta = freezed,
  }) {
    return _then(_AppNotificationListDTO(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<AppNotificationDTO>,
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
class _$_AppNotificationListDTO extends _AppNotificationListDTO {
  const _$_AppNotificationListDTO({this.data = const [], this.links, this.meta})
      : super._();

  factory _$_AppNotificationListDTO.fromJson(Map<String, dynamic> json) =>
      _$$_AppNotificationListDTOFromJson(json);

  @JsonKey()
  @override
  final List<AppNotificationDTO> data;
  @override
  final PaginationLinks? links;
  @override
  final MetaField? meta;

  @override
  String toString() {
    return 'AppNotificationListDTO(data: $data, links: $links, meta: $meta)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppNotificationListDTO &&
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
  _$AppNotificationListDTOCopyWith<_AppNotificationListDTO> get copyWith =>
      __$AppNotificationListDTOCopyWithImpl<_AppNotificationListDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppNotificationListDTOToJson(this);
  }
}

abstract class _AppNotificationListDTO extends AppNotificationListDTO {
  const factory _AppNotificationListDTO(
      {List<AppNotificationDTO> data,
      PaginationLinks? links,
      MetaField? meta}) = _$_AppNotificationListDTO;
  const _AppNotificationListDTO._() : super._();

  factory _AppNotificationListDTO.fromJson(Map<String, dynamic> json) =
      _$_AppNotificationListDTO.fromJson;

  @override
  List<AppNotificationDTO> get data;
  @override
  PaginationLinks? get links;
  @override
  MetaField? get meta;
  @override
  @JsonKey(ignore: true)
  _$AppNotificationListDTOCopyWith<_AppNotificationListDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
