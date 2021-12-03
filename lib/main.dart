library main.dart;

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:washryte/app.dart';
import 'package:washryte/config/env.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Add Google Fonts Licensing
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  try {
    // Initializes Hive with a valid directory in your app files.
    await Hive.initFlutter();
    await Hive.openBox<String>(Const.kAccessTokenBoxKey);
  } catch (e, trace) {
    log.e('Error initializing Hive', e, trace);
  }

  // Initialize Hydrated storage
  final storage = await HydratedStorage.build(
    storageDirectory: await Utils.cacheDir,
  );

  // Setup Environmental variables & Service provider
  await BuildEnvironment.init(flavor: BuildFlavor.prod);

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = getIt<FirebaseCrashlytics>().recordFlutterError;

  HydratedBlocOverrides.runZoned(
    () => runApp(const Washryte()),
    storage: storage,
  );
}
