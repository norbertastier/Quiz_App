import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/quizQuestionSceen.dart';
import 'package:quiz_app/quiz_helper.dart';
import 'homeScreen.dart';
import 'quizThemeScreen.dart';
import 'profilScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizApp',
      home: QuestionPage(),//MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  QuizHelper _quizHelper = QuizHelper();


  @override
  void initState(){
    _quizHelper.initializeDatabase().then((value){
      print('------database initialized');
    });
    super.initState();
  }

  int _selectedScreenIndex = 0;
  List _screens = [
    {"screen": HomePage(), "title": "Screen Page 1"},
    {"screen": QuizThemePage(), "title": "Screen Page 2"},
    {"screen": ProfilPage(), "title": "Screen Page 3"},
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 50,
            color: Colors.black,
            onPressed: () {}),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: _screens[_selectedScreenIndex]["screen"],
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
