library notification_page.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render NotificationPage.
class NotificationPage extends StatelessWidget with AutoRouteWrapper {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      adaptiveToolbar: const AdaptiveToolbar(title: 'Notifications', implyMiddle: true),
      body: Center(
        child: Text('Screen Template for NotificationPage'),
      ),
    );
  }
}
