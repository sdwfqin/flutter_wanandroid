import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wanandroid/home/model/banner/HomeBanner.dart';
import 'package:flutter_wanandroid/home/model/banner/HomeListBanner.dart';
import 'package:flutter_wanandroid/home/model/homelist/HomeListItemBean.dart';
import 'package:flutter_wanandroid/home/model/homelist/HomeListMainBean.dart';
import 'package:flutter_wanandroid/utils/HttpUtil.dart';
import 'package:flutter_wanandroid/utils/HttpConstants.dart';

/// Created with Android Studio.
/// User: 张钦
/// Date: 2018-11-01
/// email: sdwfqin@gmail.com
/// target: 主页
class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "首页",
          ),
        ),
        body: new BodyView());
  }
}

class BodyView extends StatefulWidget {
  @override
  _BodyViewState createState() => new _BodyViewState();
}

class _BodyViewState extends State<BodyView> {
  List<HomeListItemBean> data = [];
  bool isOver = false;
  int currentPager = 0;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // 默认居中对齐
      slivers: <Widget>[
        // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
        SliverToBoxAdapter(
          child: new HeadView(),
        ),
        // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
        SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(_buildListItem,
                childCount: data.length),
            itemExtent: 48.0)
      ],
    );
  }

  // 列表项
  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(title: Text(data[index].title));
  }

  /// 加载数据
  void _getData() async {
    var response = await HttpUtil().get("article/list/$currentPager/json");
    var homeListMainBean = new HomeListMainBean.fromJson(response);
    // setState 相当于 runOnUiThread
    setState(() {
      data = homeListMainBean.data.datas;
      isOver = homeListMainBean.data.over;
      currentPager = currentPager + 1;
    });
  }
}

/// 头部View
class HeadView extends StatefulWidget {
  @override
  _HeadViewState createState() => new _HeadViewState();
}

class _HeadViewState extends State<HeadView> {
  List<HomeBanner> data = [];
  int count = 1;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    var response = await HttpUtil().get(HttpConstants.banner);

    // setState 相当于 runOnUiThread
    setState(() {
      data = new HomeListBanner.fromJson(response).data;
      count = data.length < 1 ? 1 : data.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            data.length < 1
                ? "http://via.placeholder.com/350x150"
                : data[index].imagePath,
            fit: BoxFit.fill,
          );
        },
        itemCount: count,
        autoplay: true,
        pagination: new SwiperPagination(),
      ),
      height: 200.0,
    );
  }
}
