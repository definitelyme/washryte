import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:washryte/config/secrets.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';

enum BuildFlavor { prod, staging, dev }

BuildEnvironment get env => _env!;
BuildEnvironment? _env;

class BuildEnvironment implements Secrets {
  final Uri? baseUri;
  final BuildFlavor flavor;

  BuildEnvironment._({
    this.flavor = BuildFlavor.dev,
    this.baseUri,
  });

  factory BuildEnvironment.factory({
    BuildFlavor? flavor,
    Uri? uri,
  }) =>
      BuildEnvironment._(
        flavor: flavor!,
        baseUri: uri,
      );

  String get googleMapsAPI => Utils.platform_(material: Secrets.androidAPIKey, cupertino: Secrets.iOSAPIKey)!;

  String get pusherAppId => Secrets.pusherAppId;
  String get pusherAuthUrl => EndPoints.PUSHER_AUTH_URL;
  String get pusherCluster => Secrets.pusherCluster;
  String get pusherKey => Secrets.pusherKey;
  Duration get splashDuration => flavor.fold(
        dev: () => const Duration(milliseconds: 1500),
        prod: () => const Duration(milliseconds: 2000),
      );

  String get twitterAPIKey => Secrets.twitterAPIKey;
  String get twitterAPISecretKey => Secrets.twitterAPISecretKey;
  String get twitterRedirectUrl => Secrets.twitterRedirectUrl;

  /// Sets up the top-level [env] getter on the first call only.
  static Future<void> init({@required BuildFlavor? flavor}) async {
    _env ??= BuildEnvironment.factory(
      flavor: flavor,
      uri: Uri.https(EndPoints.APP_DOMAIN, EndPoints.API_ENDPOINT),
    );

    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    await flavor?.fold(
      dev: () async {
        await locator(Environment.dev);
        await getIt<FirebaseCrashlytics>().setCrashlyticsCollectionEnabled(false);
      },
      staging: () async {
        await locator(Environment.prod);
        await getIt<FirebaseCrashlytics>().setCrashlyticsCollectionEnabled(true);
      },
      prod: () async {
        await locator(Environment.prod);
        await getIt<FirebaseCrashlytics>().setCrashlyticsCollectionEnabled(true);
      },
    );
  }
}

extension XBuildFlavor on BuildFlavor {
  U fold<U>({
    U Function()? dev,
    U Function()? staging,
    required U Function() prod,
  }) {
    switch (this) {
      case BuildFlavor.dev:
        return dev?.call() ?? prod.call();
      case BuildFlavor.staging:
        return staging?.call() ?? prod.call();
      case BuildFlavor.prod:
      default:
        return prod.call();
    }
  }
}
