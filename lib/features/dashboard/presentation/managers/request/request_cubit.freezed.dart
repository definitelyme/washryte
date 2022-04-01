// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of request_cubit.dart;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RequestStateTearOff {
  const _$RequestStateTearOff();

  _RequestState call(
      {bool isLoading = false,
      bool isCancelling = false,
      bool isFetchingSingle = false,
      bool isFetchingByDate = false,
      bool validate = false,
      bool canPay = false,
      required ServiceRequest request,
      required MoneyMaskedTextController amountTextController,
      KtList<ServiceRequest> activeRequests = const KtList.empty(),
      KtList<ServiceRequest> history = const KtList.empty(),
      KtList<InAppNotification> notificationList = const KtList.empty(),
      KtMap<DateTime, KtList<InAppNotification>> notifications =
          const KtMap.empty(),
      DateTime? selectedDate,
      Option<AppHttpResponse?> status = const None()}) {
    return _RequestState(
      isLoading: isLoading,
      isCancelling: isCancelling,
      isFetchingSingle: isFetchingSingle,
      isFetchingByDate: isFetchingByDate,
      validate: validate,
      canPay: canPay,
      request: request,
      amountTextController: amountTextController,
      activeRequests: activeRequests,
      history: history,
      notificationList: notificationList,
      notifications: notifications,
      selectedDate: selectedDate,
      status: status,
    );
  }
}

/// @nodoc
const $RequestState = _$RequestStateTearOff();

/// @nodoc
mixin _$RequestState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isCancelling => throw _privateConstructorUsedError;
  bool get isFetchingSingle => throw _privateConstructorUsedError;
  bool get isFetchingByDate => throw _privateConstructorUsedError;
  bool get validate => throw _privateConstructorUsedError;
  bool get canPay => throw _privateConstructorUsedError;
  ServiceRequest get request => throw _privateConstructorUsedError;
  MoneyMaskedTextController get amountTextController =>
      throw _privateConstructorUsedError;
  KtList<ServiceRequest> get activeRequests =>
      throw _privateConstructorUsedError;
  KtList<ServiceRequest> get history => throw _privateConstructorUsedError;
  KtList<InAppNotification> get notificationList =>
      throw _privateConstructorUsedError;
  KtMap<DateTime, KtList<InAppNotification>> get notifications =>
      throw _privateConstructorUsedError;
  DateTime? get selectedDate => throw _privateConstructorUsedError;
  Option<AppHttpResponse?> get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RequestStateCopyWith<RequestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestStateCopyWith<$Res> {
  factory $RequestStateCopyWith(
          RequestState value, $Res Function(RequestState) then) =
      _$RequestStateCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading,
      bool isCancelling,
      bool isFetchingSingle,
      bool isFetchingByDate,
      bool validate,
      bool canPay,
      ServiceRequest request,
      MoneyMaskedTextController amountTextController,
      KtList<ServiceRequest> activeRequests,
      KtList<ServiceRequest> history,
      KtList<InAppNotification> notificationList,
      KtMap<DateTime, KtList<InAppNotification>> notifications,
      DateTime? selectedDate,
      Option<AppHttpResponse?> status});

  $ServiceRequestCopyWith<$Res> get request;
}

/// @nodoc
class _$RequestStateCopyWithImpl<$Res> implements $RequestStateCopyWith<$Res> {
  _$RequestStateCopyWithImpl(this._value, this._then);

  final RequestState _value;
  // ignore: unused_field
  final $Res Function(RequestState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isCancelling = freezed,
    Object? isFetchingSingle = freezed,
    Object? isFetchingByDate = freezed,
    Object? validate = freezed,
    Object? canPay = freezed,
    Object? request = freezed,
    Object? amountTextController = freezed,
    Object? activeRequests = freezed,
    Object? history = freezed,
    Object? notificationList = freezed,
    Object? notifications = freezed,
    Object? selectedDate = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCancelling: isCancelling == freezed
          ? _value.isCancelling
          : isCancelling // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchingSingle: isFetchingSingle == freezed
          ? _value.isFetchingSingle
          : isFetchingSingle // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchingByDate: isFetchingByDate == freezed
          ? _value.isFetchingByDate
          : isFetchingByDate // ignore: cast_nullable_to_non_nullable
              as bool,
      validate: validate == freezed
          ? _value.validate
          : validate // ignore: cast_nullable_to_non_nullable
              as bool,
      canPay: canPay == freezed
          ? _value.canPay
          : canPay // ignore: cast_nullable_to_non_nullable
              as bool,
      request: request == freezed
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as ServiceRequest,
      amountTextController: amountTextController == freezed
          ? _value.amountTextController
          : amountTextController // ignore: cast_nullable_to_non_nullable
              as MoneyMaskedTextController,
      activeRequests: activeRequests == freezed
          ? _value.activeRequests
          : activeRequests // ignore: cast_nullable_to_non_nullable
              as KtList<ServiceRequest>,
      history: history == freezed
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as KtList<ServiceRequest>,
      notificationList: notificationList == freezed
          ? _value.notificationList
          : notificationList // ignore: cast_nullable_to_non_nullable
              as KtList<InAppNotification>,
      notifications: notifications == freezed
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as KtMap<DateTime, KtList<InAppNotification>>,
      selectedDate: selectedDate == freezed
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Option<AppHttpResponse?>,
    ));
  }

  @override
  $ServiceRequestCopyWith<$Res> get request {
    return $ServiceRequestCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value));
    });
  }
}

