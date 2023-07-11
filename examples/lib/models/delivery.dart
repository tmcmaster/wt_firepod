import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_firepod_examples/models/customer.dart';
import 'package:wt_firepod_examples/models/driver.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/models/product.dart';
import 'package:wt_models/wt_models.dart';

part 'delivery.freezed.dart';
part 'delivery.g.dart';

@freezed
class Delivery extends BaseModel<Delivery> with _$Delivery {
  static final convert = DslConvert<Delivery>(
    titles: ['id'],
    jsonToModel: Delivery.fromJson,
    none: none,
  );

  static const none = Delivery(
    id: '',
    customer: Customer.none,
    driver: Driver.none,
    products: [],
  );

  const factory Delivery({
    @Default('') String id,
    @Default(Customer.none) Customer customer,
    @Default(Driver.none) Driver driver,
    @Default([]) List<Product> products,
  }) = _Delivery;

  const Delivery._();

  factory Delivery.fromJson(Map<String, dynamic> json) => _$DeliveryFromJson(json);

  @override
  String getId() => id;

  @override
  String getTitle() => customer.name;

  @override
  List<String> getTitles() => convert.titles();
}
