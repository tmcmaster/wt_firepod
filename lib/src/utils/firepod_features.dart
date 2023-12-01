import 'package:wt_app_scaffold/app_platform/model/app_scaffold_feature_definition.dart';
import 'package:wt_firepod/src/init/features/firebase_feature_definition.dart';
import 'package:wt_firepod/src/init/features/firebase_login_feature_definition.dart';

mixin FirepodFeatures {
  static bool isFirebaseAvailable() {
    return AppScaffoldFeatureDefinition.isFeatureAvailable(
      FirebaseFeatureDefinition,
    );
  }

  static bool isFirebaseLoginAvailable() {
    return AppScaffoldFeatureDefinition.isFeatureAvailable(
      FirebaseLoginFeatureDefinition,
    );
  }
}
