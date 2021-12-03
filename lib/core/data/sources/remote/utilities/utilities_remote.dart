library utilities_remote.dart;

import 'package:washryte/core/data/index.dart';
import 'package:washryte/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'utilities_remote.g.dart';

@lazySingleton
@RestApi()
abstract class UtilitiesRemote {
  @factoryMethod
  factory UtilitiesRemote(AppHttpClient dio) = _UtilitiesRemote;

  @GET(EndPoints.COUNTRIES)
  Future<List<CountryDTO>> countries();

  // @POST(EndPoints.CONTACT_SUPPORT)
  // @MultiPart()
  // Future<void> contactSupport({
  //   @Part(name: 'type') required String type,
  //   @Part(name: 'message') required String message,
  //   @Part(name: 'images[]') List<File> images = const [],
  // });
}
