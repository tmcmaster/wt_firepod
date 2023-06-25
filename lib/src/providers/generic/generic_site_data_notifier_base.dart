import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier_interface.dart';

abstract class GenericSiteDataNotifierBase<T> extends StateNotifier<T>
    implements GenericSiteDataNotifierInterface<T> {
  GenericSiteDataNotifierBase(super.state);
}
