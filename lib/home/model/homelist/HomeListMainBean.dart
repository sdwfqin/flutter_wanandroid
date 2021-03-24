import 'package:flutter_wanandroid/home/model/homelist/HomeListDataBean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'HomeListMainBean.g.dart';

@JsonSerializable()
class HomeListMainBean {
  late HomeListDataBean data;
  late int errorCode;
  late String errorMsg;

  HomeListMainBean(this.data, this.errorCode, this.errorMsg);

  @override
  String toString() {
    return 'HomeListMainBean{data: $data, errorCode: $errorCode, errorMsg: $errorMsg}';
  }

  factory HomeListMainBean.fromJson(Map<String, dynamic> json) => _$HomeListMainBeanFromJson(json);

  Map<String,dynamic> toJson() => _$HomeListMainBeanToJson(this);
}
