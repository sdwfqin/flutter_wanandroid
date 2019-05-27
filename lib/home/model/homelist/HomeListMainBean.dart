import 'package:flutter_wanandroid/home/model/homelist/HomeListDataBean.dart';
import 'package:json_annotation/json_annotation.dart';

/// flutter packages pub run build_runner build

part 'HomeListMainBean.g.dart';

@JsonSerializable()
class HomeListMainBean {
  HomeListDataBean data;
  int errorCode;
  String errorMsg;

  HomeListMainBean(this.data, this.errorCode, this.errorMsg);

  //不同的类使用不同的mixin即可
  factory HomeListMainBean.fromJson(Map<String, dynamic> json) =>
      _$HomeListMainBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeListMainBeanToJson(this);
}
