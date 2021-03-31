import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/loading_dialog.dart';

/// Created with Android Studio.
/// User: 张钦
/// Date: 3/31/21
/// email: sdwfqin@gmail.com
/// target:
class LoadingUtils {
  BuildContext? dialogContext;

  void showLoading(BuildContext context, [String? msg]) {
    msg = msg ?? "加载中...";

    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          dialogContext = context;
          return LoadingDialog(msg);
        });
  }

  void hideLoading() {
    if (dialogContext != null) {
      Navigator.pop(dialogContext!);
    }
  }
}
