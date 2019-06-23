import 'package:flutter/material.dart';

import 'package:oschina/constants/style.dart';

class ProfileTop extends StatelessWidget {

  final Function onLogin;

  ProfileTop({
    Key key,
    this.onLogin,
  }) : super(key: key);

  Widget _avatar() {
    return GestureDetector(
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Color(AppColors.WHITE), width: 2),
          image: DecorationImage(image: AssetImage('assets/images/ic_avatar_default.png')),
        ),
      ),
      onTap: () {
        if (onLogin == null) { return; }

        onLogin();
      },
    );
  } 

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Color(AppColors.APP_THEME),
      height: 150,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 头像
            _avatar(),
            SizedBox(height: 10),
            // 用户名
            Text('点击头像登录', style: TextStyle(color: Color(AppColors.WHITE))),
          ],
        ),
      ),
    );
  }
}