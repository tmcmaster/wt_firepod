import 'package:riverpod/src/provider.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier_base.dart';

class FirepodMock<T> extends GenericSiteDataNotifierBase<T> {
  FirepodMock(super.state);
  @override
  Future<void> load() async {}

  @override
  Future<void> save() async {}

  @override
  Future<void> update(T newValue) async {}

  @override
  String? getPath() => null;

  @override
  Provider<Future> get isReady => throw UnimplementedError();
}
