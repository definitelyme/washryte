library notification_meta.dataclass.dart;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:washryte/features/dashboard/data/models/models.dart';
import 'package:washryte/features/dashboard/domain/entities/index.dart';

part 'notification_meta.dataclass.freezed.dart';
part 'notification_meta.dataclass.g.dart';

NotificationMetaDTO deserializeNotificationMetaDTO(Map<String, dynamic> json) => NotificationMetaDTO.fromJson(json);
Map<String, dynamic> serializeNotificationMetaDTO(NotificationMetaDTO object) => object.toJson();

@immutable
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class NotificationMetaDTO with _$NotificationMetaDTO {
  const NotificationMetaDTO._();

  @FreezedUnionValue('${NotificationType.service_request}')
  const factory NotificationMetaDTO.service({
    @NotificationTypeSerializer() NotificationType? type,
    ServiceRequestDTO? order,
  }) = _NotificationServiceMeta;

  /// Maps the incoming Json to a Data Transfer Object (DTO).
  factory NotificationMetaDTO.fromJson(Map<String, dynamic> json) => _$NotificationMetaDTOFromJson(json);

  /// Maps the Data Transfer Object to a NotificationMeta Object.
  NotificationMeta? get domain {
    return type?.maybeWhen(
      order: () => NotificationMeta.order(mapOrNull(service: order != null ? (_) => order!.domain : null)),
      orElse: () => null,
    );
  }
}
