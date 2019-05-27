import 'package:json_annotation/json_annotation.dart';

/// flutter packages pub run build_runner build
part 'HomeBanner.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class HomeBanner {
  int id;
  String title;
  String desc;
  String imagePath;
  int isVisible;
  int order;
  int type;
  String url;

  HomeBanner(this.id, this.title, this.desc, this.imagePath, this.isVisible,
      this.order, this.type, this.url);

  //不同的类使用不同的mixin即可
  factory HomeBanner.fromJson(Map<String, dynamic> json) =>
      _$HomeBannerFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBannerToJson(this);
}
