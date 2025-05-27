import 'package:wt_app_scaffold/models/app_scaffold_typedefs.dart';
import 'package:wt_firepod/src/models/site.dart';
import 'package:wt_firepod/src/providers/firepod_providers.dart';
import 'package:wt_settings/wt_settings.dart';

mixin FirepodSettings {
  static final AppScaffoldSettingsMapProviders settingsProviders = {
    'Firepod': [
      site,
    ],
  };
  static final site = SettingsObjectProviders<Site>(
    key: '__SITE__',
    label: 'Site',
    hint: 'Site to be managed.',
    listProvider: FirepodProviders.sitesList.value,
    none: Site.none,
    getId: (site) => site.id,
    getLabel: (site) => site.name,
  );
}
