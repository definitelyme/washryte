library in_app_notification.dart;

import 'package:washryte/features/dashboard/domain/entities/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:washryte/core/domain/entities/entities.dart';

part 'in_app_notification.freezed.dart';

@freezed
@immutable
class InAppNotification extends BaseEntity with _$InAppNotification {
  const InAppNotification._();

  const factory InAppNotification({
    required UniqueId<String?> id,
    required BasicTextField<String?> title,
    required BasicTextField<String?> message,
    NotificationMeta? meta,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) = _InAppNotification;
}
