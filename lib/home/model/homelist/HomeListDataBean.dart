import 'package:flutter_wanandroid/home/model/homelist/HomeListItemBean.dart';
import 'package:json_annotation/json_annotation.dart';

/// flutter packages pub run build_runner build
part 'HomeListDataBean.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class HomeListDataBean {
  int curPage;
  List<HomeListItemBean> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  HomeListDataBean(this.curPage, this.datas, this.offset, this.over,
      this.pageCount, this.size, this.total);

  //不同的类使用不同的mixin即可
  factory HomeListDataBean.fromJson(Map<String, dynamic> json) =>
      _$HomeListDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeListDataBeanToJson(this);

}
