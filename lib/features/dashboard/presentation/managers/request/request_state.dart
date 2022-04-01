part of request_cubit.dart;

@freezed
class RequestState extends BaseState with _$RequestState {
  static final FocusNode itemsFocus = FocusNode();
  static final FocusNode addressFocus = FocusNode();

  const factory RequestState({
    @Default(false) bool isLoading,
    @Default(false) bool isCancelling,
    @Default(false) bool isFetchingSingle,
    @Default(false) bool isFetchingByDate,
    @Default(false) bool validate,
    @Default(false) bool canPay,
    required ServiceRequest request,
    required MoneyMaskedTextController amountTextController,
    @Default(KtList.empty()) KtList<ServiceRequest> activeRequests,
    @Default(KtList.empty()) KtList<ServiceRequest> history,
    @Default(KtList.empty()) KtList<InAppNotification> notificationList,
    @Default(KtMap.empty()) KtMap<DateTime, KtList<InAppNotification>> notifications,
    DateTime? selectedDate,
    @Default(None()) Option<AppHttpResponse?> status,
  }) = _RequestState;

  const RequestState._();

  factory RequestState.initial() => RequestState(
        request: ServiceRequest.blank(),
        amountTextController: MoneyMaskedTextController(
          initialValue: 0,
          precision: 0,
          decimalSeparator: '',
          thousandSeparator: ',',
          leftSymbol: '${Utils.currency} ',
        ),
      );
}
