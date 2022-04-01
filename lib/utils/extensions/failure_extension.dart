import 'package:flutter/widgets.dart';
import 'package:washryte/core/domain/response/index.dart';

extension XFailure on Failure {
  T fold<T>({
    T Function()? is401,

    /// NotFoundError
    T Function()? is404,

    /// Called when user has not completed KYC
    T Function()? is41101,

    /// Used as a default to prevent null-pointer exceptions
    required T Function() orElse,
  }) {
    switch (code) {
      case Failure.UNAUTHENTICATED:
        return is401?.call() ?? orElse.call();
      case 404:
        return is404?.call() ?? orElse.call();
      case Failure.INCOMPLETE_PROFILE:
        return is41101?.call() ?? orElse.call();
      default:
        return (T is Widget) ? const SizedBox.shrink() as T : orElse.call();
    }
  }
}
