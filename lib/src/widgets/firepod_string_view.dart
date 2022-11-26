import 'package:firebase_database/firebase_database.dart';

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
