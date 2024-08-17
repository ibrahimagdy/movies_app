import 'package:flutter/material.dart';
import '../view/browse/browse_view.dart';
import '../view/home/home_view.dart';
import '../view/search/search_view.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'home-layout';

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedViewIndex = 0;

  List<Widget> views = [
    HomeView(),
    const SearchView(),
    const BrowseView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: views[selectedViewIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          selectedViewIndex = index;
          setState(() {});
        },
        currentIndex: selectedViewIndex,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/home_icon.png'),
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/search_icon.png'),
            ),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/browse_icon.png'),
            ),
            label: 'BROWSE',
          ),
        ],
      ),
    );
  }
}