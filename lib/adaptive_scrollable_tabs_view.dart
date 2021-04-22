import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdaptiveScrollableTabsView extends StatefulWidget {
  /// The Initial tab for the screen
  final int startTab;

  /// The top app bar for your screen
  final PreferredSizeWidget appBar;

  /// The widgets that you want to display in the tabs
  final List<Widget> pages;

  /// The Bottom Tab Bar Items which will navigate through tabs
  final List<BottomNavigationBarItem> items;

  /// Selected Item Color
  final Color selectedColor;

  /// UnSelected Item Color
  final Color unselectedColor;

  /// Bottom Tab Bar Background Color
  final Color backgroundColor;

  /// Navigating through tabs using tab bar duration
  final Duration animationDurationForTab;

  /// Navigating through tabs animation curve
  final Curve animationCurve;

  /// elevation of the Bottom Tab Bar
  final double elevation;

  /// Icon Size of items
  final double iconSize;

  /// Font Size for selected item
  final double selectedFontSize;

  /// Font Size for unselected item
  final double unselectedFontSize;

  /// Font Style for selected item
  final TextStyle selectedLabelStyle;

  /// Font Style for unselected item
  final TextStyle unselectedLabelStyle;

  /// Choose either you want to show the selected item label or just show the icon
  final bool showSelectedLabels;

  /// Choose either you want to show the unselected items label or just show their icon
  final bool showUnselectedLabels;

  /// Enable or Disable Tabs Scrolling
  final bool allowScroll;

  /// Drawer
  final Widget drawer;

  /// The current tab
  int currentPage;

  /// This will pass the selected page index to you
  ValueChanged<int> onTap;

  AdaptiveScrollableTabsView({
    @required this.pages,
    @required this.items,
    this.startTab = 0,
    this.appBar,
    this.currentPage = 0,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.animationCurve = Curves.fastOutSlowIn,
    this.animationDurationForTab = const Duration(milliseconds: 500),
    this.elevation,
    this.iconSize = 24,
    this.selectedFontSize = 14,
    this.unselectedFontSize = 12,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
    this.allowScroll = true,
    this.drawer,
    this.onTap,
  }) {
    //currentPage = startTab;
  }

  @override
  _AdaptiveScrollableTabsViewState createState() =>
      _AdaptiveScrollableTabsViewState();
}

class _AdaptiveScrollableTabsViewState
    extends State<AdaptiveScrollableTabsView> {
  PageController _pageController;

  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: widget.startTab);
    widget.currentPage = widget.startTab;
    currentPage = widget.startTab;
  }

  void selectPage(int index) {
    setState(() {
      widget.currentPage = index;
      currentPage = index;
    });
    widget.onTap(index);
  }

  selectPageByIndex(int index) {
    _pageController.animateToPage(
      index,
      duration: widget.animationDurationForTab,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.drawer,
      appBar: widget.appBar,
      body: PageView(
        children: widget.pages,
        controller: _pageController,
        onPageChanged: (i) => selectPage(i),
      ),
      bottomNavigationBar: !Platform.isIOS
          ? BottomNavigationBar(
              onTap: (index) => selectPageByIndex(index),
              currentIndex: currentPage,
              selectedItemColor: widget.selectedColor,
              unselectedItemColor: widget.unselectedColor,
              backgroundColor: widget.backgroundColor,
              items: widget.items,
              elevation: widget.elevation,
              iconSize: widget.iconSize,
              selectedFontSize: widget.selectedFontSize,
              unselectedFontSize: widget.unselectedFontSize,
              selectedLabelStyle: widget.selectedLabelStyle,
              unselectedLabelStyle: widget.unselectedLabelStyle,
              showSelectedLabels: widget.showSelectedLabels,
              showUnselectedLabels: widget.showUnselectedLabels,
            )
          : CupertinoTabBar(
              onTap: (index) => selectPage(index),
              items: widget.items,
              activeColor: widget.selectedColor,
              inactiveColor: widget.unselectedColor,
              backgroundColor: widget.backgroundColor,
              iconSize: widget.iconSize,
              currentIndex: widget.currentPage,
            ),
    );
  }
}
