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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff8BD7D2), Color(0xff00BD9D)],
        ),
      ),
      child: Scaffold(
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
      ),
    );
  }

  Widget _buildCounter(CurrentRemainingTime time) {
    return Container(
      width: 500,
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
                'Boxe Anglaise,Taekwendo,Karat??,Grapling',
                'Karat??',
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
                3, 'Le nombre maximum de rameurs en aviron est de 6',
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
                'En 1968, aux Jeux olympiques d\'hiver de Grenoble, le fran??ais Jean Claude Killy a remport?? 4 m??dialles d\'or',
                1,
                '',
                'Faux',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
              12,
              'Pour le mondial 98, les deux pays qualifi??s d\'office ??taient le Br??sil et???',
              2,
              'L\'Allemagne,L\'Italie,Les Etats Unis,La France',
              'La France',
              0,
              1,
            ),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                13, 'Un adepte du Yoga est un ???.',
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
                23,
                'Sawao kato est le japonais le plus titr?? de l\'histoire des jeux olympiques, avec 12 m??dailles, dont 8 en or. Dans quelle discipline repr??sentait-il son pays ? ',
                2,
                'Le badminton,Le ping-pong,La gymnastique artistique,L\'escrime',
                'La gymnastique artistique',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                15,
                'Quand un joueur enl??ve son maillot apr??s avoir marqu?? un but, il recoit un carton jaune',
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
                'Football,Rugby,Athl??tisme,Cyclisme',
                'Cyclisme',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                24,
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
                'La premi??re comp??tition sportive chronom??tr??e ??tait une ??preuve de natation',
                1,
                '',
                'Faux',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                18,
                'En comp??tition, aucun coureur blanc n\'est pass?? sous la barre des 10 secondes ?? l\'??preuve de sprint du 100 m??tres avant le XXI si??cle',
                1,
                '',
                'Vrai',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                19,
                'En 2010, l\'Am??ricaine Gladys Burril a couru le marathon d\'Honolulu (Hawa??) en 9 heures et 53 minutes. C\'est pourtant un exploit. Pourquoi ?',
                2,
                'Elle avait plus de 90 ans,Elle est unijambiste,Elle est aveugle,Elle avait 4 ans',
                'Elle avait plus de 90 ans',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                20,
                'Combien de fois Claudio Chiapucci a-t-il remport?? le tour de France ?',
                2,
                '0,1,2,3',
                '0',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                21,
                'En quelle ann??e les premiers Jeux paralympiques d\'hiver ont-ils eu lieu ?',
                2,
                'En 1948,En 1960,En 1976,En 1980',
                'En 1976',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                22,
                'Quand les Jeux olympiques d\'hiver ont-ils eu lieu pour la derni??re fois la m??me ann??e que ceux d\'??t?? ?',
                2,
                'En 1992,En 1976,Ils n\'ont jamais eu la m??me ann??e,En 1988',
                'En 1992',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                25,
                'Combien de fois le Boxeur Franck Judes est-il devenus champion du monde de boxe professionnelle ?',
                2,
                '1,2,3,4',
                '3',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                26,
                'Rafael Nadal n\'est pas de nationnalit?? Espagnole',
                1,
                '',
                'Faux',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                27,
                'Il faut avoir minimum 15 ans pour obtenir la ceinture noire au Judo',
                1,
                '',
                'Vrai',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                28,
                'Quel est le record de distance au lancer de javelot toutes cat??gories confondues ?',
                2,
                '98.48m,76.23m,112.76m,69.11m',
                '98.48m',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                29,
                'Le second nom de la p??tanque est \'La Savate\'',
                1,
                '',
                'Faux',
                0,
                1),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                30,
                'De quelle origine est le curling ?',
                2,
                'Hollandais,Irlandais,Ecossais,Su??dois', 'Ecossais',
                0,
                1),
            refreshScore),
      ],

      //========================================================================================
      //========================================================================================

      [
        BuildQuestion(
            QuizQuestion(
                4,
                'Combien de Travaux le h??ro Grec Hercule a-t-il du entreprendre ?',
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
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                6,
                'Quel ??tait la devise de la France sous Petain ?',
                2,
                'Libert?? Egalit?? Fraternit??,Honeur Egalit?? Travail,Travail Famille Patrie,Encore au delas',
                'Travail Famille Patrie',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                31,
                'La guerre de Cor??e a eu lieu entre 1950 et 1953',
                1,
                '',
                'Vrai',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                32,
                'La Sierra Leone est un pays situ?? en Am??rique du Sud',
                1,
                '',
                'Faux',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                34,
                'Quel pays d\'am??rique du Sud partage une fronti??re avec le Panama ?',
                2,
                'Argentine,Chilli,Colombie,Br??sil',
                'Colombie',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                35,
                'Quelle est la langue officielle du Br??sil ?',
                2,
                'Espagnol,Br??silien,Anglais,Portugais',
                'Portugais',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                36,
                'Le Tigre est un fleuve qui prend sa source en Turquie',
                1,
                '',
                'Vrai',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                37,
                'Combien y\'a t-il de merveille du monde ?',
                2,
                '12,3,7,9',
                '7',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                38,
                'Quel oc??an, l\'Atlantique rencontre-t-il au Cap Horn ?',
                2,
                'Indien,Arctique,Pacifique,M??diterran??e',
                'Pacifique',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                39,
                'Moli??re a v??cu sous le r??gne de Louis XIV',
                1,
                '',
                'Vrai',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                40,
                'Le pr??sident Kennedy a dit "I have a dream???"',
                1,
                '',
                'Faux',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                42,
                'Quelle ville de France est r??put??e pour son nougat ?',
                2,
                'Mont??limar,Brest,Lille,Grenoble',
                'Mont??limar',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                43,
                'D???o?? viennent les petites cr??pes "Blini" ?',
                2,
                'Italie,Liban,Russie,Espagne',
                'Russie',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                44,
                'Quelle ville italienne est c??l??bre pour sa tour pench??e ?',
                2,
                'Rome,Turin,Pise,Milan',
                'Pise',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                45,
                'Jusqu\'en 1947, de quel pays faisait partie la Pakistan ?',
                2,
                'Egypte,Russie,Inde,Iran',
                'Inde',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                48,
                'Abuja est la capitale du Nigeria',
                1,
                '',
                'Vrai',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                49,
                'Ath??ne s\'appelait autre fois Constantinople',
                1,
                '',
                'Faux',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                50,
                'La capitale du Guatemala est Guatemala',
                1,
                '',
                'Vrai',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                51,
                'L\'Union Europ??enne compte plus de 25 pays',
                1,
                '',
                'Vrai',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                52,
                'Socrate est mort empoisonn??',
                1,
                '',
                'Vrai',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                53,
                'Nantes est situ??e en Vend??e',
                1,
                '',
                'Faux',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                54,
                'Les Parisiens boivent l\'eau de la Seine',
                1,
                '',
                'Vrai',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                55,
                'La bataille de Marignan a eu lieu en 1515 en France',
                1,
                '',
                'Faux',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                56,
                'Nous f??tons la saint Sylvestre le 31 d??cembre',
                1,
                '',
                'Vrai',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                57,
                'L\'Uruguay et le Paraguay ont une fronti??re commune',
                1,
                '',
                'Faux',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                58,
                'Le premier homme a ??tre all?? dans l\'espace est l\'am??ricain Buzz Aldrin',
                1,
                '',
                'Faux',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                60,
                'Lequel de ces c??l??bres peintres est de la Renaissance ?',
                2,
                'Raphael,Delacroix,Goya,Ingres',
                'Raphael',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                66,
                'Tachkent est la capitale : ',
                2,
                'De l\'Ouzb??kistan,Du Tadjikistan,Du Kazakhstan,Du Kirghizistan',
                'De l\'Ouzb??kistan',
                0,
                2),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                61,
                'De combien de kilom??tre le canal de Suez est-il long ?',
                2,
                '76.35 kilom??tres,162.25 kilom??tres,224.40 kilom??tres,120.50 kilom??tres',
                '162.25 kilom??tres',
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
                'Les scientifiques estiment le diam??tre de la Terre a :',
                2,
                '12600 kilom??tres,2700 kilom??tres,5900 kilom??tres,9300 kilom??tres',
                '12600 kilom??tres',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                8,
                'Un angle dit "rentrant" a une mesure inf??rieure ?? 180??',
                1,
                '',
                'Faux',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                9,
                'Le carr?? de -2 est ??gal ?? -4',
                1,
                '',
                'Faux',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                33,
                '1246272 est un multiple de 3',
                1,
                '',
                'Vrai',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                41,
                'Le pancr??as s??cr??te :',
                2,
                'L\'insuline,L\'h??moglobine,La bile,Le nitr??ne',
                'L\'insuline',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                46,
                'Les antibiotiques agissent sur les virus',
                1,
                '',
                'Faux',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                46,
                'Jupiter est une plan??te tellurique',
                1,
                '',
                'Faux',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                47,
                'Le blanc est la couleur obtenue en additionnant toutes les couleurs',
                1,
                '',
                'Vrai',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                59,
                'La gestation chez l\'??l??phant dure 2 ans',
                1,
                '',
                'Vrai',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                62,
                'Certaines esp??ces de cam??l??ons pr??sentent la particularit?? d avoir des :',
                2,
                'Nageoires,Ailes,Branchies,Cornes',
                'Cornes',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                63,
                'Les Flamands roses sont roses ?? cause d\'une r??action chimique entre l\'eau et leur plume',
                1,
                '',
                'Faux',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                64,
                'Le Volt est l\'unit?? :',
                2,
                'De la tension,Du courant,De l\'inductence,De la r??sistance',
                'De la tension',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                65,
                'Le nombre de personnes autoris??es ?? poursuivre des ??tudes de m??decine est fix?? par le :',
                2,
                'Numerus Quantus,Numerus Quorus,Numerus Closus,Numerus Cantus',
                'Numerus Closus',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                67,
                'Quel groupe sanguin est donneur universel ?',
                2,
                'A+,B,O-,AB+',
                'O-',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                68,
                'Quel est le symbole chimique de l\'azote ?',
                2,
                'Na,N,As,Az',
                'N',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                69,
                'Quand la chaleur se transmet d\'un point ?? un autre ?? travers un fluide, on dit qu\'elle se propage par :',
                2,
                'Conduction,Convexion,Rayonnement,Thermission',
                'Conduction',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                70,
                'L\'Univers est vieux de plus de 13.7 milliards d\'ann??es',
                1,
                '',
                'Vrai',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                71,
                'Le nombre de neuronnes dans le cerveau humain est de l\'ordre :',
                2,
                '10^6,10^9,10^11,10^13',
                '10^11',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                72,
                'Environ 450 millions de personnes sont touch??es par le diab??te dans le monde',
                1,
                '',
                'Vrai',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                73,
                'Dans quel produit trouve-t-on l???ensemble de ces compos??s chimiques: ??thanol, ac??tone, formald??hyde, di??thoxy??thane et ??thylbutyrate ?',
                2,
                'Une cigarette,Une pomme,De la peinture,De la javel',
                'Une pomme',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                74,
                'Une ann??e lumi??re mesure :',
                2,
                'Le temps,Une distance,Une dimension,Le poid d\'un astre',
                'Une distance',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                75,
                'Quelle invention est la plus vieille ?',
                2,
                'Le t??lescope,Le tourne disque,La t??l??phonie,La t??l??vision',
                'Le t??lescope',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                76,
                'Laquelle de ces civilisations ??teintes n???est pas associ??e ?? l???Am??rique centrale ?',
                2,
                'Maya,Inca,Azt??que,Zapot??que',
                'Inca',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                77,
                'Le Nil Blanc est plus long que le Nil',
                1,
                '',
                'Faux',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                78,
                'Les humains et les dinosaures ont exist??s ensemble une tr??s courte p??riode',
                1,
                '',
                'Faux',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                79,
                'Laquelle de ces inventions n\'a pas ??t?? conceptualis??e par L??onard de Vinci :',
                2,
                'Le tank,Le parachute,Le v??lo,L\'h??licopt??re',
                'Le v??lo',
                0,
                3),
            refreshScore),
        BuildQuestion(
            QuizQuestion(
                80,
                'Le p??le Nord est plus froid que le p??le Sud',
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
