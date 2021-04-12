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

  /// Navigating through tabs by scrolling duration
  final Duration animationDurationForScroll;

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

  /// The current tab
  int currentPage;

  /// This will pass the selected page index to you
  Function onTap;

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
    this.animationDurationForTab = const Duration(milliseconds: 100),
    this.animationDurationForScroll = const Duration(milliseconds: 100),
    this.elevation,
    this.iconSize = 24,
    this.selectedFontSize = 14,
    this.unselectedFontSize = 12,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
    this.allowScroll = true,
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
  ScrollController _scrollController = new ScrollController();

  bool selectPageByIndex(int index, Size mediaQuery) {
    Future.delayed(Duration.zero, () {
      _scrollController.animateTo(mediaQuery.width * index,
          duration: widget.animationDurationForTab,
          curve: widget.animationCurve);
    });
    widget.currentPage = index;
    return true;
  }

  bool selectPageByScroll(double position, double width) {
    double ratio = position / width;
    int index = position ~/ width;
    int currentPage = this.widget.currentPage;

    if (currentPage == index) {
      if (ratio - index > 0.3) {
        currentPage = index + 1;
      } else if (ratio - index <= 0.3) {
        currentPage = index;
      }
    } else {
      if (index > currentPage)
        currentPage = index;
      else {
        if (ratio - index <= 0.7 && ratio >= index) {
          if (currentPage > 0) currentPage -= currentPage - index;
        }
      }
    }
    setState(() {
      this.widget.currentPage = currentPage;
    });

    Future.delayed(Duration.zero, () {
      _scrollController.animateTo(width * currentPage,
          duration: widget.animationDurationForScroll,
          curve: widget.animationCurve);
      if (widget.onTap != null) widget.onTap(currentPage);
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    selectPageByIndex(widget.currentPage, mediaQuery);
    return Scaffold(
      appBar: widget.appBar,
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (n) {
          return selectPageByScroll(
              _scrollController.position.pixels, mediaQuery.width);
        },
        child: ListView(
          physics: widget.allowScroll
              ? ClampingScrollPhysics()
              : NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          children: widget.pages.map((page) {
            return Container(
              width: mediaQuery.width,
              height: mediaQuery.height,
              child: page,
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: !Platform.isIOS
          ? BottomNavigationBar(
        onTap: (index) => selectPageByIndex(index, mediaQuery),
        currentIndex: widget.currentPage,
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
        onTap: (index) => selectPageByIndex(index, mediaQuery),
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
