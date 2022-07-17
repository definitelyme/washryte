library notification_meta.dart;

import 'package:washryte/features/dashboard/domain/entities/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_meta.freezed.dart';

@freezed
@immutable
class NotificationMeta with _$NotificationMeta {
  const NotificationMeta._();

  const factory NotificationMeta.order(ServiceRequest? request) = _NotificationRequestMeta;
}
