library user.dart;

import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/core/domain/response/index.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
@immutable
class User with _$User {
  const User._();

  const factory User({
    required UniqueId<String?> uid,
    required DisplayName fullName,
    required EmailAddress email,
    required Phone phone,
    required Password password,
    required Password confirmation,
    required MediaField photo,
    @Default(AuthProvider.regular) AuthProvider provider,
    required AmountField<double> balance,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) = _User;

  factory User.blank({
    DisplayName? fullName,
    EmailAddress? email,
    Phone? phone,
    Password? password,
    Password? confirmation,
  }) =>
      User(
        uid: UniqueId.fromExternal(null),
        fullName: fullName ?? DisplayName(null),
        email: email ?? EmailAddress(null),
        phone: phone ?? Phone(null),
        photo: MediaField(null),
        password: password ?? Password(null),
        confirmation: confirmation ?? Password(null),
        balance: AmountField(0),
      );

  Option<FieldObjectException<dynamic>> get signup => fullName.mapped
      .andThen(email.mapped)
      .andThen(phone.mapped)
      .andThen(password.mapped)
      .andThen(confirmation.mapped)
      .fold((f) => some(f), (_) => none());

  Option<FieldObjectException<dynamic>> get login => email.mapped.andThen(password.mapped).fold((f) => some(f), (_) => none());

  Option<FieldObjectException<dynamic>> get reset => email.mapped.andThen(password.mapped).fold((f) => some(f), (_) => none());

  Option<FieldObjectException<dynamic>> get profile => email.mapped.andThen(phone.mapped).fold((f) => some(f), (_) => none());

  Option<FieldObjectException<dynamic>> get socials => phone.mapped.fold((f) => some(f), (_) => none());
}
