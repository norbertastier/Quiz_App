import 'package:flutter/material.dart';
import 'package:quiz_app/main.dart';

class ScorePage extends StatefulWidget {
  final int score;
  const ScorePage(this.score);
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
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
        body: Center(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(
              top: 50,
              right: 30,
              left: 30,
              bottom: 50,
            ),
            decoration: BoxDecoration(
                color: Color(0xfffffbfa),
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/Trophy.png',
                  scale: 1,
                ),
                Text(
                  widget.score.toString()+'/10',
                  style: TextStyle(
                    fontSize: 60,
                    fontFamily: 'SegoeUIBlack',

                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'correctes',
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'SegoeUIBlack',

                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40,),
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xff8BD7D2), Color(0xff00BD9D)],
                      ),
                      borderRadius:
                      BorderRadius.all(Radius.circular(100)),
                    ),
                    child: TextButton(
                        child: Text(
                          'Nouveau Quiz',
                          style: TextStyle(
                              fontFamily: 'SegoeUIBlack',
                              color: Color(0xfffffbfa)),
                          textScaleFactor: 1.6,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          });
                        })),
              ],
            ),
          )
        ),
      ),
    );
  }
}
