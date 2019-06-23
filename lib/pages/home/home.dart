import 'package:flutter/material.dart';

import 'package:oschina/constants/style.dart';

import 'package:oschina/components/navigation_icon_view.dart';
import 'package:oschina/components/my_drawer.dart';

import 'package:oschina/pages/news/news.dart';
import 'package:oschina/pages/trends/trends.dart';
import 'package:oschina/pages/discover/discover.dart';
import 'package:oschina/pages/profile/profile.dart';

class HomePage extends StatefulWidget {

  final int initialTabIndex;

  HomePage({
    Key key,
    this.initialTabIndex = 0,
  }) : assert(initialTabIndex != null),
    super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<NavigationIconView> _navigationIconViews;
  List<Widget> _pages;
  PageController _pageController;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialTabIndex;

    _navigationIconViews = [
      NavigationIconView(
          title: '资讯',
          iconPath: 'assets/images/ic_nav_news_normal.png',
          activeIconPath: 'assets/images/ic_nav_news_actived.png'),
      NavigationIconView(
          title: '动态',
          iconPath: 'assets/images/ic_nav_tweet_normal.png',
          activeIconPath: 'assets/images/ic_nav_tweet_actived.png'),
      NavigationIconView(
          title: '发现',
          iconPath: 'assets/images/ic_nav_discover_normal.png',
          activeIconPath: 'assets/images/ic_nav_discover_actived.png'),
      NavigationIconView(
          title: '我的',
          iconPath: 'assets/images/ic_nav_my_normal.png',
          activeIconPath: 'assets/images/ic_nav_my_pressed.png'),
    ];

    _pages = [
      NewsPage(),
      TrendsPage(),
      DiscoverPage(),
      ProfilePage(),
    ];

    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    // SafeArea: 可适配刘海屏等异形屏
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // 去掉阴影
        title: Text(
          _navigationIconViews[currentIndex].title,
          style: TextStyle(color: Color(AppColors.APPBAR))
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)), // 设置触发 drawer 的图标 theme 
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: _navigationIconViews.map((i) => i.item).toList(),
        onTap: (int index) {
          setState(() => currentIndex = index);

          // page view 滚动动画
          // _pageController.animateToPage(index, duration: Duration(milliseconds: 600), curve: Curves.ease);
          _pageController.jumpToPage(index);
        },
      ),
      drawer: MyDrawer(
        headImgPath: 'assets/images/cover_img.jpg',
        menuTitles: ['发布动态', '动态小黑屋', '关于', '设置'],
        menuIcons: [Icons.send, Icons.home, Icons.error, Icons.settings],
      ),
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
        controller: _pageController,
        itemCount: _pages.length,
        itemBuilder: (BuildContext context, int index) {
          return _pages[index]; 
        },
        // onPageChanged: (int index) {
        //   setState(() {
        //     currentIndex = index;
        //   });
        // },
      ),
    );
  }
}
