import 'package:json_annotation/json_annotation.dart';

/// flutter packages pub run build_runner build
part 'HomeListItemBean.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class HomeListItemBean {
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  int publishTime;
  int superChapterId;
  String superChapterName;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  HomeListItemBean(this.author, this.chapterId, this.chapterName, this.collect,
      this.courseId, this.desc, this.envelopePic, this.fresh, this.id,
      this.link, this.niceDate, this.publishTime, this.superChapterId,
      this.superChapterName, this.title, this.type, this.userId, this.visible,
      this.zan);

  //不同的类使用不同的mixin即可
  factory HomeListItemBean.fromJson(Map<String, dynamic> json) =>
      _$HomeListItemBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeListItemBeanToJson(this);
}
