import 'package:firebase_core/firebase_core.dart';
import 'package:wt_app_scaffold/app_platform/features/app_scaffold_login_feature.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_feature_definition.dart';
import 'package:wt_firepod/src/init/features/firebase_feature_definition.dart';
import 'package:wt_firepod/src/init/features/firebase_login_feature_definition.dart';

const andFirebase = withFirebase;

AppScaffoldFeatureDefinition withFirebase(
  AppScaffoldFeatureDefinition childFeature, {
  required String appName,
  required FirebaseOptions firebaseOptions,
  bool crashlytics = false,
  bool database = false,
  bool storage = false,
}) {
  return FirebaseFeatureDefinition(
    childFeature,
    appName: appName,
    firebaseOptions: firebaseOptions,
    auth: true,
    crashlytics: crashlytics,
    database: database,
    storage: storage,
  );
}

const andFirebaseLogin = withFirebaseLogin;

AppScaffoldFeatureDefinition withFirebaseLogin(
  AppScaffoldFeatureDefinition child, {
  bool googleEnabled = false,
  bool emailEnabled = false,
  bool appleEnabled = false,
  bool emailLinkEnabled = false,
}) {
  return AppScaffoldLoginFeature(
    FirebaseLoginFeatureDefinition(
      child,
      googleEnabled: googleEnabled,
      emailEnabled: emailEnabled,
      appleEnabled: appleEnabled,
      emailLinkEnabled: emailLinkEnabled,
    ),
  );
}
