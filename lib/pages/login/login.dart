import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:oschina/constants/style.dart';
import 'package:oschina/services/authorize.dart';

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
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      // 授权成功会跳转  https://www.dongnaoedu.com/?code=XNrugt&state=
      if (url != null && url.isNotEmpty && url.contains('?code=')) {
        // 登录成功，提取授权码 code
        String code = url.split('?code=')[1].split('&')[0];
        // print(code);
        AuthorizeService.getToken(code).then((val) {
          if ( ! val.status) {
            Fluttertoast.showToast(msg: val.message, gravity: ToastGravity.CENTER);
            return;
          }

          Fluttertoast.showToast(msg: '登录成功', gravity: ToastGravity.CENTER);
          Navigator.pop(context, 'refresh'); // 返回 refresh 通知界面刷新数据
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    
    _flutterWebviewPlugin.close();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> appBarTitle = [
      Text('登录开源中国', style: TextStyle(color: Color(AppColors.APPBAR))),
    ];

    if (isLoading) {
      appBarTitle.add(SizedBox(width: 10));
      appBarTitle.add(CupertinoActivityIndicator());
    }

    return WebviewScaffold(
      url: AuthorizeService.authorizeAPI,
      appBar: AppBar(
        title: Row(
          children: appBarTitle,
        ),
      ),
      withZoom: true, // 可缩放
      withJavascript: true, // 允许执行 js
      withLocalStorage: true, // 允许本地存储
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