import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_models/wt_models.dart';

part 'supplier.freezed.dart';
part 'supplier.g.dart';

@freezed
class Supplier extends BaseModel<Supplier> with _$Supplier {
  static final convert = DslConvert<Supplier>(
    titles: ['id'],
    jsonToModel: Supplier.fromJson,
    none: none,
  );

  static const none = Supplier(
    id: '',
    name: '',
    code: '',
  );

  const factory Supplier({
    @Default('') String id,
    @Default('') String name,
    @Default('') String code,
  }) = _Supplier;

  const Supplier._();

  factory Supplier.fromJson(Map<String, dynamic> json) => _$SupplierFromJson(json);

  @override
  String getId() => id;

  @override
  String getTitle() => name;

  @override
  List<String> getTitles() => convert.titles();
}
