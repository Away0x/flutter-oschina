import 'package:flutter/material.dart';

import 'package:oschina/application.dart';
import 'package:oschina/utils/event_bus.dart';

import './part/profile_top.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String userAvatar;
  String userName;

  List<String> menuTitles = [
    '我的消息',
    '阅读记录',
    '我的博客', 
    '我的问答',
    '我的活动',
    '我的团队',
    '邀请好友'
  ];
  List<IconData> menuIcons = [
    Icons.message,
    Icons.print,
    Icons.book,
    Icons.phone,
    Icons.send,
    Icons.people,
    Icons.person,
  ];

  @override
  void initState() {
    super.initState();

    _showUserInfo();
    // 登录
    eventBus.on<LoginEvent>().listen((event) {
      // 获取用户信息

    });
    // 登出
    eventBus.on<LogoutEvent>().listen((event) {
      // TODO
    });
  }

  // 尝试获取用户信息
  _showUserInfo() {

  }

  // 登录
  _login() async {
    final result = await Application.navigateTo(context, '/login');

    if (result != null && result == 'refresh') {
      // 登录成功
      eventBus.fire(LoginEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: menuTitles.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ProfileTop(
            onLogin: _login,
          );
        }

        index -= 1;
        return ListTile(
          onTap: () {
            // TODO list tile event
          },
          leading: Icon(menuIcons[index]),
          title: Text(menuTitles[index]),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(height: 1);
      },
    );
  }
}