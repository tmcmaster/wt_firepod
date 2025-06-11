import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/providers/firebase_providers.dart';
import 'package:wt_firepod/src/providers/firepod_providers.dart';
import 'package:wt_firepod/src/settings/firepod_settings.dart';
import 'package:wt_provider_manager/provider_manager.dart';

class FirepodProviderManager extends ProviderManager {
  static final provider = Provider(
    name: 'Firepod Provider Manager',
    (ref) => FirepodProviderManager(ref),
  );

  static final isReady = Provider((ref) => ref.read(provider).ready);

  FirepodProviderManager(super.ref)
      : super(
          name: 'Firepod Provider Manager',
          providerInitialisers: [
            FirebaseProviders.auth,
          ].toProviderInitialisers(),
          settingsInitialisers: [
            FirepodSettings.settingsProviders,
          ].toSettingsInitialisers(),
          databaseInitialisers: [
            FirepodProviders.sitesList.value,
          ].toDatabaseInitialisers(),
        );
}
