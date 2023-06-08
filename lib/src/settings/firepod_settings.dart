import 'package:wt_settings/wt_settings.dart';

import '../models/site.dart';
import '../providers/firepod_providers.dart';

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
