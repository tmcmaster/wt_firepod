import 'package:wt_firepod/wt_firepod.dart';

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
