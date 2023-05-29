// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realestate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealEstateResponse _$RealEstateResponseFromJson(Map<String, dynamic> json) =>
    RealEstateResponse(
      (json['realestates'] as List<dynamic>)
          .map((e) => RealEstateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RealEstateResponseToJson(RealEstateResponse instance) =>
    <String, dynamic>{
      'realestates': instance.realestates,
    };
