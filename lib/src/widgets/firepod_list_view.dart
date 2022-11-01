import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_models/wt_models.dart';

class FirepodListView<T extends JsonSupport> extends ConsumerWidget {
  final Query query;
  final T Function(DataSnapshot snapshot) snapshotToModel;
  final Widget Function(T model, BuildContext context, WidgetRef ref) itemBuilder;

  const FirepodListView({
    super.key,
    required this.query,
    required this.snapshotToModel,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.read(FirebaseProviders.database);
    return FirebaseDatabaseListView(
      query: database.ref('v1/product').orderByChild('id'),
      itemBuilder: (context, snapshot) {
        final T model = snapshotToModel(snapshot);
        return itemBuilder(model, context, ref);
      },
    );
  }
}
