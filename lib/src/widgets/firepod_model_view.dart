import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_models/wt_models.dart';

class FirepodModelView<T extends JsonSupport> extends StatelessWidget {
  final Query query;
  final T Function(DataSnapshot snapshot) snapshotToModel;
  final Widget Function(T model) itemBuilder;

  const FirepodModelView({
    super.key,
    required this.query,
    required this.snapshotToModel,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: query.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text(':-(');
        } else if (snapshot.hasData) {
          final model = snapshotToModel(snapshot.data!.snapshot);
          return itemBuilder(model);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
