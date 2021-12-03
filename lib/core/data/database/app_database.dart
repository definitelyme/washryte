library app_database.dart;

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:washryte/core/data/index.dart';
import 'package:washryte/core/data/models/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/manager/serializer/serializers.dart';

part 'app_database.freezed.dart';
part 'app_database.g.dart';
part 'base_dao.dart';
part 'package:washryte/core/data/models/user/user_dto.dart';

@TypeConverters([
  TimestampFloorConverter,
  CountryDTOFloorConverter,
  AuthProviderFloorConverter,
])
@Database(version: 1, entities: [
  _$_UserDTO,
])
abstract class AppDatabase extends FloorDatabase {
  UserDAO get userDAO;
}
