
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sms_admin/constants/colors.dart';
import 'package:sms_admin/feat/home/screens/logout-screen.dart';
import 'package:sms_admin/feat/home/screens/message-screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  List<Widget> pages = [
    MessageScreen(),
    LogoutScreen(),
  //   const HomeScreen(),
  //  const ExploreScreen(),
  //  const NotificationScreen(),
  // const ProfileScreen()
  ];
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: AppColors.primary,
          color: AppColors.primary,
          animationDuration: const Duration(milliseconds: 300),
          items: const [
            Icon(
              Icons.home,
              size: 26,
              color: Colors.white,
            ),
            Icon(
              Icons.explore,
              size: 26,
              color: Colors.white,
            ),
           
          ],
          onTap: updatePage
          ),
      body: pages[_page],
    );
  }
}
