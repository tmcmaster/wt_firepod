import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_models/wt_models.dart';

void normaliseOrderValue(
    {required List<OrderTitleIdJsonSupport> list, required Ref ref, required String path, String? orderField}) async {
  final sortedList = [...list];
  sortedList.sort((a, b) => a.getOrder().compareTo(b.getOrder()));
  final keys = sortedList.map((e) => e.getId()).toList();
  final database = ref.read(FirebaseProviders.database);
  for (int i = 0; i < keys.length; i++) {
    await database.ref(path).child(keys[i]).child(orderField ?? 'order').set(i + 1);
  }
}
