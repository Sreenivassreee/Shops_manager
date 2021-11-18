import 'package:flutter/cupertino.dart';
import 'package:shops_manager/admin/Screens/admin_sales_screen.dart';
import 'package:shops_manager/admin/main_sale_details_screen.dart';

import '../../export.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => new _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _pageIndex = 0;
  PageController? _pageController;

  List<Widget> tabPages = [
    MainSaleDetailsScreen(),
    AdminHomepage(),
    AdminSalesScreen(),
    AdminHomepage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _pageIndex,
        onTap: onTabTapped,
        fixedColor: Colors.red,
        enableFeedback: false,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bag_badge_plus),
              title: Text("Products")),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.arrow_right_arrow_left_circle),
              title: Text("Sales")),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), title: Text("Profile")),
        ],
      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController?.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
