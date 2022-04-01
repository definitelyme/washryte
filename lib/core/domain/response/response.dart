import 'package:washryte/core/data/response/index.dart';

mixin _BaseResponse {
  String? get status;
  String? get details;
  String get message;
}

abstract class Response implements _BaseResponse {
  const Response();

  // bool get show;
  // String? get uuid;
}

abstract class Failure with _FailureMixin implements Response {
  static const int UNAUTHENTICATED = 401;
  static const int INCOMPLETE_PROFILE = 41101;
  static const int UNVERIFIED_PHONE = 4031;

  int? get code;
  bool get show;
  Exception? get exception;
}

abstract class Success implements Response {
  bool get pop;
}

abstract class Info implements Response {
  bool get pop;
}

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
  final bool show;

  @override
  final String message;

  @override
  final String? status;

  UnExpectedFailure({
    required this.message,
    this.status,
    this.error,
    this.show = true,
    this.code,
    this.details,
  });

  @override
  ServerFieldErrors? get errors => null;

  @override
  Exception get exception => Exception(message);
}
