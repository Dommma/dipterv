// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salesman_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesmanResponse _$SalesmanResponseFromJson(Map<String, dynamic> json) =>
    SalesmanResponse(
      (json['salesmans'] as List<dynamic>)
          .map((e) => SalesmanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SalesmanResponseToJson(SalesmanResponse instance) =>
    <String, dynamic>{
      'salesmans': instance.salesmans,
    };
