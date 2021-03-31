import 'package:flutter_wanandroid/model/banner/home_banner.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_list_banner.g.dart';

@JsonSerializable()
class HomeListBanner {
  late List<HomeBanner> data;
  late int errorCode;
  late String errorMsg;

  HomeListBanner(this.data, this.errorCode, this.errorMsg);

  @override
  String toString() {
    return 'HomeListBanner{data: $data, errorCode: $errorCode, errorMsg: $errorMsg}';
  }

  factory HomeListBanner.fromJson(Map<String, dynamic> json) => _$HomeListBannerFromJson(json);

  Map<String,dynamic> toJson() => _$HomeListBannerToJson(this);
}
