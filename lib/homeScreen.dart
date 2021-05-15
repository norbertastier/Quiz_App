import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  VoidCallback callback;
  HomePage(this.callback);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      child: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Image.asset(
            'assets/logo.png',
            scale: 0.75,
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: 30,
            ),
            child: Text(
              "Quizn'nap",
              textScaleFactor: 4,
              style: TextStyle(fontFamily: 'SegoeUIBlack'),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xfffffbfa),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(70.0),
                    topRight: const Radius.circular(70.0),
                  )),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          //color: Colors.purple,
                          padding: EdgeInsets.only(
                            left: 50,
                            right: 50,
                            top: 40,
                            bottom: 40,
                          ),
                          child: Text(
                            "Plusieurs questionnaires sont disponibles pour parfaire vos connaissances dans plusieurs domaines",
                            style: TextStyle(
                              fontFamily: 'SegoeUIBlack',
                            ),
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.6,
                          ),
                        ),
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
                                  'Jouer maintenant',
                                  style: TextStyle(
                                      fontFamily: 'SegoeUIBlack',
                                      color: Color(0xfffffbfa)),
                                  textScaleFactor: 1.6,
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.callback();
                                  });
                                })),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
