import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:wt_firepod/src/widgets/list/firepod_list_tile.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_models/wt_models.dart';

class SelectedItems<T extends IdSupport> extends StateNotifier<Set<T>> {
  SelectedItems() : super({});

  bool isSelected(T item) {
    return state.contains(item);
  }

  void add(T item) {
    state = {...state, item};
    print(state);
  }

  void remove(T item) {
    state = {...state..remove(item)};
    print(state);
  }
}

class FirepodListView<T extends IdJsonSupport> extends StatelessWidget {
  final DatabaseReference table;
  final Query Function(DatabaseReference table) query;
  final T Function(DataSnapshot snapshot) snapshotToModel;
  final Widget Function(T model, BuildContext context) itemBuilder;
  final SelectedItems<T> selection;
  final Map<String, ModelFormDefinition<dynamic>> formItemDefinitions;
  final T Function(Map<String, dynamic> json) mapToItem;
  final Map<String, dynamic> Function(T item) itemToMap;

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
  });
  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseListView(
      query: query(table),
      itemBuilder: (context, snapshot) {
        final T model = snapshotToModel(snapshot);
        return FirepodListTile<T>(
          model: model,
          itemBuilder: itemBuilder,
          onDelete: onDelete,
          onTap: onTap,
          onEdit: onEdit,
          onSelect: onSelect,
          initSelected: selection.isSelected(model),
        );
      },
    );
  }

  void onSelect(T model, bool selected, BuildContext context) {
    print('Selecting $model : $selected');
    if (selected) {
      selection.add(model);
    } else {
      selection.remove(model);
    }
  }

  void onEdit(T model, BuildContext context) {
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
              print(item);
            },
          ),
        );
      },
    );
  }

  void onDelete(T model, BuildContext context) {
    table.child(model.getId()).remove();
    // TODO: need to add a toast with notification of delete, and an undo option.
  }

  void onTap(T model, BuildContext context) {}
}