/// @nodoc
abstract class _$RequestStateCopyWith<$Res>
    implements $RequestStateCopyWith<$Res> {
  factory _$RequestStateCopyWith(
          _RequestState value, $Res Function(_RequestState) then) =
      __$RequestStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading,
      bool isCancelling,
      bool isFetchingSingle,
      bool isFetchingByDate,
      bool validate,
      bool canPay,
      ServiceRequest request,
      MoneyMaskedTextController amountTextController,
      KtList<ServiceRequest> activeRequests,
      KtList<ServiceRequest> history,
      KtList<InAppNotification> notificationList,
      KtMap<DateTime, KtList<InAppNotification>> notifications,
      DateTime? selectedDate,
      Option<AppHttpResponse?> status});

  @override
  $ServiceRequestCopyWith<$Res> get request;
}

/// @nodoc
class __$RequestStateCopyWithImpl<$Res> extends _$RequestStateCopyWithImpl<$Res>
    implements _$RequestStateCopyWith<$Res> {
  __$RequestStateCopyWithImpl(
      _RequestState _value, $Res Function(_RequestState) _then)
      : super(_value, (v) => _then(v as _RequestState));

  @override
  _RequestState get _value => super._value as _RequestState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isCancelling = freezed,
    Object? isFetchingSingle = freezed,
    Object? isFetchingByDate = freezed,
    Object? validate = freezed,
    Object? canPay = freezed,
    Object? request = freezed,
    Object? amountTextController = freezed,
    Object? activeRequests = freezed,
    Object? history = freezed,
    Object? notificationList = freezed,
    Object? notifications = freezed,
    Object? selectedDate = freezed,
    Object? status = freezed,
  }) {
    return _then(_RequestState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCancelling: isCancelling == freezed
          ? _value.isCancelling
          : isCancelling // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchingSingle: isFetchingSingle == freezed
          ? _value.isFetchingSingle
          : isFetchingSingle // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchingByDate: isFetchingByDate == freezed
          ? _value.isFetchingByDate
          : isFetchingByDate // ignore: cast_nullable_to_non_nullable
              as bool,
      validate: validate == freezed
          ? _value.validate
          : validate // ignore: cast_nullable_to_non_nullable
              as bool,
      canPay: canPay == freezed
          ? _value.canPay
          : canPay // ignore: cast_nullable_to_non_nullable
              as bool,
      request: request == freezed
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as ServiceRequest,
      amountTextController: amountTextController == freezed
          ? _value.amountTextController
          : amountTextController // ignore: cast_nullable_to_non_nullable
              as MoneyMaskedTextController,
      activeRequests: activeRequests == freezed
          ? _value.activeRequests
          : activeRequests // ignore: cast_nullable_to_non_nullable
              as KtList<ServiceRequest>,
      history: history == freezed
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as KtList<ServiceRequest>,
      notificationList: notificationList == freezed
          ? _value.notificationList
          : notificationList // ignore: cast_nullable_to_non_nullable
              as KtList<InAppNotification>,
      notifications: notifications == freezed
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as KtMap<DateTime, KtList<InAppNotification>>,
      selectedDate: selectedDate == freezed
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Option<AppHttpResponse?>,
    ));
  }
}

/// @nodoc

class _$_RequestState extends _RequestState {
  const _$_RequestState(
      {this.isLoading = false,
      this.isCancelling = false,
      this.isFetchingSingle = false,
      this.isFetchingByDate = false,
      this.validate = false,
      this.canPay = false,
      required this.request,
      required this.amountTextController,
      this.activeRequests = const KtList.empty(),
      this.history = const KtList.empty(),
      this.notificationList = const KtList.empty(),
      this.notifications = const KtMap.empty(),
      this.selectedDate,
      this.status = const None()})
      : super._();

