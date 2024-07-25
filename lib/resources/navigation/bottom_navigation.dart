import 'package:flutter/material.dart';
import 'package:goalkit/resources/managers/color_manager.dart';
import 'package:goalkit/resources/managers/image_manager.dart';
import 'package:goalkit/views/category/category_page.dart';
import 'package:goalkit/views/home/new_goal.dart';
import 'package:goalkit/views/settings_screen/settings.dart';

class Nav extends StatefulWidget {
  final int currentIndex;
  const Nav({super.key, this.currentIndex = 0});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  late int _currentIndex;
  final List<Widget> _children = [
    const CategoryPage(),
    const NewGoal(),
    const SettingsPage(),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      padding: const EdgeInsets.only(top: 10),
                      child: Image.asset(
                        ImageManager.homeIcon,
                        width: 18,
                        height: 18,
                        color: Colors.white,
                      )),
                  label: ''),
              const BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Icon(
                        Icons.edit_note_sharp,
                        size: 25,
                        color: Colors.white,
                      )),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: const EdgeInsets.only(top: 10),
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
