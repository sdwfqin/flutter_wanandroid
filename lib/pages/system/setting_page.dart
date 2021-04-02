import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/skin_change_dialog.dart';
import 'package:flutter_wanandroid/constants/sp_constants.dart';
import 'package:flutter_wanandroid/store/theme_model.dart';
import 'package:flutter_wanandroid/utils/sp_utils.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _BodyViewState createState() => new _BodyViewState();
}

class _BodyViewState extends State<SettingPage> {
  String? skin;

  @override
  void initState() {
    super.initState();
    SpUtils.instance.getStorage(SpConstants.skin).then((value) {
      setState(() {
        skin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "设置",
        ),
      ),
      body: Column(
        children: [
          Ink(
            color: Theme.of(context).cardColor,
            child: InkWell(
              onTap: () {
                _changeSkin();
              },
              child: Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: Row(
                    children: [
                      Text("深色模式",
                          style: Theme.of(context).textTheme.bodyText1),
                      Expanded(
                        flex: 1,
                        child: Text(_getCurrentSkin(),
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                      Icon(Icons.chevron_right,
                          color: Theme.of(context).hintColor)
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentSkin() {
    String current = "浅色";
    switch (skin) {
      case "light":
        current = "浅色";
        break;
      case "dark":
        current = "深色";
        break;
      case "system":
        current = "跟随系统";
        break;
      default:
        setState(() {
          skin = "light";
        });
    }
    return current;
  }

  /// 切换皮肤
  void _changeSkin() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SkinChangeDialog(skin);
        }).then((value) {
          setState(() {
            skin = value;
          });
          context.read<ThemeModel>().theme = themeStringToThemeMode(value);
    });
  }
}
