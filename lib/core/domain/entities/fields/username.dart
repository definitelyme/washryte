library username.dart;

import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/core/domain/response/field_object/field_object_exception.dart';
import 'package:washryte/core/domain/validator/validator.dart';
import 'package:dartz/dartz.dart';

class Username extends FieldObject<String?> {
  static const Username DEFAULT = Username._(Right(''));
  static const String kPlaceholder = 'John Doe';

  @override
  final Either<FieldObjectException<String>, String?> value;

  factory Username(String? input) => Username._(Validator.isEmpty(input));

  const Username._(this.value);

  bool get isPYO => compare('PYO');

  @override
  Username copyWith(String? newValue) => Username(newValue);
}
