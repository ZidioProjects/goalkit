import 'package:flutter/material.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/views/home/home_page.dart';

class Nav extends StatefulWidget {
  final int currentIndex;
  const Nav({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  late int _currentIndex;
  final List<Widget> _children = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];

  @override
  void initState() {
    _children;
    _currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _children),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            backgroundColor: primaryColor,
            elevation: 2.0,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: tabItem,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Image.asset(
                        ImageManager.homeIcon,
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      )),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Image.asset(
                        ImageManager.statsIcon,
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      )),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Image.asset(
                        ImageManager.folderIcon,
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      )),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Image.asset(
                        ImageManager.settingsIcon,
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      )),
                  label: ''),
            ],
          ),
        ),
      ),
    );
  }

  void tabItem(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
