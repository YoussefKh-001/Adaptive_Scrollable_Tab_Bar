import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:adaptive_scrollable_tab_bar/adaptive_scrollable_tabs_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  List<Widget> _generateDummyListTiles(int n) {
    List<Widget> tiles = [];
    for (int i = 0; i < n; i++) {
      tiles.add(
        new ListTile(
          leading: CircleAvatar(),
          title: Text("Test${i + 1}"),
          subtitle: Text(
              "Its a dummy text to test the program and it's not important what am i typing here iam just trying to type something"),
        ),
      );
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScrollableTabsView(
      appBar: AppBar(
        title: Text("Package Test"),
      ),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.archive),
          label: "Boxes",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        )
      ],
      pages: [
        //First Tab
        ListView(
          padding: EdgeInsets.all(10),
          children: _generateDummyListTiles(10),
        ),

        // Second Tab
        Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Dummy Text Field"),
              )
            ],
          ),
        ),

        //Third Tab
        Padding(
          padding: EdgeInsets.all(5),
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 100,
                child: Container(
                  color: Colors.blue,
                  width: 150,
                  height: 150,
                ),
              ),
              Positioned(
                bottom: 40,
                right: 50,
                child: Container(
                  color: Colors.black,
                  width: 200,
                  height: 460,
                ),
              ),
              Positioned(
                top: 370,
                right: 23,
                child: Container(
                  color: Colors.green,
                  width: 300,
                  height: 260,
                ),
              ),
              Positioned(
                bottom: 170,
                left: 20,
                child: Container(
                  color: Colors.red,
                  width: 234,
                  height: 140,
                ),
              )
            ],
          ),
        ),

        Center(child: Text("Settings")),
      ],
    );
  }
}
