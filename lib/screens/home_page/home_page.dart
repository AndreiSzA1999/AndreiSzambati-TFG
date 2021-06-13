import 'package:aszcars_tfg_andrei/screens/add_picture_screen/add_picture.dart';

import 'package:aszcars_tfg_andrei/screens/posts_page/posts_screen.dart';
import 'package:aszcars_tfg_andrei/screens/profile_screen/profile.dart';
import 'package:aszcars_tfg_andrei/screens/search_page.dart/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    PostsPage(),
    SearchPage(),
    ProfilePage(),
    AddPicturePage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = PostsPage();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            color: Color(0xff181a20),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  minWidth: 10,
                  onPressed: () {
                    setState(() {
                      currentScreen = PostsPage();
                      currentTab = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Ionicons.md_home,
                          size: currentTab == 0 ? 35 : 30,
                          color: currentTab == 0 ? Colors.white : Colors.grey),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 10,
                  onPressed: () {
                    setState(() {
                      currentScreen = SearchPage();
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Ionicons.md_search,
                          size: currentTab == 1 ? 35 : 30,
                          color: currentTab == 1 ? Colors.white : Colors.grey),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 10,
                  onPressed: () {
                    setState(() {
                      currentScreen = AddPicturePage();
                      currentTab = 4;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Ionicons.ios_add,
                          size: 50,
                          color: currentTab == 4 ? Colors.white : Colors.grey),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 10,
                  onPressed: () {
                    setState(() {
                      currentScreen = ProfilePage();
                      currentTab = 3;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Ionicons.ios_person,
                          size: currentTab == 3 ? 35 : 30,
                          color: currentTab == 3 ? Colors.white : Colors.grey),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
