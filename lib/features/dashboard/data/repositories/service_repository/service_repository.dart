library service_repository.dart;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kt_dart/collection.dart';
import 'package:washryte/core/data/http_client/index.dart';
import 'package:washryte/core/data/models/index.dart';
import 'package:washryte/core/data/response/index.dart';
import 'package:washryte/features/dashboard/data/data.dart';
import 'package:washryte/features/dashboard/data/repositories/service_repository/service_remote.dart';
import 'package:washryte/features/dashboard/domain/domain.dart';
import 'package:washryte/utils/utils.dart';

@lazySingleton
class ServiceRepository extends BaseRepository {
  @override
  final InternetConnectionChecker connectionChecker;

  @override
  final Connectivity connectivity;

  final ServiceRemote remote;

  MetaField? _requestsMeta;
  MetaField? _historyMeta;
  MetaField? _notificationsMeta;

  ServiceRepository(this.connectionChecker, this.connectivity, this.remote);

  Future<Either<AppHttpResponse, KtList<ServiceRequest>>> requests({int? perPage, bool nextPage = false}) async {
    final _perPage = perPage ?? Const.kPerPage;
    final _conn = await checkConnectivity();

    return _conn.fold(
      (f) => left(f),
      (_) async {
        final ServiceRequestListDTO _list;

        try {
          if (nextPage) {
            assert(_requestsMeta != null);

            if (_requestsMeta?.currentPage != _requestsMeta?.lastPage)
              _list = await remote.activeRequests(
                page: _requestsMeta!.currentPage! + 1,
                perPage: perPage ?? _requestsMeta?.perPage,
              );
            else
              return left(AppHttpResponse.endOfList);
          } else {
            final _perPageValue = _requestsMeta?.currentPage != null ? _requestsMeta!.currentPage! * _perPage : _perPage;
            _list = await remote.activeRequests(perPage: _perPageValue);
          }

          // Save new meta data
          _requestsMeta = _list.meta;
          return right(_list.domain);
        } on AppHttpResponse catch (e) {
          return left(e);
        } on AppNetworkException catch (e) {
          return left(e.asResponse());
        }
      },
    );
  }

  Future<Either<AppHttpResponse, ServiceRequest>> placeRequest(ServiceRequest request) async {
    final _conn = await checkConnectivity();

    return _conn.fold(
      (f) => left(f),
      (_) async {
        try {
          final _dto = await compute((ServiceRequest req) => ServiceRequestDTO.fromDomain(req), request);

          final _result = await remote.store(_dto);

          return right(_result.domain);
        } on AppHttpResponse catch (e) {
          return left(e);
        } on AppNetworkException catch (e) {
          return left(e.asResponse());
        }
      },
    );
  }

  Future<Either<AppHttpResponse, ServiceRequest>> show(ServiceRequest request) async {
    final _conn = await checkConnectivity();

    return _conn.fold(
      (f) => left(f),
      (_) async {
        try {
          final _result = await remote.show('${request.id.value}');

          return right(_result.domain);
        } on AppHttpResponse catch (e) {
          return left(e);
        } on AppNetworkException catch (e) {
          return left(e.asResponse());
        }
      },
    );
  }

  Future<Either<AppHttpResponse, KtList<InAppNotification>>> inAppNotifications({int? perPage, bool nextPage = false}) async {
    final _perPage = perPage ?? Const.kPerPage;
    final _conn = await checkConnectivity();

    return _conn.fold(
      (f) => left(f),
      (_) async {
        final AppNotificationListDTO _list;

        try {
          if (nextPage) {
            assert(_notificationsMeta != null);

            if (_notificationsMeta?.currentPage != _notificationsMeta?.lastPage)
              _list = await remote.notifications(
                page: _notificationsMeta!.currentPage! + 1,
                perPage: perPage ?? _notificationsMeta?.perPage,
              );
            else
              return left(AppHttpResponse.endOfList);
          } else {
            final _perPageValue = _notificationsMeta?.currentPage != null ? _notificationsMeta!.currentPage! * _perPage : _perPage;
            _list = await remote.notifications(perPage: _perPageValue);
          }

          // Save new meta data
          _notificationsMeta = _list.meta;
          return right(_list.domain);
        } on AppHttpResponse catch (e) {
          return left(e);
        } on AppNetworkException catch (e) {
          return left(e.asResponse());
        }
      },
    );
  }

  Future<Either<AppHttpResponse, KtList<ServiceRequest>>> history({
    int? perPage,
    bool nextPage = false,
    DateTime? selectedDate,
  }) async {
    final _perPage = perPage ?? Const.kPerPage;
    final _conn = await checkConnectivity();

    return _conn.fold(
      (f) => left(f),
      (_) async {
        final ServiceRequestListDTO _list;

        try {
          if (nextPage) {
            assert(_historyMeta != null);

            if (_historyMeta?.currentPage != _historyMeta?.lastPage)
              _list = await remote.history(
                page: _historyMeta!.currentPage! + 1,
                perPage: perPage ?? _historyMeta?.perPage,
                dates: selectedDate != null ? true : null,
                selectedDate: selectedDate,
              );
            else
              return left(AppHttpResponse.endOfList);
          } else {
            final _perPageValue = _historyMeta?.currentPage != null ? _historyMeta!.currentPage! * _perPage : _perPage;
            _list = await remote.history(
              perPage: _perPageValue,
              dates: selectedDate != null ? true : null,
              selectedDate: selectedDate,
            );
          }

          // Save new meta data
          _historyMeta = _list.meta;
          return right(_list.domain);
        } on AppHttpResponse catch (e) {
          return left(e);
        } on AppNetworkException catch (e) {
          return left(e.asResponse());
        }
      },
    );
  }

  Future<Either<AppHttpResponse, ServiceRequest>> fundWallet(ServiceRequest request) async {
    final _conn = await checkConnectivity();

    return _conn.fold(
      (f) => left(f),
      (_) async {
        try {
          final result = await remote.fundWallet(request.amount.getOrNull);

          return right(result.domain);
        } on AppHttpResponse catch (e) {
          return left(e);
        } on AppNetworkException catch (e) {
          return left(e.asResponse());
        }
      },
    );
  }

  Future<AppHttpResponse> pay(ServiceRequest request) async {
    final _conn = await checkConnectivity();

    return _conn.fold(
      (f) => f,
      (_) async {
        try {
          return remote.pay('${request.id.value}');
        } on AppHttpResponse catch (e) {
          return e;
        } on AppNetworkException catch (e) {
          return e.asResponse();
        }
      },
    );
  }

  Future<AppHttpResponse> cancel(ServiceRequest request) async {
    final _conn = await checkConnectivity();

    return _conn.fold(
      (f) => f,
      (_) async {
        try {
          return remote.cancel('${request.id.value}');
        } on AppHttpResponse catch (e) {
          return e;
        } on AppNetworkException catch (e) {
          return e.asResponse();
        }
      },
    );
  }
}
