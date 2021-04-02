import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wanandroid/components/webview_content_page.dart';
import 'package:flutter_wanandroid/http/http_constants.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';
import 'package:flutter_wanandroid/model/banner/home_banner.dart';
import 'package:flutter_wanandroid/model/banner/home_list_banner.dart';
import 'package:flutter_wanandroid/model/homelist/home_list_item_bean.dart';
import 'package:flutter_wanandroid/model/homelist/home_list_main_bean.dart';
import 'package:flutter_wanandroid/utils/loading_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// Created with Android Studio.
/// User: 张钦
/// Date: 2018-11-01
/// email: sdwfqin@gmail.com
/// target: 主页
class HomePage extends StatefulWidget {
  @override
  _BodyViewState createState() => new _BodyViewState();
}

class _BodyViewState extends State<HomePage> {
  late RefreshController _refreshController;

  LoadingUtils _loadingUtils = LoadingUtils();

  List<HomeListItemBean> _data = [];
  int _currentPager = 0;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _getData();
    Future.delayed(Duration.zero, () {
      _loadingUtils.showLoading(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: new Text(
          "首页",
        ),
      ),
      body: SmartRefresher(
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
              childCount: _data.length,
            ))
          ],
        ),
      ),
    );
  }

  // 列表项
  Widget _buildListItem(BuildContext context, int index) {
    var itemData = _data[index];
    return Container(
      margin: EdgeInsets.fromLTRB(10, index == 0 ? 10 : 0, 10, 10),
      child: Ink(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8.0)),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) =>
                    new WebViewContentPage(itemData.title, itemData.link),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(10.0),
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
                          child: Text(itemData.author,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                      ),
                      // 分类
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                              itemData.superChapterName +
                                  "/" +
                                  itemData.chapterName,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .fontSize,
                                  color: Theme.of(context).accentColor)),
                        ),
                      ),
                    ],
                  ),
                  // 标题
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Text(itemData.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1)),
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
                          child: Text(itemData.niceDate,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.caption),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  void _onRefresh() {
    setState(() {
      _currentPager = 0;
    });
    _getData();
  }

  void _onLoading() {
    _getData();
  }

  /// 加载数据
  void _getData() {
    HttpManager.instance.dio
        .get("article/list/$_currentPager/json")
        .then((value) {
      HomeListMainBean bean = HomeListMainBean.fromJson(value.data);
      // setState 相当于 runOnUiThread
      // _refreshController 是分页组件用的
      setState(() {
        if (_currentPager == 0) {
          _data = bean.data.datas;
          _refreshController.refreshCompleted();
        } else {
          _data.addAll(bean.data.datas);
          _refreshController.loadComplete();
        }
        _currentPager = _currentPager + 1;
      });

      if (bean.data.over) {
        _refreshController.loadNoData();
      }
    }).whenComplete(() {
      setState(() {
        _refreshController.loadComplete();
        _refreshController.refreshCompleted();
      });
      _loadingUtils.hideLoading();
    });
  }

  @override
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

  void _getData() {
    HttpManager.instance.dio.get(HttpConstants.banner).then((value) {
      HomeListBanner bean = HomeListBanner.fromJson(value.data);
      // setState 相当于 runOnUiThread
      setState(() {
        data = bean.data;
        count = data.length < 1 ? 1 : data.length;
      });
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
        onTap: (index) {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) =>
                  new WebViewContentPage(data[index].title, data[index].url),
            ),
          );
        },
      ),
      height: 200.0,
    );
  }
}
