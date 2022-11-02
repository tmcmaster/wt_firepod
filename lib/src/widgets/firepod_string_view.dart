import 'package:wt_firepod/wt_firepod.dart';

import 'firepod_value_view.dart';

class FirepodStringView extends FirepodValueView<String> {
  const FirepodStringView({
    super.key,
    required super.query,
    required super.itemBuilder,
  });

  @override
  String toValue(DataSnapshot snapshot) => snapshot.value.toString();
}
