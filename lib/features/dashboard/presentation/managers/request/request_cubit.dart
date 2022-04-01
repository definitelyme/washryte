library request_cubit.dart;

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:washryte/core/data/response/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/core/presentation/index.dart';
import 'package:washryte/features/auth/domain/index.dart';
import 'package:washryte/features/dashboard/data/repositories/service_repository/service_repository.dart';
import 'package:washryte/features/dashboard/domain/domain.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

part 'request_cubit.freezed.dart';
part 'request_state.dart';

@injectable
class RequestCubit extends Cubit<RequestState> with BaseCubit<RequestState> {
  static const int MINIMUM_FUND_AMOUNT = 100;
  final AuthFacade _authFacade;
  final FirebaseAnalytics _firebaseAnalytics;
  final PaystackPlugin _paystack;
  final ServiceRepository _repository;

  RequestCubit(this._repository, this._paystack, this._firebaseAnalytics, this._authFacade) : super(RequestState.initial());

  String get reference => '${DateTime.now().toIso8601String()}-_-${UniqueId<String>.v4().value}';

  void _updateCollection<T extends BaseEntity>(
    KtList<T> list, {
    required RequestState Function(KtMap<DateTime, KtList<T>>) update,
  }) {
    // Sort with & group-by the createdAt property
    var _sorted = list
        .sortedWith((a, b) => b.createdAt!.compareTo(a.createdAt!))
        .groupBy((it) => DateTime(it.createdAt!.year, it.createdAt!.month, it.createdAt!.day));

    emit(update.call(_sorted));
  }

  void _logPaymentFailed(ServiceRequest request, User? user, Object? message) async {
    await _firebaseAnalytics.logEvent(
      name: 'payment_failed',
      parameters: <String, dynamic>{
        'reason_message': '$message',
        'payment_type': '${request.paymentMethod.name}'.capitalizeFirst(),
        'payment_status': 'Failed',
        'payment_reference': reference,
        'payment_amount': request.amount.getOrNull,
        'payment_currency': 'NGN',
      },
    );
  }

  void _logPaymentSuccessful(ServiceRequest request, User? user) async {
    await _firebaseAnalytics.logAddPaymentInfo(
      value: request.amount.getOrNull.toDouble(),
      currency: 'NGN',
      callOptions: AnalyticsCallOptions(global: false),
      paymentType: '${request.paymentMethod.name}',
      coupon: 'NO_COUPON',
      items: [
        AnalyticsEventItem(
          itemId: '${request.id.value}',
          itemName: 'Service Payment - ${request.paymentMethod.formatted}',
          price: request.amount.getOrNull.toDouble(),
          quantity: 1,
          currency: 'NGN',
        ),
      ],
    );

    await _firebaseAnalytics.logEvent(
      name: 'payment_successful',
      parameters: {
        'donation': request.id.value,
        'payment_status': 'Successful',
        'payment_type': '${request.paymentMethod.name}'.capitalizeFirst(),
        'payment_reference': reference,
        'amount': request.amount.getOrNull,
        'currency': 'NGN',
      },
    );
  }

  Future<void> _paystackPay(BuildContext ctx, User? user, {VoidCallback? callback}) async {
    final name = user?.fullName.getOrEmpty;
    final email = user?.email.getOrEmpty;
    final phone = user?.phone.getOrNull;
    final _amount = env.flavor.fold(prod: () => state.request.amount.getOrNull * 100, dev: () => 500);

    var _charge = Charge()
      ..amount = _amount.toInt()
      ..email = email
      ..reference = reference
      ..currency = 'NGN'
      ..putMetaData('deposit', '${state.request.id.value}')
      ..putCustomField("User's Name", '$name')
      ..putCustomField("User's Email", '$email')
      ..putCustomField("User's Phone", '$phone')
      ..putCustomField('Payment Reference', reference);

    try {
      final _response = await _paystack.checkout(
        ctx,
        charge: _charge,
        fullscreen: true,
        hideAmount: false,
        hideEmail: false,
        logo: ImageBox.asset(
          photo: AppAssets.logo,
          elevation: 0.0,
          height: 0.2.w,
          width: 0.2.w,
          borderRadius: BorderRadius.zero,
          useDefaultRadius: false,
          fit: BoxFit.contain,
        ),
        method: CheckoutMethod.card,
      );

      if (!isClosed) {
        if (_response.status) {
          emit(state.copyWith.request(status: OrderStatus.paid));
          _logPaymentSuccessful(state.request, user);
          updateBalance();
          callback?.call();
        } else {
          emit(state.copyWith.request(status: OrderStatus.pending));
          _logPaymentFailed(state.request, user, _response.message);
          callback?.call();
        }
      }
    } on PaystackException catch (e) {
      if (!isClosed) emit(state.copyWith(status: some(AppHttpResponse.failure('${e.message}'))));
      callback?.call();
    }
  }

  Future<void> active({int? perPage, bool nextPage = false}) async {
    if (state.status.getOrNull == AppHttpResponse.endOfList && nextPage) return;

    toggleLoading(true, none());

    final response = await _repository.requests(perPage: perPage, nextPage: nextPage);

    response.fold(
      (e) => emit(state.copyWith(status: some(e))),
      (requests) {
        emit(state.copyWith(activeRequests: nextPage ? state.activeRequests.plusIfAbsent(requests) : requests));
      },
    );

    toggleLoading(false);
  }

