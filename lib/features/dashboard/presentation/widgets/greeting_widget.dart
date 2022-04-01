library greeting_widget.dart;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render GreetingWidget.
class GreetingWidget extends StatelessWidget {
  final String greeting;

  const GreetingWidget({Key? key, this.greeting = 'Hello,'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthWatcherCubit, AuthWatcherState, User?>(
      selector: (s) => s.user,
      builder: (c, user) => Row(
        children: [
          ImageBox.network(
            heroTag: '${UniqueId.v4().value}--${user?.photo.getOrNull}',
            photo: user?.photo.getOrNull,
            width: 0.13.w,
            height: 0.13.w,
            elevation: 3,
            borderRadius: 100.br,
            applyConstraintToReplacement: true,
            replacement: Image.asset(AppAssets.unnamed),
          ),
          //
          0.04.horizontalw,
          //
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdaptiveText(
                greeting,
                maxLines: 1,
                fontSize: 17.sp,
                maxFontSize: 17,
                fontWeight: FontWeight.w400,
                letterSpacing: Utils.letterSpacing,
              ),
              AdaptiveText(
                '${user?.fullName.getOrEmpty}',
                maxLines: 1,
                fontSize: 18.sp,
                maxFontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: Utils.letterSpacing,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
