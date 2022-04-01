library app_notification.dataclass.dart;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';
import 'package:washryte/core/data/models/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/features/dashboard/data/data.dart';
import 'package:washryte/features/dashboard/domain/entities/index.dart';
import 'package:washryte/manager/serializer/serializers.dart';

part 'app_notification.dataclass.freezed.dart';
part 'app_notification.dataclass.g.dart';

AppNotificationDTO deserializeAppNotificationDTO(Map<String, dynamic> json) => AppNotificationDTO.fromJson(json);
Map<String, dynamic> serializeAppNotificationDTO(AppNotificationDTO object) => object.toJson();

@freezed
@immutable
class AppNotificationDTO with _$AppNotificationDTO {
  const AppNotificationDTO._();

  const factory AppNotificationDTO({
    String? id,
    String? title,
    String? message,
    NotificationMetaDTO? meta,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? deletedAt,
  }) = _AppNotificationDTO;

  /// Maps the incoming Json to a Data Transfer Object (DTO).
  factory AppNotificationDTO.fromJson(Map<String, dynamic> json) => _$AppNotificationDTOFromJson(json);

  /// Maps the Data Transfer Object to a InAppNotification Object.
  InAppNotification get domain {
    return InAppNotification(
      id: UniqueId.fromExternal(id),
      title: BasicTextField(title),
      message: BasicTextField(message),
      meta: meta?.domain,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}

AppNotificationListDTO deserializeAppNotificationListDTO(Map<String, dynamic> json) => AppNotificationListDTO.fromJson(json);
Map<String, dynamic> serializeAppNotificationListDTO(AppNotificationListDTO object) => object.toJson();

@freezed
@immutable
class AppNotificationListDTO with _$AppNotificationListDTO {
  const AppNotificationListDTO._();

  const factory AppNotificationListDTO({
    @Default([]) List<AppNotificationDTO> data,
    PaginationLinks? links,
    MetaField? meta,
  }) = _AppNotificationListDTO;

  /// Maps the incoming Json to a Data Transfer Object (DTO).
  factory AppNotificationListDTO.fromJson(Map<String, dynamic> json) => _$AppNotificationListDTOFromJson(json);

  /// Maps the Data Transfer Object to a KtList<InAppNotification> Object.
  KtList<InAppNotification> get domain => KtList.from(data.map((e) => e.domain));
}
