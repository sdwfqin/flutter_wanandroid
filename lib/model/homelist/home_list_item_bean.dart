import 'package:json_annotation/json_annotation.dart';

part 'home_list_item_bean.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class HomeListItemBean {
  late String author;
  late int chapterId;
  late String chapterName;
  late bool collect;
  late int courseId;
  late String desc;
  late String envelopePic;
  late bool fresh;
  late int id;
  late String link;
  late String niceDate;
  late int publishTime;
  late int superChapterId;
  late String superChapterName;
  late String title;
  late int type;
  late int userId;
  late int visible;
  late int zan;

  HomeListItemBean(
      this.author,
      this.chapterId,
      this.chapterName,
      this.collect,
      this.courseId,
      this.desc,
      this.envelopePic,
      this.fresh,
      this.id,
      this.link,
      this.niceDate,
      this.publishTime,
      this.superChapterId,
      this.superChapterName,
      this.title,
      this.type,
      this.userId,
      this.visible,
      this.zan);

  @override
  String toString() {
    return 'HomeListItemBean{author: $author, chapterId: $chapterId, chapterName: $chapterName, collect: $collect, courseId: $courseId, desc: $desc, envelopePic: $envelopePic, fresh: $fresh, id: $id, link: $link, niceDate: $niceDate, publishTime: $publishTime, superChapterId: $superChapterId, superChapterName: $superChapterName, title: $title, type: $type, userId: $userId, visible: $visible, zan: $zan}';
  }

  factory HomeListItemBean.fromJson(Map<String, dynamic> json) => _$HomeListItemBeanFromJson(json);

  Map<String,dynamic> toJson() => _$HomeListItemBeanToJson(this);
}
