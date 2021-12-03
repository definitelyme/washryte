library social_user_dto.dart;

import 'package:washryte/core/data/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/manager/serializer/serializers.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_user_dto.g.dart';
part 'social_user_dto.freezed.dart';

@freezed
@immutable
class SocialUserDTO with _$SocialUserDTO {
  const SocialUserDTO._();

  const factory SocialUserDTO({
    String? status,
    @IntegerSerializer() int? code,
    String? message,
    UserDTO? data,
    UserDTO? user,
  }) = _SocialUserDTO;

  /// Maps the incoming Json to a Data Transfer Object (DTO).
  factory SocialUserDTO.fromJson(Map<String, dynamic> json) => _$SocialUserDTOFromJson(json);

  /// Maps the Data Transfer Object to a Domain instance.
  User? get domain => data?.domain ?? user?.domain;

  UserDTO? get dto => data ?? user;
}
