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
        Logger().i('''
Title ==> ${el.title.getOrNull},
Message ===> ${el.message.getOrNull},
Meta Details ===> ${el.meta?.map(order: (e) => e.request?.type)},
Created At ==> ${el.createdAt}
Updated At ==> ${el.updatedAt}
Deleted At ==> ${el.deletedAt}
        ''');
      });
    },
  );
}
