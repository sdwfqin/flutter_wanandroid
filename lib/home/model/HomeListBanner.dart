import 'package:flutter_wanandroid/home/model/HomeBanner.dart';
import 'package:json_annotation/json_annotation.dart';

/// flutter packages pub run build_runner build

part 'HomeListBanner.g.dart';

@JsonSerializable()
class HomeListBanner {
  List<HomeBanner> data;
  int errorCode;
  String errorMsg;

  HomeListBanner(this.data, this.errorCode, this.errorMsg);

  factory HomeListBanner.fromJson(Map<String, dynamic> json) =>
      _$HomeListBannerFromJson(json);

  Map<String, dynamic> toJson() => _$HomeListBannerToJson(this);
}
