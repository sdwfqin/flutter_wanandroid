// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeListBanner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeListBanner _$HomeListBannerFromJson(Map<String, dynamic> json) {
  return HomeListBanner(
    (json['data'] as List<dynamic>)
        .map((e) => HomeBanner.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$HomeListBannerToJson(HomeListBanner instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
