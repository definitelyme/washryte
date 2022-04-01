// GENERATED CODE - DO NOT MODIFY BY HAND

part of notification_meta.dataclass.dart;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationServiceMeta _$$_NotificationServiceMetaFromJson(
        Map<String, dynamic> json) =>
    _$_NotificationServiceMeta(
      type: const NotificationTypeSerializer().fromJson(json['type'] as String),
      order: ServiceRequestDTO.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_NotificationServiceMetaToJson(
    _$_NotificationServiceMeta instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'type', const NotificationTypeSerializer().toJson(instance.type));
  val['order'] = instance.order.toJson();
  return val;
}
