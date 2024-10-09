import 'package:flutter/material.dart';

class OnBoardingController with ChangeNotifier {
  final PageController pageController = PageController();
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  void updatePageIndicator(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  void doNavigationClick(int index) {
    _currentPageIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  void nextPage(BuildContext context) {
    if (_currentPageIndex == 2) {
      // Navigator.pushReplacementNamed(context, '/home');
    } else {
      int nextPage = _currentPageIndex + 1;
      pageController.jumpToPage(nextPage);
      _currentPageIndex = nextPage;
      notifyListeners();
    }
  }

  void skipPage() {
    _currentPageIndex = 2;
    pageController.jumpToPage(2);
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
