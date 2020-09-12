import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:google_music/packages/bubbled_navigation_bar.dart';

// Importing App Pages
import 'intro.dart';
import 'introduction.dart';
// App Bar Pages
import 'settings.dart';
import 'profile.dart';
// Nav Bar Pages
import 'nav/library.dart';
import 'nav/newreleases.dart';
import 'nav/playing.dart';
import 'nav/radio.dart';
import 'nav/recents.dart';
import 'nav/topcharts.dart';

void main() => runApp(IntroCheck());

class IntroCheck extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Music',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyAppState extends State<IntroCheck> {
  // This widget is the root of your application.

  bool isFirstTimeOpen = false;

  MyAppState() {
    MySharedPreferences.instance
        .getBooleanValue("firstTimeOpen")
        .then((value) => setState(() {
      isFirstTimeOpen = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: isFirstTimeOpen ? MyApp() : OnBoardingPage());
  }
}

class MyHomePage extends StatefulWidget {
  final titles = ['Playing', 'Recents', 'Top Charts', 'New Releases', 'Radio', 'Library'];
  final colors = [Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white];
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
              color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profilePage()),
              );
            }
            ),
        centerTitle: true,
        title: Text('Google Music', style: TextStyle(color: Colors.white, fontSize: 25.0)),
        backgroundColor: Colors.black87,

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => settingsPage()),
              );
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
              child: playingPage(),
              color: Colors.black,
            ),
            Container(
              child: recentsPage(),
              color: Colors.black,
            ),
            Container(
              child: topchartsPage(),
              color: Colors.black,
            ),
            Container(
              child: newreleasesPage(),
              color: Colors.black,
            ),
            Container(
              child: radioPage(),
              color: Colors.black,
            ),
            Container(
              child: libraryPage(),
              color: Colors.black,
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
        backgroundColor: Colors.black87,
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
            bubbleColor: Colors.red,
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
