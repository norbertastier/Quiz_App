import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
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
            height: 60,
          ),
          Image.asset(
            'assets/profil.png',
            scale: 1,
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: 20,
            ),
            child: Text(
              "Pierre",
              style: TextStyle(fontFamily: 'SegoeUIBlack', fontSize: 25),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xfffffbfa),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(70.0),
                    topRight: const Radius.circular(70.0),
                  )),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        //color: Colors.purple,
                        padding: EdgeInsets.only(
                          left: 50,
                          right: 50,
                          top: 20,
                        ),
                        child: Image.asset(
                          'assets/Trophy.png',
                          scale: 1.75,
                        ),
                      ),
                      Text(
                        "107",
                        style:
                            TextStyle(fontFamily: 'SegoeUIBlack', fontSize: 25),
                      ),
                      _buildCongrate("Débutant"),
                      _buildCongrate("Novice"),
                      _buildCongrate("Spécialiste"),
                      _buildCongrate("Expert"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCongrate(String title) {
    return Container(
        alignment: Alignment.center,
        width: 250,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(
          bottom: 20,
          top: 20,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff8BD7D2), Color(0xff00BD9D)],
          ),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        child: Text(
          title,
          style:
              TextStyle(fontFamily: 'SegoeUIBlack', color: Color(0xfffffbfa)),
          textScaleFactor: 1.6,
        ));
  }
}
