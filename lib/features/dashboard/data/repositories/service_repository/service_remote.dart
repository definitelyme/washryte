library service_remote.dart;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:washryte/core/data/index.dart';
import 'package:washryte/features/dashboard/data/models/models.dart';
import 'package:washryte/manager/serializer/serializers.dart';
import 'package:washryte/utils/utils.dart';

part 'service_remote.g.dart';

@lazySingleton
@RestApi(parser: Parser.FlutterCompute)
abstract class ServiceRemote {
  @factoryMethod
  factory ServiceRemote(AppHttpClient dio) = _ServiceRemote;

  @POST(EndPoints.PLACE_AN_ORDER)
  Future<ServiceRequestDTO> store(@Body() ServiceRequestDTO dto);

  @POST(EndPoints.FUND_WALLET)
  Future<ServiceRequestDTO> fundWallet(@Field() double amount);

  @GET(EndPoints.FETCH_SINGLE_ORDER)
  Future<ServiceRequestDTO> show(@Path() String id);

  @GET(EndPoints.TRACK_ORDER)
  Future<ServiceRequestListDTO> activeRequests({
    @Query('page') int? page,
    @Query('per_page') int? perPage,
  });

  @GET(EndPoints.FETCH_ORDER_HISTORY)
  Future<ServiceRequestListDTO> history({
    @Query('page') int? page,
    @Query('per_page') int? perPage,
    @Query('dates') bool? dates,
    @Query('date_from') DateTime? selectedDate,
  });

  @GET(EndPoints.FETCH_NOTIFICATIONS)
  Future<AppNotificationListDTO> notifications({
    @Query('page') int? page,
    @Query('per_page') int? perPage,
  });

  @PATCH(EndPoints.PAY_FOR_ORDER)
  Future<AppHttpResponse> pay(@Path() String id);

  @PATCH(EndPoints.CANCEL_ORDER)
  Future<AppHttpResponse> cancel(@Path() String id);
}
