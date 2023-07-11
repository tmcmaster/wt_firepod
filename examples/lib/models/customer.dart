import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_models/wt_models.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer extends BaseModel<Customer> with _$Customer {
  static final convert = DslConvert<Customer>(
    titles: ['id'],
    jsonToModel: Customer.fromJson,
    none: none,
  );

  static const none = Customer(
    id: '',
    name: '',
    phone: '',
    email: '',
    address: '',
    postcode: 0,
  );

  const factory Customer({
    @Default('') String id,
    @Default('') String name,
    @Default('') String phone,
    @Default('') String email,
    @Default('') String address,
    @Default(0) int postcode,
  }) = _Customer;

  const Customer._();

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  @override
  String getId() => id;

  @override
  String getTitle() => name;

  @override
  List<String> getTitles() => convert.titles();
}
