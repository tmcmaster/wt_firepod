import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_models/wt_models.dart';

Future<void> normaliseOrderValue({
  required List<OrderTitleIdJsonSupport> list,
  required Ref ref,
  required String path,
  String? orderField,
}) async {
  final log = logger('Normalise Order Value', level: Level.warning);

  final sortedList = [...list];
  sortedList.sort((a, b) => a.getOrder().compareTo(b.getOrder()));
  final keys = sortedList.map((e) => e.getId()).toList();
  final database = ref.read(FirebaseProviders.database);

  final updateMap = <String, dynamic>{};
  for (int i = 0; i < keys.length; i++) {
    log.d('$path / ${keys[i]} / ${orderField ?? 'order'} / ${i + 1}');
    updateMap['${keys[i]}/${orderField ?? 'order'}'] = i + 1;
  }
  log.d(updateMap);
  await database.ref('v1/product').update(updateMap);
}
