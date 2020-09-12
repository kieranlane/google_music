import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'test.dart';
import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';

import 'test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final titles = ['Playing', 'Recents', 'Top Charts', 'New Releases', 'Radio', 'Library'];
  final colors = [Colors.red, Colors.purple, Colors.teal, Colors.green, Colors.cyan, Colors.amber];
  final icons = [
    Icons.play_circle_outline,
    Icons.history,
    Icons.star,
    Icons.new_releases,
    Icons.radio,
    Icons.library_music
  ];

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);

    _pageController = PageController(
        initialPage: 0,
        keepPage: true,
        viewportFraction: 1.0
    );
    _pageController.addListener(handlePageChange);

    super.initState();
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  void checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification && scrollNotification.direction != ScrollDirection.idle) {
      userPageDragging = true;
    } else if (scrollNotification is ScrollEndNotification) {
      userPageDragging = false;
    }
    if (userPageDragging) {
      _menuPositionController.findNearestTarget(_pageController.page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading:
          IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.black,),
              onPressed: () {}
          ),
          centerTitle: true,
          title: Text('Google Music',
            style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,

          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body: NotificationListener<ScrollNotification>( onNotification:
            (scrollNotification) {checkUserDragging(scrollNotification); },
          child: PageView(
            controller: _pageController,
            children: <Widget>[
              Container(
                child: RandomWords(),
                color: Colors.redAccent,
              ),
              Container(
                child: Center(child:Text("Recents")),
                color: Colors.purpleAccent,
              ),
              Container(
                child: Center(child:Text("Top Charts")),
                color: Colors.tealAccent,
              ),
              Container(
                child: Center(child:Text("New Releases")),
                color: Colors.greenAccent,
              ),
              Container(
                child: Center(child:Text("Radio")),
                color: Colors.cyanAccent,
              ),
              Container(
                child: Center(child:Text("Library")),
                color: Colors.amberAccent,
              )
            ],
            onPageChanged: (page) {
            },
          ),
        ),
        bottomNavigationBar: BubbledNavigationBar(
          controller: _menuPositionController,
          initialIndex: 0,
          itemMargin: EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: Colors.white,
          defaultBubbleColor: Colors.blue,
          onTap: (index) {
            _pageController.animateToPage(
                index,
                curve: Curves.easeInOutQuad,
                duration: Duration(milliseconds: 500)
            );
          },
          items: widget.titles.map((title) {
            var index = widget.titles.indexOf(title);
            var color = widget.colors[index];
            return BubbledNavigationBarItem(
              icon: getIcon(index, color),
              activeIcon: getIcon(index, Colors.white),
              bubbleColor: color,
              title: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            );
          }).toList(),
        )
    );
  }

  Padding getIcon(int index, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Icon(widget.icons[index], size: 30, color: color),
    );
  }
}
