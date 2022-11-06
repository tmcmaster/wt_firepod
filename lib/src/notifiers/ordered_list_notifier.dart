import 'dart:async';

import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_models/wt_models.dart';

class OrderedListNotifier<T extends OrderTitleIdJsonSupport<T>> extends StateNotifier<List<T>> {
  final Ref ref;

  List<T> Function(DataSnapshot snapshot) snapshotList;
  String path;

  late StreamSubscription _subscription;

  OrderedListNotifier(
    this.ref, {
    required this.snapshotList,
    required this.path,
  }) : super([]) {
    final database = ref.read(FirebaseProviders.database);
    _subscription = database.ref(path).onValue.listen((event) {
      // print('Event ${event.type}');

      final newState = snapshotList(event.snapshot);
      newState.sort((a, b) => a.getOrder().compareTo(b.getOrder()));
      state = newState;
    });
  }

  Future<void> refresh() async {
    final database = ref.read(FirebaseProviders.database);
    final snapshot = await database.ref(path).get();
    final newState = snapshotList(snapshot);
    newState.sort((a, b) => a.getOrder().compareTo(b.getOrder()));
    state = newState;
  }

  void normaliseOrderValue() async {
    await refresh();
    final keys = state.map((e) => e.getId()).toList();
    print('keys: $keys');
    final database = ref.read(FirebaseProviders.database);
    for (int i = 0; i < keys.length; i++) {
      database.ref('v1/product').child(keys[i]).child('order').set(i + 1);
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class IdOrder {
  final id;
  final order;

  IdOrder(this.id, this.order);
}
