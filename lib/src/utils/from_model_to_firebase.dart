import 'package:wt_models/wt_models.dart';

class FromModelToFirebase<T extends IdJsonSupport<T>> extends FromModelTo<T> {
  final String idField;

  FromModelToFirebase({
    super.titles,
    this.idField = 'id',
  });

  Map<String, dynamic> firebaseMap(T model) {
    final jsonMap = super.jsonFromModel(model);
    jsonMap.remove(idField);
    return jsonMap;
  }
}
