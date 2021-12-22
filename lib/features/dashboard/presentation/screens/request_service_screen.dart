library request_service_screen.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:washryte/core/presentation/index.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render RequestServiceScreen.
class RequestServiceScreen extends StatelessWidget with AutoRouteWrapper {
  const RequestServiceScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      adaptiveToolbar: const AdaptiveToolbar(
        implyMiddle: true,
        title: 'Request Service',
      ),
      body: SingleChildScrollView(
        physics: Utils.physics,
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SizedBox(
          height: 0.85.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextFormInputLabel(
                  text: 'Service Type',
                  fontWeight: FontWeight.w600,
                ),
                //
                0.008.verticalh,
                //
                DropdownFieldWidget<String?>(
                  hint: '-- Select Service Type --',
                  items: ['Pick Up only', 'Pick Up and Delivery'],
                  text: (e) => '$e',
                  selected: null,
                  onChanged: (val) {},
                ),
                //
                0.015.verticalh,
                //
                const TextFormInputLabel(
                  text: 'Item',
                  fontWeight: FontWeight.w600,
                ),
                //
                0.008.verticalh,
                //
                AdaptiveTextFormInput(
                  hintText: 'Enter item',
                  onChanged: (val) {},
                ),
                //
                0.015.verticalh,
                //
                const TextFormInputLabel(
                  text: 'Address',
                  fontWeight: FontWeight.w600,
                ),
                //
                0.008.verticalh,
                //
                AdaptiveTextFormInput(
                  minLines: 3,
                  maxLines: 4,
                  hintText: 'Where do you want to pick up the item?',
                  keyboardType: TextInputType.multiline,
                  action: TextInputAction.newline,
                  autoFillHints: [
                    AutofillHints.addressCityAndState,
                    AutofillHints.streetAddressLevel1,
                    AutofillHints.streetAddressLevel2,
                    AutofillHints.streetAddressLevel3,
                    AutofillHints.streetAddressLevel4,
                  ],
                  onChanged: (val) {},
                ),
                //
                const Spacer(),
                //
                AppButton(
                  text: 'Send',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
