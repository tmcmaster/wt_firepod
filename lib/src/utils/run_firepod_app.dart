import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
import 'package:wt_firepod/src/init/firebase_dsl.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_provider_manager/provider_manager.dart';

mixin FirepodApp {
  static void runWithFirebase({
    required Widget appWidget,
    required String appName,
    required FirebaseOptions firebaseOptions,
    bool crashlytics = false,
    bool database = true,
    bool storage = false,
    void Function()? onReady,
    List<Override> includeOverrides = const [],
    Provider<ProviderManager>? providerManager,
    Level setApplicationLogLevel = Level.warning,
    Map<Type, Level> setLogLevels = const {},
    bool devicePreview = false,
    bool enableProviderMonitoring = false,
    double devicePreviewMinimumWidth = 500,
    List<ProviderObserver>? includeObservers,
    Widget? splashWidget,
    double? virtualSize,
    bool enableErrorMonitoring = false,
  }) {
    runMyApp(
      withFirebase(
        asPlainApp(appWidget),
        appName: appName,
        firebaseOptions: firebaseOptions,
        database: database,
        storage: storage,
        crashlytics: crashlytics,
      ),
      setApplicationLogLevel: setApplicationLogLevel,
      setLogLevels: setLogLevels,
      includeOverrides: includeOverrides,
      onReady: (_, __) {},
      enableErrorMonitoring: enableErrorMonitoring,
      providerManager: providerManager,
      devicePreview: devicePreview,
      devicePreviewMinimumWidth: devicePreviewMinimumWidth,
      enableProviderMonitoring: enableProviderMonitoring,
      includeObservers: includeObservers,
      splashWidget: splashWidget,
      virtualSize: virtualSize,
    );
  }

  static void runWithAuth({
    required Widget appWidget,
    required String appName,
    required FirebaseOptions firebaseOptions,
    bool crashlytics = false,
    bool database = true,
    bool storage = false,
    void Function()? onReady,
    List<Override> includeOverrides = const [],
    Provider<ProviderManager>? providerManager,
    Level setApplicationLogLevel = Level.warning,
    Map<Type, Level> setLogLevels = const {},
    bool devicePreview = false,
    bool enableProviderMonitoring = false,
    double devicePreviewMinimumWidth = 500,
    List<ProviderObserver>? includeObservers,
    Widget? splashWidget,
    double? virtualSize,
    bool enableErrorMonitoring = false,
  }) {
    runMyApp(
      withFirebase(
        andAuthGateway(
          asPlainApp(appWidget),
          emailEnabled: true,
        ),
        appName: appName,
        firebaseOptions: firebaseOptions,
        database: database,
        storage: storage,
        crashlytics: crashlytics,
      ),
      setApplicationLogLevel: setApplicationLogLevel,
      setLogLevels: setLogLevels,
      includeOverrides: includeOverrides,
      onReady: (_, __) {},
      enableErrorMonitoring: enableErrorMonitoring,
      providerManager: providerManager,
      devicePreview: devicePreview,
      devicePreviewMinimumWidth: devicePreviewMinimumWidth,
      enableProviderMonitoring: enableProviderMonitoring,
      includeObservers: includeObservers,
      splashWidget: splashWidget,
      virtualSize: virtualSize,
    );
  }
}
