import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:wp05/common/constants.dart';
import 'package:wp05/models/article.dart';
import 'package:wp05/pages/articles.dart';
import 'package:wp05/pages/comments.dart';
import 'package:wp05/pages/local_articles.dart';
import 'package:wp05/pages/omanNews.dart';
import 'package:wp05/pages/search.dart';
import 'package:wp05/pages/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'studiopress',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFFFFCE58),
          accentColor: Color(0xFFFBA421),
          textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 17,
                color: Colors.black,
                height: 1.2,
                fontWeight: FontWeight.w500,
                fontFamily: "Soleil",
              ),
              caption: TextStyle(color: Colors.black45, fontSize: 10),
              bodyText1: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              )),
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Firebase Cloud Messeging setup
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    Articles(),
    LocalArticles(),
    OmanNews(),
    Search(),
    Settings()
  ];

  @override
  void initState() {
    super.initState();
  }


  startFirebase() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'notification';
    final value = prefs.getInt(key) ?? 0;
    if (value == 1) {
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  message["notification"]["title"],
                  style: TextStyle(fontFamily: "Soleil", fontSize: 18),
                ),
                content: Text(message["notification"]["body"]),
                actions: <Widget>[
                  FlatButton(
                    child: new Text("Dismiss"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        onLaunch: (Map<String, dynamic> message) async {
          // print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          // print("onResume: $message");
        },
      );
      _firebaseMessaging.getToken().then((token) {
        // print("Firebase Token:" + token);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xFFE5BC31),
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.w500, fontFamily: "Soleil"),
            unselectedLabelStyle: TextStyle(fontFamily: "Soleil"),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.flare), label: localName),
              BottomNavigationBarItem(
                  icon: Icon(Icons.flare), label: omanName),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'البحث'),
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'الاعدادات'),
            ],
            currentIndex: _selectedIndex,
            fixedColor: bottomNavColor,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
