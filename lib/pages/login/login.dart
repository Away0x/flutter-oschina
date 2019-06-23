import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:oschina/constants/app.dart';
import 'package:oschina/constants/style.dart';
import 'package:oschina/services/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // 监听 url 变化
    _flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print(url);
    });
  }

  @override
  Widget build(BuildContext context) {
    // const oauthUrl = Services.OAUTH2_AUTHORIZE +
    //   '?response_type=code&client_id=${AppInfo.CLIENT_ID}&redirect_uri=${AppInfo.REDIRECT_URI}';

    const oauthUrl = "https://www.baidu.com";

    return WebviewScaffold(
      url: oauthUrl,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text('登录开源中国', style: TextStyle(color: Color(AppColors.APPBAR))),
            CupertinoActivityIndicator(),
          ],
        ),
      ),
      withZoom: true, // 可缩放
      withLocalStorage: true, // 启用本地存储
      hidden: true, // 是否隐藏
      // 初始化界面
      initialChild: Container(
        color: Colors.white,
        child: Center(
          child: Text('Waitting...'),
        ),
      ),
    );
  }
}