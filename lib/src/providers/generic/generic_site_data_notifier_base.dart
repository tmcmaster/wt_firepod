import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier_interface.dart';
import 'package:wt_provider_manager/provider_manager.dart';

abstract class GenericSiteDataNotifierBase<T> extends StateNotifier<T>
    implements GenericSiteDataNotifierInterface<T>, WaitForIsReadyProvider {
  GenericSiteDataNotifierBase(super.state);
}
