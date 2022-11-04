import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:wt_firepod/src/widgets/list/firepod_list_tile.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_models/wt_models.dart';

class FirepodListView<T extends IdJsonSupport<T>> extends ConsumerWidget {
  final DatabaseReference Function(FirebaseDatabase database) table;
  final Query Function(DatabaseReference table) query;
  final T Function(DataSnapshot snapshot) snapshotToModel;
  final Widget Function(T model, BuildContext context) itemBuilder;
  final StateNotifierProvider<FirepodSelectedItems<T>, Set<T>> selection;
  final Map<String, ModelFormDefinition<dynamic>> formItemDefinitions;
  final T Function(Map<String, dynamic> json) mapToItem;
  final Map<String, dynamic> Function(T item) itemToMap;
  final void Function(T item)? onSelect;
  final bool canSelect;
  final bool canEdit;

  const FirepodListView({
    super.key,
    required this.table,
    required this.query,
    required this.snapshotToModel,
    required this.itemBuilder,
    required this.selection,
    required this.formItemDefinitions,
    required this.mapToItem,
    required this.itemToMap,
    this.onSelect,
    this.canSelect = false,
    this.canEdit = false,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.read(FirebaseProviders.database);
    final selectionNotifier = ref.read(selection.notifier);
    return FirebaseDatabaseListView(
      query: query(table(database)),
      itemBuilder: (context, snapshot) {
        final T model = snapshotToModel(snapshot);
        return FirepodListTile<T>(
          model: model,
          itemBuilder: (model) => itemBuilder(model, context),
          onDelete: (model) => _onDelete(model, table(database), context),
          onTap: (model) => onSelect?.call(model),
          onEdit: canEdit ? (model) => _onEdit(model, table(database), context) : null,
          onSelect: canSelect ? (model, isSelected) => _onSelect(model, isSelected, selectionNotifier) : null,
          initSelected: selectionNotifier.isSelected(model),
        );
      },
    );
  }

  void _onSelect(T model, bool selected, FirepodSelectedItems selection) {
    print('Selecting $model : $selected');
    if (selected) {
      selection.add(model);
    } else {
      selection.remove(model);
    }
  }

  void _onEdit(T model, DatabaseReference table, BuildContext context) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      animationType: DialogTransitionType.slideFromRight,
      alignment: Alignment.center,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add a new Website token'),
          ),
          body: ModelForm<T>(
            key: ValueKey('product ${model.getId()}'),
            item: model,
            mapToItem: mapToItem,
            itemToMap: itemToMap,
            formItemDefinitions: formItemDefinitions,
            onSubmit: (item) {
              print('onSubmit Edited: $item');
              _update(item, table);
            },
          ),
        );
      },
    );
  }

  void _onDelete(T model, DatabaseReference table, BuildContext context) {
    table.child(model.getId()).remove();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.white,
          onPressed: () => _update(model, table),
        ),
        content: Text('Deleted: $model'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _update(T model, DatabaseReference table) {
    print('_update Edited: $model');
    final key = model.getId();
    final ref = table.child(key);
    final itemMap = itemToMap(model);
    ref.set(itemMap);
  }
}
