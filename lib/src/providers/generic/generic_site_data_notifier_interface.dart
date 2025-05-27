abstract class GenericSiteDataNotifierInterface<T> {
  Future<void> load();
  Future<void> save();
  Future<void> update(T newValue);
  String? getPath();
}
