// @dart=2.7

import 'dart:ui' as ui;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:progsynth/generated_plugin_registrant.dart';
import 'package:progsynth/main.dart' as entrypoint;

Future<void> main() async {
  registerPlugins(webPluginRegistry);
  await ui.webOnlyInitializePlatform();
  entrypoint.main();
}
