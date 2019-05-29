import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wanandroid/components/ProgressDialog.dart';
import 'package:flutter_wanandroid/home/model/banner/HomeBanner.dart';
import 'package:flutter_wanandroid/home/model/banner/HomeListBanner.dart';
import 'package:flutter_wanandroid/home/model/homelist/HomeListItemBean.dart';
import 'package:flutter_wanandroid/home/model/homelist/HomeListMainBean.dart';
import 'package:flutter_wanandroid/utils/HttpConstants.dart';
import 'package:flutter_wanandroid/utils/HttpUtil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  RefreshController _refreshController;

  List<HomeListItemBean> data = [];
  int currentPager = 0;
  bool loading = true;

  @override
  void initState() {
    _refreshController = RefreshController();
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
      // 第一次进入有动画
      loading: loading,
      msg: "正在加载中",
      alpha: 0,
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: CustomScrollView(
          // 默认居中对齐
          slivers: <Widget>[
            // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
            SliverToBoxAdapter(
              child: new HeadView(),
            ),
            // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
            SliverList(
                delegate: SliverChildBuilderDelegate(
              _buildListItem,
              childCount: data.length,
            ))
          ],
        ),
      ),
    );
  }

  // 列表项
  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.fromLTRB(10, index == 0 ? 10 : 0, 10, 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // 作者前边的小icon
                Image(
                    image: AssetImage("images/me.png"),
                    width: 12.0,
                    height: 12.0,
                    alignment: Alignment.center),
                // 作者
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                    child: Text(data[index].author,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        )),
                  ),
                ),
                // 分类
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                        data[index].superChapterName +
                            "/" +
                            data[index].chapterName,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                        )),
                  ),
                ),
              ],
            ),
            // 标题
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(data[index].title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // 收藏
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Image(
                      image: AssetImage("images/collect_no.png"),
                      width: 20.0,
                      height: 20.0,
                    ),
                  ),
                ),
                // 发布时间
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(data[index].niceDate,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        )),
                  ),
                ),
              ],
            ),
          ]),
    );
  }

  void _onRefresh() {
    setState(() {
      currentPager = 0;
    });
    _getData();
  }

  void _onLoading() {
    _getData();
  }

  /// 加载数据
  void _getData() async {
    var response = await HttpUtil().get("article/list/$currentPager/json");
    var homeListMainBean = new HomeListMainBean.fromJson(response);

    // setState 相当于 runOnUiThread
    setState(() {
      if (currentPager == 0) {
        data = homeListMainBean.data.datas;
        _refreshController.refreshCompleted();
        loading = false;
      } else {
        data.addAll(homeListMainBean.data.datas);
        _refreshController.loadComplete();
      }
      currentPager = currentPager + 1;
    });

    if (homeListMainBean.data.over) {
      _refreshController.loadNoData();
    }
  }

  void dispose() {
    _refreshController.dispose();
    super.dispose();
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
