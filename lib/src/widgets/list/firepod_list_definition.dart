import 'package:wt_firepod/src/notifiers/firepod_list_notifier.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_models/wt_models.dart';

class FirepodListDefinition<T extends TitleIdJsonSupport<T>> {
  final StateNotifierProvider<FirepodSelectedItems<T>, Set<T>> selection =
      StateNotifierProvider<FirepodSelectedItems<T>, Set<T>>(
    (ref) => FirepodSelectedItems<T>(),
  );

  late StateNotifierProvider<FirepodListNotifier<T>, List<T>> provider;

  late DatabaseReference Function(FirebaseDatabase table) table;
  late Query Function(DatabaseReference table) query;
  final T Function(DataSnapshot snapshot) snapshotToModel;
  final Widget Function(T model, BuildContext context) itemBuilder;
  final Map<String, ModelFormDefinition<dynamic>> formItemDefinitions;
  final T Function(Map<String, dynamic> json) mapToItem;
  final Map<String, dynamic> Function(T item) itemToMap;
  final List<T> Function(DataSnapshot snapshot) snapshotToList;
  final int Function(T a, T b)? sortWith;

  FirepodListDefinition({
    required String path,
    String? orderBy,
    String? equalTo,
    required this.snapshotToModel,
    required this.itemBuilder,
    required this.formItemDefinitions,
    required this.mapToItem,
    required this.itemToMap,
    required this.snapshotToList,
    required this.sortWith,
  }) {
    table = (database) => database.ref(path);
    query = (table) => orderBy == null
        ? table
        : equalTo == null
            ? table.orderByChild(orderBy)
            : table.orderByChild(orderBy).equalTo(equalTo);

    provider = StateNotifierProvider<FirepodListNotifier<T>, List<T>>(
      name: 'orderedProductListProvider',
      (ref) => FirepodListNotifier<T>(
        ref,
        snapshotList: snapshotToList,
        table: table,
        sortWith: sortWith,
      ),
    );
  }

  Widget component({
    bool canSelect = false,
    bool canEdit = false,
    bool canReorder = false,
    void Function(T item)? onSelect,
  }) {
    return FirepodListView<T>(
      table: table,
      query: query,
      snapshotToModel: snapshotToModel,
      mapToItem: mapToItem,
      itemToMap: itemToMap,
      formItemDefinitions: formItemDefinitions,
      itemBuilder: (model, context) => itemBuilder(model, context),
      selection: selection,
      canSelect: canSelect,
      canEdit: canEdit,
      onSelect: onSelect,
      canReorder: canReorder,
    );
  }
}
