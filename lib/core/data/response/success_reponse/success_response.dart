import 'package:washryte/core/domain/response/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'success_response.g.dart';
part 'success_response.freezed.dart';

@freezed
@immutable
class SuccessResponse with _$SuccessResponse implements Success {
  const SuccessResponse._();

  const factory SuccessResponse({
    @JsonKey(defaultValue: 'success') String? status,
    @JsonKey(defaultValue: '') required String message,
    @JsonKey(ignore: true) String? details,
    @JsonKey(ignore: true) @Default(false) bool pop,
  }) = _SuccessResponse;

  /// Maps the incoming Json to a Data Transfer Object (DTO).
  factory SuccessResponse.fromJson(Map<String, dynamic> json) => _$SuccessResponseFromJson(json);
}
