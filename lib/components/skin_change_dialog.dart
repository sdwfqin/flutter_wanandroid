import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constants/sp_constants.dart';
import 'package:flutter_wanandroid/utils/sp_utils.dart';

/// Created with Android Studio.
/// User: 张钦
/// Date: 4/2/21
/// email: sdwfqin@gmail.com
/// target: 切换皮肤
class SkinChangeDialog extends Dialog {
  final String? groupValue;

  SkinChangeDialog(this.groupValue, {Key? key}) : super(key: key);

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
                  Navigator.pop(context);
                },
              ),
              _dialog(context)
            ],
          )),
    );
  }

  Widget _dialog(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          RadioListTile(
            title: Text("浅色"),
            value: "light",
            controlAffinity: ListTileControlAffinity.trailing,
            groupValue: groupValue,
            onChanged: (v) {
              _skinChange(v.toString(), context);
            },
          ),
          RadioListTile(
            title: Text("深色"),
            value: "dark",
            controlAffinity: ListTileControlAffinity.trailing,
            groupValue: groupValue,
            onChanged: (v) {
              _skinChange(v.toString(), context);
            },
          ),
          RadioListTile(
            title: Text("跟随系统"),
            value: "system",
            controlAffinity: ListTileControlAffinity.trailing,
            groupValue: groupValue,
            onChanged: (v) {
              _skinChange(v.toString(), context);
            },
          )
        ]),
      ),
    );
  }

  _skinChange(String value, BuildContext context) {
    SpUtils.instance.setStorage(SpConstants.skin, value);
    Navigator.pop(context, value);
  }
}
