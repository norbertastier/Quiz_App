import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:quiz_app/QuizDataBase.dart';
import 'package:quiz_app/models/quiz_theme.dart';

class QuizThemePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuizThemePageState();
  }
}

class QuizThemePageState extends State<QuizThemePage> {
  
  @override
  Widget _buildQuizTheme(String path, String text,int id) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      width: double.maxFinite,
      height: 190,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage(path),
          fit: BoxFit.contain,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BorderedText(
            strokeWidth: 3.0,
            strokeColor: Color(0xfffd7d8d4),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'SegoeUIBlack',
                color: Color(0xfffffbfa),
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.only(
                right: 20,
                left: 20,
              ),
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
                    'Lancer le quiz',
                    style: TextStyle(
                        fontFamily: 'SegoeUIBlack', color: Color(0xfffffbfa)),
                    textScaleFactor: 1.2,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/QuestionPage', arguments:id);
                    print('Pressed');
                  })),
        ],
      ),
    );
  }

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
        body: FutureBuilder<List<QuizTheme>>(
            future: QuizDataBase.instance.themes(),
            builder:
                (BuildContext context, AsyncSnapshot<List<QuizTheme>> snapshot) {
              if (snapshot.hasData) {
                List<QuizTheme> themes = snapshot.data;
                return ListView.builder(
                  itemCount: themes.length,
                  itemBuilder: (context, index) {
                    final theme = themes[index];
                    return _buildQuizTheme(theme.thmPath, theme.thmName,theme.thmId);
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
