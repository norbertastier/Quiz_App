import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:quiz_app/models/quiz_question.dart';
import 'package:quiz_app/BuildQuestion.dart';

class QuestionPage extends StatefulWidget {
  int idQuiz;
  QuestionPage(this.idQuiz);
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int initialscore = 0;
  List<BuildQuestion> to7questions = [];
  int _selectedScreenIndex = 0;
  int limitTime = 120 * 1000;
  int endTime = DateTime.now().millisecondsSinceEpoch + 120 * 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
    else if (n >= 10) return "$n";
    return "0$n";
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

  void refreshScore() {
    initialscore++;
    print('Score : ' + initialscore.toString());
  }

  List<BuildQuestion> getListScreen() {
    List<List<BuildQuestion>> list = [
      [
        BuildQuestion(
            QuizQuestion(
                1,
                'De quel art martial/sport de combat, provient la boxe Americaine ?',
                2,
                'Boxe Anglaise,Taekwendo,Karaté,Grapling',
                'Karaté',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                2,
                'En natation, quel est le second nom du crawl ?',
                2,
                'Flotteur,Rafting,Funboard,Nage Libre',
                'Nage Libre',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                3,
                'Le nombre maximum de rameurs en aviron est de 6',
                1,
                '',
                'Faux',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                10,
                'Combien de fois Lewis Hamilton est champion du monde de F1 ?',
                2,
                '2,4,7,8',
                '7',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                11,
                'En 1968, aux Jeux olympiques d\'hiver de Grenoble, le français Jean Claude Killy a remporté 4 médialles d\'or',
                1,
                '',
                'Faux',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
              12,
              'Pour le mondial 98, les deux pays qualifiés d\'office étaient le Brésil et…',
              2,
              'L\'Allemagne,L\'Italie,Les Etats Unis,La France',
              'La France',
              0,
              1,
            ),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                13,
                'Un adepte du Yoga est un ….',
                2,
                'Yogan,Yogou,Yogi,Yaourt',
                'Yogi',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                14,
                'En cyclisme, l\'autre nom du Tour d\'Espagne est le Giro',
                1,
                '',
                'Faux',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                14,
                'Sawao kato est le japonais le plus titré de l\'histoire des jeux olympiques, avec 12 médailles, dont 8 en or. Dans quelle discipline représentait-il son pays ? ',
                2,
                'Le badminton,Le ping-pong,La gymnastique artistique,L\'escrime',
                'La gymnastique artistique',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                15,
                'Quand un joueur enlève son maillot après avoir marqué un but, il recoit un carton jaune',
                1,
                '',
                'Vrai',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                16,
                'Quel sport surnomme-t-on la petite reine ?',
                2,
                'Football,Rugby,Athlétisme,Cyclisme',
                'Cyclisme',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                16,
                'Pour quel pays jouait Mike Gybson au rugby international ?',
                2,
                'Nouvelle Zelande,Irlande,Afrique Du Sud,Espagne',
                'Irlande',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                17,
                'La première compétition sportive chronométrée était une épreuve de natation',
                1,
                '',
                'Faux',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                18,
                'En compétition, aucun coureur blanc n\'est passé sous la barre des 10 secondes à l\'épreuve de sprint du 100 mètres avant le XXI siècle',
                1,
                '',
                'Vrai',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                19,
                'En 2010, l\'Américaine Gladys Burril a couru le marathon d\'Honolulu (Hawaï) en 9 heures et 53 minutes. C\'est pourtant un exploit. Pourquoi ?',
                2,
                'Elle avait plus de 90 ans,Elle est unijambiste,Elle est aveugle,Elle avait 4 ans',
                'Elle avait plus de 90 ans',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                20,
                'Combien de fois Claudio Chiapucci a-t-il remporté le tour de France ?',
                2,
                '0,1,2,3',
                '0',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                21,
                'En quelle année les premiers Jeux paralympiques d\hiver ont-ils eu lieu ?',
                2,
                'En 1948,En 1960,En 1976,En 1980',
                'En 1976',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                22,
                'Quand les Jeux olympiques d\'hiver ont-ils eu lieu pour la dernière fois la même année que ceux d\'été',
                2,
                'En 1992,En 1976,Ils n\'ont jamais eu la même année,En 1988',
                'En 1992',
                0,
                1),
            refreshScore)
      ],

      //========================================================================================
      //========================================================================================

      [
        BuildQuestion(
            QuizQuestion(
                4,
                'Combien de Travaux le héro Grec Hercule a-t-il du entreprendre ?',
                2,
                '10,11,12,13',
                '12',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                5,
                'Nicolas Sarkozy n\'a eu qu\'un seul premier ministre',
                1,
                '',
                'Vrai',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                6,
                'Quel était la devise de la France sous Petain ?',
                2,
                'Liberté Egalité Fraternité,Honeur Egalité Travail,Travail Famille Patrie,Encore au delas',
                'Travail Famille Patrie',
                0,
                2),
            refreshScore),
      ],

      //========================================================================================
      //========================================================================================

      [
        BuildQuestion(
            QuizQuestion(
                7,
                'Les scientifiques estiment le diamètre de la Terre a :',
                2,
                '12600 kilomètres,2700 kilomètres,5900 kilomètres,9300 kilomètres',
                '12600 kilomètres',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                8,
                'Un angle dit "rentrant" a une mesure inférieure à 180°',
                1,
                '',
                'Faux',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                9,
                'Le carré de -2 est égal à -4',
                1,
                '',
                'Faux',
                0,
                3),
            refreshScore),
      ]
    ];

    if (to7questions.length == 0) {
      List<BuildQuestion> listtheme = list[widget.idQuiz - 1];
      if (listtheme.length < 8) {
        return listtheme;
      }
      else {
        while (to7questions.length < 7) {
          BuildQuestion question = listtheme[Random().nextInt(
              listtheme.length)];
          if (!to7questions.contains(question)) {
            to7questions.add(question);
            print(to7questions.length.toString() + "/" +
                listtheme.length.toString());
          }
        }
        return to7questions;
      }
    }return to7questions;
  }
}
