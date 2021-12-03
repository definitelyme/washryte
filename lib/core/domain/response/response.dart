import 'package:washryte/core/data/response/index.dart';

mixin _BaseResponse {
  String? get status;
  String? get details;
  String get message;
}

abstract class Response implements _BaseResponse {
  bool get show;
  String? get uuid;
}

abstract class Failure with _FailureMixin, _BaseResponse {
  static const int UNAUTHENTICATED = 401;
  static const int INCOMPLETE_PROFILE = 41101;
  static const int UNVERIFIED_PHONE = 4031;

  int? get code;
  Exception? get exception;
}

abstract class Success with Response {
  bool get pop;
}

abstract class Info with Response {}

mixin _FailureMixin {
  String? get error;
  ServerFieldErrors? get errors;
}

class UnExpectedFailure implements Failure {
  @override
  final int? code;

  @override
  final String? details;

  @override
  final String? error;

  @override
  final String message;

  @override
  final String? status;

  UnExpectedFailure({
    required this.message,
    this.status,
    this.error,
    this.code,
    this.details,
  });

  @override
  ServerFieldErrors? get errors => null;

  @override
  Exception get exception => Exception(message);
}