  void addressChanged(String value) => emit(state.copyWith.request(address: BasicTextField(value)));

  void amountChanged() {
    final value = state.amountTextController.numberValue;
    emit(state.copyWith.request(amount: AmountField((value ?? 0).toDouble())));
  }

  void cancel() async {
    emit(state.copyWith(isCancelling: true, status: none()));

    final response = await _repository.cancel(state.request);

    emit(state.copyWith(status: some(response.copyWith(response: response.response.copyWith(pop: true)))));

    emit(state.copyWith(isCancelling: false));
  }

  void dateChanged(DateTime? value) async {
    if (value != null) {
      emit(state.copyWith(selectedDate: value, isFetchingByDate: true, status: none()));

      await history(perPage: 10);

      emit(state.copyWith(isFetchingByDate: false));
    }
  }

  void deposit(BuildContext ctx, User? user, {VoidCallback? callback}) async {
    final _request = state.request;

    emit(state.copyWith(
      isLoading: true,
      status: none(),
      canPay: false,
      request: _request.copyWith(paymentMethod: PaymentMethod.PENDING),
    ));

    final _conn = await connection();

    await _conn.fold(
      () async {
        if (!isClosed) state.amountTextController.clear();

        await _paystackPay(ctx, user, callback: callback);
      },
      (f) async => emit(state.copyWith(status: optionOf(f))),
    );

    toggleLoading(false);
  }

  void fundWallet() async {
    toggleLoading(true, none());

    final response = await _repository.fundWallet(state.request);

    response.fold(
      (e) => emit(state.copyWith(status: some(e))),
      (request) => emit(state.copyWith(request: request, canPay: true)),
    );

    toggleLoading(false);
  }

  Future<void> history({int? perPage, bool nextPage = false}) async {
    if (state.status.getOrNull == AppHttpResponse.endOfList && nextPage) return;

    toggleLoading(true, none());

    final response = await _repository.history(
      perPage: perPage,
      nextPage: nextPage,
      selectedDate: state.selectedDate,
    );

    response.fold(
      (e) => emit(state.copyWith(status: some(e))),
      (requests) {
        final filtered = requests.filter((r) => r.status == OrderStatus.delivered || r.status == OrderStatus.cancelled);
        // final filtered = requests;
        emit(state.copyWith(history: nextPage ? state.history.plusIfAbsent(filtered) : filtered));
      },
    );

    toggleLoading(false);
  }

  Future<void> inAppNotifications({int? perPage, bool nextPage = false}) async {
    if (state.status.getOrNull == AppHttpResponse.endOfList && nextPage) return;

    toggleLoading(true, none());

    final response = await _repository.inAppNotifications(perPage: perPage, nextPage: nextPage);

    response.fold(
      (e) => emit(state.copyWith(status: some(e), isLoading: false)),
      (notifications) {
        KtList<InAppNotification> _list;

        if (nextPage)
          _list = state.notificationList.plusIfAbsent(notifications);
        else
          _list = notifications;

        _updateCollection<InAppNotification>(
          _list.filter((a) => a.meta != null),
          update: (it) => state.copyWith(
            notifications: it,
            notificationList: _list,
            isLoading: false,
          ),
        );
      },
    );
  }

  void itemsChanged(String value) => emit(state.copyWith.request(items: BasicTextField(value)));

  void pay() async {
    toggleLoading(true, none());

    final response = await _repository.pay(state.request);

    emit(state.copyWith(status: some(response)));

    toggleLoading(false);
  }

  void paymentMethodChanged(PaymentMethod value) => emit(state.copyWith.request(paymentMethod: value));

  void requestService() async {
    toggleLoading(true, none());

    emit(state.copyWith(validate: true));

    if (state.request.failure.isNone()) {
      final response = await _repository.placeRequest(state.request);

      response.fold(
        (e) => emit(state.copyWith(status: some(e))),
        (request) {
          emit(state.copyWith(
            request: state.request.merge(request),
            status: some(AppHttpResponse.successful('Great! Your request has been received.', pop: true)),
          ));
        },
      );
    }

    toggleLoading(false);
  }

  void show(ServiceRequest request) async {
    emit(state.copyWith(request: request, isFetchingSingle: true, status: none()));

    final response = await _repository.show(request);

    response.fold(
      (e) => emit(state.copyWith(status: some(e), isFetchingSingle: false)),
      (request) => emit(state.copyWith(request: request, isFetchingSingle: false)),
      // (request) => emit(state.copyWith(request: request.copyWith(status: OrderStatus.cancelled))),
    );
  }

  void toggleLoading([bool? isLoading, Option<AppHttpResponse?>? status]) =>
      emit(state.copyWith(isLoading: isLoading ?? !state.isLoading, status: status ?? state.status));

  void typeChanged(ServiceType? value) => emit(state.copyWith.request(type: value!));

  void updateBalance() => unawaited(_authFacade.sink());
}
