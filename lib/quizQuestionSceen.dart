import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:quiz_app/QuizDataBase.dart';
import 'package:quiz_app/models/quiz_question.dart';
import 'package:quiz_app/BuildQuestion.dart';
import 'package:quiz_app/quizScoreScreen.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

  int initialscore = 0;
  int _selectedScreenIndex = 0;
  int limitTime = 120 * 1000;
  int endTime = DateTime.now().millisecondsSinceEpoch + 120 * 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff8BD7D2), Color(0xff00BD9D)],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: CountdownTimer(
                endTime: endTime,
                widgetBuilder: (_, CurrentRemainingTime time) {
                  if (time == null) {
                    return Column(
                      children: [
                        Text(
                          '00:00',
                          style: TextStyle(
                            fontSize: 50,
                            fontFamily: 'SegoeUIBlack',
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    );
                  }
                  return Column(
                    children: [
                      Text(
                        '${_printTime(time)}',
                        style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'SegoeUIBlack',
                        ),
                      ),
                      _buildCounter(time),
                    ],
                  );
                },
                onEnd: onEnd,
              ),
            ),
            getListScreen()[_selectedScreenIndex],
          ],
        ),
      ),
      floatingActionButton: Container(
          width: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff8BD7D2), Color(0xff00BD9D)],
            ),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          child: TextButton(
              child: Text(
                _textButton(_selectedScreenIndex, getListScreen().length),
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'SegoeUIBlack',
                    color: Color(0xfffffbfa)),
              ),
              onPressed: () {
                setState(() {
                  if (getListScreen().length - 1 > _selectedScreenIndex) {
                    _selectedScreenIndex = (_selectedScreenIndex + 1);
                    print(_selectedScreenIndex);
                  } else {
                    onEnd();
                  }
                });
              })),
    );
  }

  Widget _buildCounter(CurrentRemainingTime time) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 30,
        left: 50,
        right: 50,
        top: 20,
      ),
      child: LinearProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
        minHeight: 10,
        value: (limitTime / 1000 - _toSecond(time)) / (limitTime / 1000),
      ),
    );
  }

  static String _textButton(int index, int lenght) {
    if (index < lenght - 1)
      return 'Passer';
    else
      return 'Terminer';
  }

  static String _twoDigits(int n) {
    if (n == null)
      return "00";
    else if (n >= 10) return "${n}";
    return "0${n}";
  }

  static String _printTime(CurrentRemainingTime time) {
    return '${_twoDigits(time.min)}:${_twoDigits(time.sec)}';
  }

  static int _toSecond(CurrentRemainingTime time) {
    if (time.min == null)
      return time.sec;
    else if (time.sec == null)
      return 0;
    else
      return time.min * 60 + time.sec;
  }

  void onEnd() {
      Navigator.of(context).pushNamed('/ScorePage', arguments: initialscore);
  }

  void refreshScore(){
      initialscore++;
      print('Score : '+initialscore.toString());
  }

  List<BuildQuestion> getListScreen(){
    return [
      BuildQuestion(
          QuizQuestion(4, 'Complétez l\'expression : Qui vole un œuf vole…', 2,
              'Un keuf,Un oeuf,Un neuf,Un boeuf', 'Un boeuf', 0, 1),
          refreshScore),
      BuildQuestion(
          QuizQuestion(1, 'Mon nom est-il Astier ?', 1, '', 'Vrai', 0, 1), refreshScore),
      BuildQuestion(
          QuizQuestion(2, 'Mon prénom est-il Astier ?', 1, '', 'Faux', 0, 1),
          refreshScore),
    ];
}
}
