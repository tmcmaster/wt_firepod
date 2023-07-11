import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_models/wt_models.dart';

part 'driver.freezed.dart';
part 'driver.g.dart';

@freezed
class Driver extends BaseModel<Driver> with _$Driver {
  static final convert = DslConvert<Driver>(
    titles: ['id'],
    jsonToModel: Driver.fromJson,
    none: none,
  );

  static const none = Driver(
    id: '',
    name: '',
    phone: '',
  );

  const factory Driver({
    @Default('') String id,
    @Default('') String name,
    @Default('') String phone,
  }) = _Driver;

  const Driver._();

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  @override
  String getId() => id;

  @override
  String getTitle() => name;

  @override
  List<String> getTitles() => convert.titles();
}
