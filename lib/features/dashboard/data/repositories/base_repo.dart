library base.dart;

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:washryte/core/data/response/index.dart';
import 'package:washryte/core/domain/response/index.dart';
import 'package:washryte/manager/locator/locator.dart';

abstract class BaseRepository {
  Future<Either<AppHttpResponse, bool>> checkConnectivity() async {
    final isConnected = (await getIt<Connectivity>().checkConnectivity()) != ConnectivityResult.none;

    if (!isConnected)
      return left(AppHttpResponse(AnyResponse.fromFailure(
        const NetworkFailure.notConnected(),
      )));

    final hasInternet = await getIt<InternetConnectionChecker>().hasConnection;

    if (isConnected && !hasInternet)
      return left(AppHttpResponse(AnyResponse.fromFailure(
        const NetworkFailure.poorInternet(),
      )));

    return right(isConnected && hasInternet);
  }
}
