// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeListMainBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeListMainBean _$HomeListMainBeanFromJson(Map<String, dynamic> json) {
  return HomeListMainBean(
    HomeListDataBean.fromJson(json['data'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$HomeListMainBeanToJson(HomeListMainBean instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
