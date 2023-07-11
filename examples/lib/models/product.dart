import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_models/wt_models.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product extends BaseModel<Product> with _$Product, OrderSupport {
  static final convert = DslConvert<Product>(
    titles: ['id'],
    jsonToModel: Product.fromJson,
    none: none,
  );

  static const none = Product(
    id: '',
    title: '',
    order: 0,
    price: 0.0,
    weight: 0.0,
  );

  const factory Product({
    @Default('') String id,
    @Default('') String title,
    @Default(0.0) double order,
    @Default(0.0) double price,
    @Default(0.0) double weight,
  }) = _Product;

  const Product._();

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  @override
  String getId() => id;

  @override
  String getTitle() => title;

  @override
  double getOrder() => order;

  @override
  List<String> getTitles() => convert.titles();
}
