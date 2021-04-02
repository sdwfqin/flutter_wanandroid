import 'package:flutter/material.dart';

/// Created with Android Studio.
/// User: 张钦
/// Date: 3/31/21
/// email: sdwfqin@gmail.com
/// target: 加载弹窗
class LoadingDialog extends Dialog {
  //提示内容
  final String? msg;

  //加载中动画
  final Widget progress;

  //字体颜色
  final Color textColor;

  final bool canceledOnTouchOutSide;

  LoadingDialog(this.msg,
      {Key? key,
        this.progress = const CircularProgressIndicator(),
        this.textColor = Colors.white,
        this.canceledOnTouchOutSide = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Material(
          ///背景透明
          color: Colors.transparent,
          ///保证控件居中效果
          child: Stack(
            children: <Widget>[
              GestureDetector(
                ///点击事件
                onTap: () {
                  if (canceledOnTouchOutSide) {
                    Navigator.pop(context);
                  }
                },
              ),
              _dialog()
            ],
          )
      ),
    );
  }

  Widget _dialog() {
    late Widget layoutProgress;
    if (msg == null) {
      layoutProgress = Center(
        child: progress,
      );
    } else {
      layoutProgress = Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Colors.black87, borderRadius: BorderRadius.circular(4.0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              progress,
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                child: Text(
                  msg!,
                  style: TextStyle(color: textColor, fontSize: 16.0),
                ),
              )
            ],
          ),
        ),
      );
    }
    return new Center(
      child: layoutProgress,
    );
  }
}
