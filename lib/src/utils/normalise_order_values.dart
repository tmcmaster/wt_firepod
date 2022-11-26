import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_models/wt_models.dart';

void normaliseOrderValue({
  required List<OrderTitleIdJsonSupport> list,
  required Ref ref,
  required String path,
  String? orderField,
}) async {
  final sortedList = [...list];
  sortedList.sort((a, b) => a.getOrder().compareTo(b.getOrder()));
  final keys = sortedList.map((e) => e.getId()).toList();
  final database = ref.read(FirebaseProviders.database);

  final updateMap = <String, dynamic>{};
  for (int i = 0; i < keys.length; i++) {
    print('$path / ${keys[i]} / ${orderField ?? 'order'} / ${i + 1}');
    updateMap['${keys[i]}/${orderField ?? 'order'}'] = i + 1;
  }
  print(updateMap);
  await database.ref('v1/product').update(updateMap);
}
