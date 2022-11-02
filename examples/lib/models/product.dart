import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_models/wt_models.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product, JsonSupport, IdSupport<Product> {
  static final from = ToModelFromFirebase<Product>(json: _Product.fromJson, titles: _titles);
  static final to = FromModelTo<Product>(titles: _titles);

  static final _titles = ['id', 'title', 'price', 'weight'];

  factory Product({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'price') required double price,
    @JsonKey(name: 'weight') required double weight,
  }) = _Product;

  Product._();

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  @override
  String getId() => id ?? '';
}
