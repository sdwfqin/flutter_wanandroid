import 'package:flutter_wanandroid/model/homelist/home_list_item_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_list_data_bean.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class HomeListDataBean {
  late int curPage;
  late List<HomeListItemBean> datas;
  late int offset;
  late bool over;
  late int pageCount;
  late int size;
  late int total;

  HomeListDataBean(this.curPage, this.datas, this.offset, this.over,
      this.pageCount, this.size, this.total);

  @override
  String toString() {
    return 'HomeListDataBean{curPage: $curPage, datas: $datas, offset: $offset, over: $over, pageCount: $pageCount, size: $size, total: $total}';
  }

  factory HomeListDataBean.fromJson(Map<String, dynamic> json) => _$HomeListDataBeanFromJson(json);

  Map<String,dynamic> toJson() => _$HomeListDataBeanToJson(this);

}
