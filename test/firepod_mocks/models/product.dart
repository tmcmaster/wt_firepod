import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_models/wt_models.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product extends TitleIdJsonSupport<Product> with _$Product {
  static final Product none = Product(
    id: '',
    order: 0,
    price: 0.0,
    title: '',
    weight: 0.0,
  );

  factory Product({
    String? id,
    required int order,
    required double price,
    required String title,
    required double weight,
  }) = _Product;

  static final _titles = [
    'id',
    'order',
    'price',
    'title',
    'weight',
  ];

  Product._();

  static final from = ToModelFromFirebase<Product>(json: _$ProductFromJson, titles: _titles);
  static final to = FromModelTo<Product>(titles: _titles);

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  factory Product.fromJsonDynamic(Map<dynamic, dynamic> json) =>
      Product.fromJson(Map<String, dynamic>.from(json));

  @override
  String getId() => id ?? '';
  @override
  String getTitle() => title;
  @override
  Map<String, dynamic> toJson() => {};
}
