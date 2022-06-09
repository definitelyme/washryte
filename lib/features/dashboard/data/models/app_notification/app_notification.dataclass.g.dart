// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_notification.dataclass.dart;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppNotificationDTO _$$_AppNotificationDTOFromJson(
        Map<String, dynamic> json) =>
    _$_AppNotificationDTO(
      id: const StringSerializer().fromJson(json['id']),
      title: json['title'] as String?,
      message: json['message'] as String?,
      meta: json['meta'] == null
          ? null
          : NotificationMetaDTO.fromJson(json['meta'] as Map<String, dynamic>),
      createdAt: const TimestampConverter().fromJson(json['created_at']),
      updatedAt: const TimestampConverter().fromJson(json['updated_at']),
      deletedAt: const TimestampConverter().fromJson(json['deleted_at']),
    );

Map<String, dynamic> _$$_AppNotificationDTOToJson(
    _$_AppNotificationDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', const StringSerializer().toJson(instance.id));
  writeNotNull('title', instance.title);
  writeNotNull('message', instance.message);
  writeNotNull('meta', instance.meta?.toJson());
  writeNotNull(
      'created_at', const TimestampConverter().toJson(instance.createdAt));
  writeNotNull(
      'updated_at', const TimestampConverter().toJson(instance.updatedAt));
  writeNotNull(
      'deleted_at', const TimestampConverter().toJson(instance.deletedAt));
  return val;
}

_$_AppNotificationListDTO _$$_AppNotificationListDTOFromJson(
        Map<String, dynamic> json) =>
    _$_AppNotificationListDTO(
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => AppNotificationDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      links: json['links'] == null
          ? null
          : PaginationLinks.fromJson(json['links'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? null
          : MetaField.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AppNotificationListDTOToJson(
    _$_AppNotificationListDTO instance) {
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
