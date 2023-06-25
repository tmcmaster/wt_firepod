import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier.dart';

abstract class FirepodScalarInterface<T> {
  StateNotifierProvider<GenericSiteDataNotifier<T>, T> get value;
  AlwaysAliveRefreshable<GenericSiteDataNotifier<T>> get notifier;
}
