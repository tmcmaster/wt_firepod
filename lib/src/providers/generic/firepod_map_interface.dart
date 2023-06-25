import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/providers/generic/generic_lookup_map.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier_base.dart';

abstract class FirepodMapInterface<T> {
  StateNotifierProvider<GenericSiteDataNotifierBase<GenericLookupMap<T>>, GenericLookupMap<T>>
      get value;
  AlwaysAliveRefreshable<GenericSiteDataNotifierBase<GenericLookupMap>> get notifier;
}
