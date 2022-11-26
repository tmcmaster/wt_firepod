import 'package:firebase_database/firebase_database.dart';

import 'firepod_value_view.dart';

class FirepodDoubleView extends FirepodValueView<double> {
  const FirepodDoubleView({
    super.key,
    required super.query,
    required super.itemBuilder,
  });

  @override
  double toValue(DataSnapshot snapshot) => (snapshot.value as num).toDouble();
}
