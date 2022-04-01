import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/collection.dart';
import 'package:logger/logger.dart';
import 'package:washryte/features/dashboard/data/models/models.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  test(
    'test that [AppNotificationListDTO] model can parse server json',
    () async {
      var result = jsonDecode(fixture('app_notifications/app_notification.json'));

      final _res = AppNotificationListDTO.fromJson(result as Map<String, dynamic>);

      _res.domain.forEach((el) {
        Logger().w(el.meta?.map(
          order: (it) => it.request.paymentMethod,
        ));
      });
    },
  );
}
