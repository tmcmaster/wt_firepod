import 'package:wt_models/wt_models.dart';

// TODO: investigate moving back to not needing Site too be in this package.
class Site extends BaseModel<Site> {
  static final convert = DslConvert<Site>(
    titles: ['id', 'name'],
    jsonToModel: Site.fromJson,
    none: none,
  );
  static final Site none = Site(id: '', name: '-- select a site --');
  final String id;
  final String name;

  Site({required this.id, required this.name});

  @override
  String toString() => 'Site(id: $id, name: $name)';

  @override
  String getId() => id;

  @override
  String getTitle() => name;

  @override
  List<String> getTitles() => convert.titles();

  @override
  Map<String, dynamic> toJson() => convert.from.model.to.jsonMap(this);

  factory Site.fromJson(JsonMap json) => Site(
        id: (json['id'] ?? '') as String,
        name: (json['name'] ?? '') as String,
      );
}
