library request_service_screen.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/features/dashboard/domain/domain.dart';
import 'package:washryte/features/dashboard/presentation/managers/index.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render RequestServiceScreen.
class RequestServiceScreen extends StatelessWidget with AutoRouteWrapper {
  const RequestServiceScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RequestCubit>(),
      child: BlocListener<RequestCubit, RequestState>(
        listenWhen: (p, c) =>
            p.status.getOrElse(() => null) != c.status.getOrElse(() => null) ||
            (c.status.getOrElse(() => null) != null && (c.status.getOrElse(() => null)!.response.maybeMap(orElse: () => false))),
        listener: (c, s) => s.status.fold(
          () => null,
          (it) => it?.response.map(
            info: (i) => PopupDialog.info(message: i.message, show: i.message.isNotEmpty).render(c),
            error: (f) => PopupDialog.error(message: f.message, show: f.show && f.message.isNotEmpty).render(c),
            success: (s) => PopupDialog.success(
              message: s.message,
              show: s.message.isNotEmpty,
              listener: (status) => status?.fold(
                dismissed: () {
                  if (s.pop && App.currentRoute != DashboardRoute.name) navigator.popUntilRoot();
                },
              ),
            ).render(c),
          ),
        ),
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      adaptiveToolbar: const AdaptiveToolbar(title: 'Request Service'),
      body: SingleChildScrollView(
        physics: Utils.physics,
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SizedBox(
          height: 1.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextFormInputLabel(text: 'Service Type', fontWeight: FontWeight.w600),
                //
                0.008.verticalh,
                //
                BlocSelector<RequestCubit, RequestState, ServiceType>(
                  selector: (s) => s.request.type,
                  builder: (c, type) => AdaptiveDropdown<ServiceType>(
                    hint: '-- Select Service Type --',
                    items: ServiceType.list,
                    text: (e) => '${e?.formatted}',
                    selected: type,
                    onChanged: c.read<RequestCubit>().typeChanged,
                  ),
                ),
                //
                0.015.verticalh,
                //
                const TextFormInputLabel(text: 'Item', fontWeight: FontWeight.w600),
                //
                0.008.verticalh,
                //
                ReactiveTextFormField<RequestCubit, RequestState>(
                  hintText: (s) => 'Enter Items',
                  disabled: (s) => s.isLoading,
                  validate: (s) => s.validate,
                  response: (s) => s.status,
                  field: (s) => s.request.items,
                  // errorField: (s) => s.errors?.amount,
                  focus: RequestState.itemsFocus,
                  keyboardType: TextInputType.text,
                  capitalization: TextCapitalization.sentences,
                  onChanged: (cubit, it) => cubit.itemsChanged(it),
                ),
                //
                0.015.verticalh,
                //
                const TextFormInputLabel(text: 'Address', fontWeight: FontWeight.w600),
                //
                0.008.verticalh,
                //
                ReactiveTextFormField<RequestCubit, RequestState>(
                  hintText: (s) => 'Where do you want to pick up the item?',
                  minLines: 3,
                  field: (s) => s.request.address,
                  validate: (s) => s.validate,
                  response: (s) => s.status,
                  disabled: (s) => s.isLoading,
                  focus: RequestState.addressFocus,
                  keyboardType: TextInputType.multiline,
                  action: TextInputAction.newline,
                  capitalization: TextCapitalization.sentences,
                  // errorField: (s) => s.errors?.amount,
                  autoFillHints: [
                    AutofillHints.addressCityAndState,
                    AutofillHints.streetAddressLevel1,
                    AutofillHints.streetAddressLevel2,
                    AutofillHints.streetAddressLevel3,
                    AutofillHints.streetAddressLevel4,
                  ],
                  onChanged: (cubit, it) => cubit.addressChanged(it),
                ),
                //
                const Spacer(),
                //
                SafeArea(
                  top: false,
                  left: false,
                  right: false,
                  child: BlocSelector<RequestCubit, RequestState, bool>(
                    selector: (s) => s.isLoading,
                    builder: (c, isLoading) => AppButton(
                      text: 'Send',
                      isLoading: isLoading,
                      onPressed: c.read<RequestCubit>().requestService,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
