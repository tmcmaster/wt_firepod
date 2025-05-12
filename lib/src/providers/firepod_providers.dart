import 'package:wt_firepod/src/models/site.dart';
import 'package:wt_firepod/src/providers/lists/firepod_list_object.dart';

mixin FirepodProviders {
  static final sitesList = FirepodListObject<Site>(
    name: 'Site List',
    path: '/v4/user/{user}/sites',
    decoder: Site.convert.from.dynamicMap.to.model,
    encoder: Site.convert.to.dynamicMap.from.model,
    idField: 'id',
    valueField: 'name',
  );
}
