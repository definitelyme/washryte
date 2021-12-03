import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:washryte/core/data/response/index.dart';
import 'package:washryte/core/domain/response/index.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:stream_transform/stream_transform.dart';

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

abstract class BaseBlocEvent {}

abstract class BaseBlocState {
  const BaseBlocState();

  bool get isLoading;
  bool get validate;
}

mixin BaseBloc<Event extends BaseBlocEvent, State extends BaseBlocState> on Bloc<Event, State> {
  EventTransformer<Evt> debounce<Evt>(Duration duration) => (events, mapper) => events.debounce(duration).switchMap(mapper);

  Future<Option<AppHttpResponse?>> connection() => _connection();
}
