import 'package:json_annotation/json_annotation.dart';

part 'HomeBanner.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class HomeBanner {
  late int id;
  late String title;
  late String desc;
  late String imagePath;
  late int isVisible;
  late int order;
  late int type;
  late String url;

  HomeBanner(this.id, this.title, this.desc, this.imagePath, this.isVisible,
      this.order, this.type, this.url);

  @override
  String toString() {
    return 'HomeBanner{id: $id, title: $title, desc: $desc, imagePath: $imagePath, isVisible: $isVisible, order: $order, type: $type, url: $url}';
  }

  factory HomeBanner.fromJson(Map<String, dynamic> json) => _$HomeBannerFromJson(json);

  Map<String,dynamic> toJson() => _$HomeBannerToJson(this);
}
