import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_models/wt_models.dart';

class FirepodListDefinition<T extends IdJsonSupport<T>> {
  final StateNotifierProvider<FirepodSelectedItems<T>, Set<T>> selection =
      StateNotifierProvider<FirepodSelectedItems<T>, Set<T>>(
    (ref) => FirepodSelectedItems<T>(),
  );

  final DatabaseReference Function(FirebaseDatabase table) table;
  final Query Function(DatabaseReference table) query;
  final T Function(DataSnapshot snapshot) snapshotToModel;
  final Widget Function(T model, BuildContext context) itemBuilder;
  final Map<String, ModelFormDefinition<dynamic>> formItemDefinitions;
  final T Function(Map<String, dynamic> json) mapToItem;
  final Map<String, dynamic> Function(T item) itemToMap;

  FirepodListDefinition({
    required this.table,
    required this.query,
    required this.snapshotToModel,
    required this.itemBuilder,
    required this.formItemDefinitions,
    required this.mapToItem,
    required this.itemToMap,
  });

  Widget component({
    bool canSelect = false,
    bool canEdit = false,
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
    );
  }
}
