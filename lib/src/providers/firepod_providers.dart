import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_firepod/src/models/site.dart';
import 'package:wt_firepod/src/providers/maps/firepod_map_string.dart';

mixin FirepodProviders {
  static final sitesList = FirepodMapString(
    name: 'Sites',
    path: '/data/{user}/sites',
    watch: true,
    autoSave: false,
  );
  static final siteListProvider = StateNotifierProvider<SiteListNotifier, List<Site>?>(
    name: 'siteListProvider',
    (ref) => SiteListNotifier(ref),
  );
}

// TODO: need to look at being able to get a list of objects with FirepodListObject
class SiteListNotifier extends StateNotifier<List<Site>> {
  SiteListNotifier(Ref ref) : super([]) {
    ref.listen(FirepodProviders.sitesList.value, (previous, next) {
      state = next.map.entries.map((e) => Site(id: e.key, name: e.value)).toList();
    });
  }
}
