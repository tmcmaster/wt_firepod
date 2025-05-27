import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';

mixin FirepodStateNotifierProviders<T> {
  StateNotifierProvider<GenericSiteDataNotifierBase<T>, T> get value;
}