  @JsonKey()
  @override
  final bool isLoading;
  @JsonKey()
  @override
  final bool isCancelling;
  @JsonKey()
  @override
  final bool isFetchingSingle;
  @JsonKey()
  @override
  final bool isFetchingByDate;
  @JsonKey()
  @override
  final bool validate;
  @JsonKey()
  @override
  final bool canPay;
  @override
  final ServiceRequest request;
  @override
  final MoneyMaskedTextController amountTextController;
  @JsonKey()
  @override
  final KtList<ServiceRequest> activeRequests;
  @JsonKey()
  @override
  final KtList<ServiceRequest> history;
  @JsonKey()
  @override
  final KtList<InAppNotification> notificationList;
  @JsonKey()
  @override
  final KtMap<DateTime, KtList<InAppNotification>> notifications;
  @override
  final DateTime? selectedDate;
  @JsonKey()
  @override
  final Option<AppHttpResponse?> status;

  @override
  String toString() {
    return 'RequestState(isLoading: $isLoading, isCancelling: $isCancelling, isFetchingSingle: $isFetchingSingle, isFetchingByDate: $isFetchingByDate, validate: $validate, canPay: $canPay, request: $request, amountTextController: $amountTextController, activeRequests: $activeRequests, history: $history, notificationList: $notificationList, notifications: $notifications, selectedDate: $selectedDate, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RequestState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other.isCancelling, isCancelling) &&
            const DeepCollectionEquality()
                .equals(other.isFetchingSingle, isFetchingSingle) &&
            const DeepCollectionEquality()
                .equals(other.isFetchingByDate, isFetchingByDate) &&
            const DeepCollectionEquality().equals(other.validate, validate) &&
            const DeepCollectionEquality().equals(other.canPay, canPay) &&
            const DeepCollectionEquality().equals(other.request, request) &&
            const DeepCollectionEquality()
                .equals(other.amountTextController, amountTextController) &&
            const DeepCollectionEquality()
                .equals(other.activeRequests, activeRequests) &&
            const DeepCollectionEquality().equals(other.history, history) &&
            const DeepCollectionEquality()
                .equals(other.notificationList, notificationList) &&
            const DeepCollectionEquality()
                .equals(other.notifications, notifications) &&
            const DeepCollectionEquality()
                .equals(other.selectedDate, selectedDate) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(isCancelling),
      const DeepCollectionEquality().hash(isFetchingSingle),
      const DeepCollectionEquality().hash(isFetchingByDate),
      const DeepCollectionEquality().hash(validate),
      const DeepCollectionEquality().hash(canPay),
      const DeepCollectionEquality().hash(request),
      const DeepCollectionEquality().hash(amountTextController),
      const DeepCollectionEquality().hash(activeRequests),
      const DeepCollectionEquality().hash(history),
      const DeepCollectionEquality().hash(notificationList),
      const DeepCollectionEquality().hash(notifications),
      const DeepCollectionEquality().hash(selectedDate),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$RequestStateCopyWith<_RequestState> get copyWith =>
      __$RequestStateCopyWithImpl<_RequestState>(this, _$identity);
}

abstract class _RequestState extends RequestState {
  const factory _RequestState(
      {bool isLoading,
      bool isCancelling,
      bool isFetchingSingle,
      bool isFetchingByDate,
      bool validate,
      bool canPay,
      required ServiceRequest request,
      required MoneyMaskedTextController amountTextController,
      KtList<ServiceRequest> activeRequests,
      KtList<ServiceRequest> history,
      KtList<InAppNotification> notificationList,
      KtMap<DateTime, KtList<InAppNotification>> notifications,
      DateTime? selectedDate,
      Option<AppHttpResponse?> status}) = _$_RequestState;
  const _RequestState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isCancelling;
  @override
  bool get isFetchingSingle;
  @override
  bool get isFetchingByDate;
  @override
  bool get validate;
  @override
  bool get canPay;
  @override
  ServiceRequest get request;
  @override
  MoneyMaskedTextController get amountTextController;
  @override
  KtList<ServiceRequest> get activeRequests;
  @override
  KtList<ServiceRequest> get history;
  @override
  KtList<InAppNotification> get notificationList;
  @override
  KtMap<DateTime, KtList<InAppNotification>> get notifications;
  @override
  DateTime? get selectedDate;
  @override
  Option<AppHttpResponse?> get status;
  @override
  @JsonKey(ignore: true)
  _$RequestStateCopyWith<_RequestState> get copyWith =>
      throw _privateConstructorUsedError;
}
