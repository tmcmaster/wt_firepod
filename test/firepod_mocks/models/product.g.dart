// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      id: json['id'] as String?,
      order: json['order'] as int,
      price: (json['price'] as num).toDouble(),
      title: json['title'] as String,
      weight: (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'price': instance.price,
      'title': instance.title,
      'weight': instance.weight,
    };
