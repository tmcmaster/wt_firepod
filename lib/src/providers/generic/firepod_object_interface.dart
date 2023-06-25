import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier_base.dart';

abstract class FirepodObjectInterface<T> {
  StateNotifierProvider<GenericSiteDataNotifierBase<T>, T> get value;
  AlwaysAliveRefreshable<GenericSiteDataNotifierBase<T>> get notifier;
}
