library utilities_repository.dart;

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:washryte/core/data/http_client/index.dart';
import 'package:washryte/core/data/models/index.dart';
import 'package:washryte/core/data/response/index.dart';
import 'package:washryte/core/data/sources/remote/utilities/utilities_remote.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/features/dashboard/data/repositories/index.dart';

@lazySingleton
class UtilitiesRepository extends BaseRepository {
  final UtilitiesRemote remote;

  UtilitiesRepository({required this.remote});

  Future<Either<AppHttpResponse, KtList<Country>>> countries() async {
    final _conn = await checkConnectivity();

    return _conn.fold(
      (f) async => left(f),
      (_) async {
        try {
          final _countries = await remote.countries();

          return right(_countries.domain);
        } on AppHttpResponse catch (e) {
          return left(e);
        } on AppNetworkException catch (e) {
          return left(e.asResponse());
        }
      },
    );
  }
}
