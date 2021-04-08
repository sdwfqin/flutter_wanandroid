import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constants/sp_constants.dart';
import 'package:flutter_wanandroid/http/api/user.dart';
import 'package:flutter_wanandroid/utils/loading_utils.dart';
import 'package:flutter_wanandroid/utils/sp_utils.dart';
import 'package:flutter_wanandroid/utils/toast_utils.dart';

/// Created with Android Studio.
/// User: 张钦
/// Date: 3/25/21
/// email: sdwfqin@gmail.com
/// target: 登录页面
class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  LoadingUtils _loadingUtils = LoadingUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        width: window.physicalSize.width,
        height: window.physicalSize.height,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, //设置globalKey，用于后面获取FormState
            autovalidateMode: AutovalidateMode.onUserInteraction, //开启自动校验
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 100, bottom: 50),
                  child: Image.asset(
                    "images/logo.png",
                    width: 160,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                TextFormField(
                    autofocus: true,
                    controller: _unameController,
                    decoration: InputDecoration(
                        labelText: "用户名",
                        hintText: " 请输入用户名",
                        icon: Icon(Icons.person)),
                    // 校验用户名
                    validator: (v) {
                      return v!.trim().length > 0 ? null : "用户名不能为空";
                    }),
                TextFormField(
                    controller: _pwdController,
                    decoration: InputDecoration(
                        labelText: "密码",
                        hintText: "请输入登录密码",
                        icon: Icon(Icons.lock)),
                    obscureText: true,
                    //校验密码
                    validator: (v) {
                      return v!.trim().length > 5 ? null : "密码不能少于6位";
                    }),
                // 登录按钮
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(15.0)),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          child: Text("登录"),
                          onPressed: () {
                            // 在这里不能通过此方式获取FormState，context不对
                            // print(Form.of(context));
                            // 通过_formKey.currentState 获取FormState后，
                            // 调用validate()方法校验用户名密码是否合法，校验
                            // 通过后再提交数据。
                            if ((_formKey.currentState as FormState)
                                .validate()) {
                              // 登录
                              _login(_unameController.value.text,
                                  _pwdController.value.text);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 登录
  void _login(String username, String password) {
    _loadingUtils.showLoading(context);
    login(username, password).then((value) {
      showToast("登录成功");
      Navigator.pop(context);
      SpUtils.instance.setStorage(SpConstants.userData, value.data["data"]);
    }).whenComplete(() => _loadingUtils.hideLoading());
  }
}
