import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter/gestures.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_models/wt_models.dart';

class SelectedItems<T extends IdSupport> extends StateNotifier<Set<T>> {
  SelectedItems() : super({});

  void add(T item) {
    state = {...state, item};
  }

  void remove(T item) {
    state = {...state..remove(item)};
  }
}

class FirepodEditableListView<T extends IdJsonSupport> extends FirebaseDatabaseQueryBuilder {
  FirepodEditableListView({
    Key? key,
    required DatabaseReference table,
    required Query Function(DatabaseReference table) query,
    required T Function(DataSnapshot snapshot) snapshotToModel,
    required Widget Function(T model, BuildContext context) itemBuilder,
    required SelectedItems<T> selection,
    bool canDelete = false,
    int pageSize = 10,
    FirebaseLoadingBuilder? loadingBuilder,
    FirebaseErrorBuilder? errorBuilder,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    Widget? prototypeItem,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
  }) : super(
          key: key,
          query: query(table),
          pageSize: pageSize,
          builder: (context, snapshot, _) {
            if (snapshot.isFetching) {
              return loadingBuilder?.call(context) ?? const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError && errorBuilder != null) {
              return errorBuilder(
                context,
                snapshot.error!,
                snapshot.stackTrace!,
              );
            }

            return Consumer(
              builder: (context, ref, _) {
                return ListView.builder(
                  itemCount: snapshot.docs.length,
                  itemBuilder: (context, index) {
                    final isLastItem = index + 1 == snapshot.docs.length;
                    if (isLastItem && snapshot.hasMore) snapshot.fetchMore();
                    final doc = snapshot.docs[index];
                    final T model = snapshotToModel(doc);
                    return FirepodListTile(
                      model: model,
                      itemBuilder: itemBuilder,
                      onDelete: () {
                        table.child(model.getId()).remove();
                      },
                      onTap: () {
                        print(model.getId());
                        selection.add(model);
                      },
                    );
                  },
                  scrollDirection: scrollDirection,
                  reverse: reverse,
                  controller: controller,
                  primary: primary,
                  physics: physics,
                  shrinkWrap: shrinkWrap,
                  padding: padding,
                  itemExtent: itemExtent,
                  prototypeItem: prototypeItem,
                  addAutomaticKeepAlives: addAutomaticKeepAlives,
                  addRepaintBoundaries: addRepaintBoundaries,
                  addSemanticIndexes: addSemanticIndexes,
                  cacheExtent: cacheExtent,
                  semanticChildCount: semanticChildCount,
                  dragStartBehavior: dragStartBehavior,
                  keyboardDismissBehavior: keyboardDismissBehavior,
                  restorationId: restorationId,
                  clipBehavior: clipBehavior,
                );
              },
            );
          },
        );
}

class FirepodListTile<T extends IdJsonSupport> extends StatelessWidget {
  final T model;
  final Widget Function(T model, BuildContext context) itemBuilder;
  final void Function()? onDelete;
  final void Function()? onTap;

  const FirepodListTile({
    super.key,
    required this.model,
    required this.itemBuilder,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final item = itemBuilder(model, context);
    final tile = onDelete == null
        ? item
        : Dismissible(
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              onDelete!.call();
            },
            key: ValueKey(model.getId()),
            child: item,
          );
    return onTap == null
        ? tile
        : GestureDetector(
            onTap: onTap,
            child: tile,
          );
  }
}
