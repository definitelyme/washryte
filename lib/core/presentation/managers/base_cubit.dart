import 'package:kt_dart/kt.dart';
import 'package:washryte/core/data/response/index.dart';
import 'package:washryte/core/domain/response/index.dart';
import 'package:washryte/features/dashboard/domain/entities/index.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<Option<AppHttpResponse?>> _connection() async {
  final isConnected = (await getIt<Connectivity>().checkConnectivity()) != ConnectivityResult.none;

  if (!isConnected)
    return some(AppHttpResponse(AnyResponse.fromFailure(
      const NetworkFailure.notConnected(),
    )));

  final hasInternet = await getIt<InternetConnectionChecker>().hasConnection;

  if (isConnected && !hasInternet)
    return some(AppHttpResponse(AnyResponse.fromFailure(
      const NetworkFailure.poorInternet(),
    )));

  return none();
}

abstract class BaseState {
  const BaseState();

  bool get isLoading;
  bool get validate;
}

mixin BaseCubit<State extends BaseState> on Cubit<State> {
  Future<Option<AppHttpResponse?>> connection() => _connection();
}

abstract class BaseAddressState {
  const BaseAddressState();

  bool get isLoading;
  KtList<PlacePrediction?> get predictions;
  PlacePrediction? get selectedPrediction;
  bool get validate;
}

mixin BaseAddressCubit<State extends BaseAddressState> on Cubit<State> {
  void autocomplete(String query, {required String token});

  Future<Option<AppHttpResponse?>> connection() => _connection();
}
