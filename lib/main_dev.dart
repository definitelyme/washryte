library main_dev.dart;

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:washryte/app.dart';
import 'package:washryte/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  await BuildEnvironment.init(flavor: BuildFlavor.dev);

  // runApp(ProviderScope(
  //   child: DevicePreview(
  //     isToolbarVisible: true,
  //     enabled: env.flavor.fold(
  //       prod: () => !kReleaseMode,
  //       dev: () => true,
  //     ),
  //     tools: [
  //       ...DevicePreview.defaultTools,
  //     ],
  //     builder: (_) => const washryte(),
  //   ),
  // ));

  HydratedBlocOverrides.runZoned(
    () => runApp(const Washryte()),
    storage: storage,
  );
}
