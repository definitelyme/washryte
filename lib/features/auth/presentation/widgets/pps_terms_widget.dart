library pps_terms_widget.dart;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

class PPsTermsWidget extends StatelessWidget {
  const PPsTermsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveText.rich(
      TextSpan(children: [
        const TextSpan(
          text: 'By signing up, you agree to our ',
        ),
        //
        TextSpan(
          text: 'Terms of Service',
          style: const TextStyle(fontWeight: FontWeight.w600),
          recognizer: TapGestureRecognizer()..onTap = () {},
        ),
        //
        const TextSpan(
          text: ' & ',
        ),
        //
        TextSpan(
          text: 'Privacy Policy.',
          style: const TextStyle(fontWeight: FontWeight.w600),
          recognizer: TapGestureRecognizer()..onTap = () {},
        ),
      ]),
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: Utils.letterSpacing,
    );
  }
}
