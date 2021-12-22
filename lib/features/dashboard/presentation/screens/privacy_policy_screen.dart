library privacy_policy_screen.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// A stateless widget to render PrivacyPolicyScreen.
class PrivacyPolicyScreen extends StatelessWidget with AutoRouteWrapper {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Screen Template for PrivacyPolicyScreen'),
      ),
    );
  }
}
