import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
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
        /*body: Center(
          child: Text("COUCOU",
            style: TextStyle(fontSize: 60),),
        ),*/
        ),
    );
  }
}
