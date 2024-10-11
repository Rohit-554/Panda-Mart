import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:panda_mart/views/home/product_page.dart';

import '../../core/config/themes/app_theme.dart';
import 'CategoryChoosePage.dart';
import 'ProfilePage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const CategoryChoosePage(),
    const ProductPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(0), // Adjust the radius as needed
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.2),
              )
            ],
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
              duration: const Duration(milliseconds: 200),
              backgroundColor: Colors.white,
              rippleColor: Colors.grey[300]!,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              tabActiveBorder: const Border(
                top: BorderSide(color: AppColors.themeColor, width: 2),
              ),
              tabBorder: const Border(
                top: BorderSide(color: Colors.grey, width: 2),
              ),
              gap: 8,
              activeColor: AppColors.themeColor,
              color: Color(0xff757c8e),
              tabBackgroundColor: Color(0xfff8f8f8),
              padding: const EdgeInsets.all(8),
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: [
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.explore, text: 'Explore'),
                GButton(icon: Icons.person, text: 'Profile'),
              ],
            ),
          ),
        ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}




