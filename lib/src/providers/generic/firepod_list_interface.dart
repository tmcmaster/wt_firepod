import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier.dart';

abstract class FirepodListInterface<M> {
  StateNotifierProvider<GenericSiteDataNotifier<List<M>>, List<M>> get value;
  AlwaysAliveRefreshable<GenericSiteDataNotifier<List<M>>> get notifier;
}
