import 'package:firebase_database/firebase_database.dart';
import 'package:wt_firepod/src/widgets/firepod_value_view.dart';

class FirepodDoubleView extends FirepodValueView<double> {
  const FirepodDoubleView({
    super.key,
    required super.query,
    required super.itemBuilder,
  });

  @override
  double toValue(DataSnapshot snapshot) =>
      snapshot.exists && snapshot.value != null ? (snapshot.value! as num).toDouble() : 0.0;
}
