library notification_type.dart;

import 'package:freezed_annotation/freezed_annotation.dart';

class NotificationType {
  static const String service_request = 'order.status-updated';

  static const NotificationType ORDER = _$ORDER;

  final String name;

  const NotificationType._(this.name);

  static NotificationType? valueOf(String? name) => _$valueOf(name);

  @override
  String toString() => '$name';
}

const NotificationType _$ORDER = NotificationType._('${NotificationType.service_request}');

NotificationType? _$valueOf(String? name) {
  switch (name) {
    case '${NotificationType.service_request}':
      return _$ORDER;
    default:
      return null;
  }
}

class NotificationTypeSerializer implements JsonConverter<NotificationType?, String?> {
  const NotificationTypeSerializer();

  @override
  NotificationType? fromJson(String? value) => NotificationType.valueOf(value);

  @override
  String? toJson(NotificationType? instance) => instance?.name;
}

extension NotificationTypeX on NotificationType {
  T maybeWhen<T>({
    // T Function()? request,
    // T Function()? package,
    T Function()? order,
    required T Function() orElse,
  }) {
    if (this == NotificationType.ORDER)
      return order?.call() ?? orElse.call();
    else
      return orElse.call();
  }

  T when<T>({
    // required T Function() request,
    // required T Function() package,
    required T Function() order,
  }) {
    switch (this) {
      case NotificationType.ORDER:
        return order.call();
      default:
        throw ArgumentError(name);
    }
  }
}
