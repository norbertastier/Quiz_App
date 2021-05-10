import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:quiz_app/QuizDataBase.dart';
import 'package:quiz_app/models/quiz_question.dart';



class QuestionPage extends StatelessWidget {
  /*const QuestionPage({Key key, @required this.question}) : super(key: key);
  final QuizQuestion question;*/
  int limitTime = 120 * 100;
  int endTime = DateTime.now().millisecondsSinceEpoch + 120 * 100;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff8BD7D2), Color(0xff00BD9D)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: CountdownTimer(
                endTime: endTime,
                widgetBuilder: (_, CurrentRemainingTime time) {
                  if (time == null) {
                    return Text(
                      'Game over',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'SegoeUIBlack',
                      ),
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
              ),
            ),
            Container(
              color: Colors.red,
              width: 30,
            )
          ],
        ),
      ),
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
        value: (limitTime/1000 - _toSecond(time))/(limitTime/1000),
      ),
    );
  }
  static String _twoDigits(int n) {
    if(n == null) return "00";
    else if (n >= 10) return "${n}";
    return "0${n}";
  }

  static String _printTime(CurrentRemainingTime time){
    return '${_twoDigits(time.min)}:${_twoDigits(time.sec)}';
  }

  static int _toSecond(CurrentRemainingTime time){
    if(time.min == null) return time.sec;
    else if (time.sec == null) return 0;
    else return time.min * 60 + time.sec;
  }
}
