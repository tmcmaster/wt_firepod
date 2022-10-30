import 'package:wt_settings/wt_settings.dart';

import 'firepod_providers.dart';
import 'site/site.dart';

abstract class FirepodSettings {
  static final site = SettingsObjectProviders<Site?>(
    key: '__SITE__',
    label: 'Site',
    hint: 'Site to be managed.',
    listProvider: FirepodProviders.siteListProvider,
    none: Site.none,
    getId: (site) => site == null ? '' : site.id,
    getLabel: (site) => site == null ? '' : site.name,
  );
}
