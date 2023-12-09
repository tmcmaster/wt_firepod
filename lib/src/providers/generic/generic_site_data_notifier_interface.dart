abstract class GenericSiteDataNotifierInterface<T> {
  void load();
  void save();
  void update(T newValue);
  String? getPath();
}
