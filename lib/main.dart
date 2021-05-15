import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/profilScreen.dart';
import 'package:quiz_app/quizScoreScreen.dart';
import 'package:quiz_app/routeGenerator.dart';
import 'homeScreen.dart';
import 'quizThemeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizApp',
      home: MyHomePage(), //QuestionPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  int _quizThemeindex = 1;
  int _selectedScreenIndex = 0;

  Widget pageCaller(int index) {
    switch (index) {
      case 0:
        {
          return HomePage(refresh);
        }
        break;
      case 1:
        {
          return QuizThemePage();
        }
        break;
      case 2:
        {
          return ProfilPage();
        }
        break;
      default:
        {
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(
              child: Text('ERROR'),
            ),
          );
        }
    }
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  void refresh() {
    setState(() {
      _selectedScreenIndex = _quizThemeindex;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: pageCaller(_selectedScreenIndex),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 40,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Color(0xfffffbfa),
        selectedItemColor: Color(0xfff00bd9d),
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(
          fontFamily: 'SegoeUI',
        ),
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
