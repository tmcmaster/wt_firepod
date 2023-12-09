import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier_base.dart';

class FirepodMock<T> extends GenericSiteDataNotifierBase<T> {
  FirepodMock(super.state);
  @override
  void load() {}

  @override
  void save() {}

  @override
  void update(T newValue) {}

  @override
  String? getPath() => null;
}
