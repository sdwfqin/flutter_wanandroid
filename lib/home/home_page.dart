import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wanandroid/home/model/HomeBanner.dart';
import 'package:flutter_wanandroid/home/model/HomeListBanner.dart';
import 'package:flutter_wanandroid/utils/HttpUtil.dart';

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
      body: Column(
        // 默认居中对齐
        children: <Widget>[
          new HeadView(),
          Text('text2'),
          Text('text3'),
          Text('text4'),
        ],
      ),
    );
  }
}

class HeadView extends StatefulWidget {
  @override
  _HeadViewState createState() => new _HeadViewState();
}

class _HeadViewState extends State<HeadView> {
  List<HomeBanner> data = [];
  int count = 1;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    var response = await HttpUtil().get("banner/json");

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
        // control: new SwiperControl(),
      ),
      height: 200.0,
    );
  }
}
