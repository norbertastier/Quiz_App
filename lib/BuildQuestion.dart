import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/quiz_question.dart';

class BuildQuestion extends StatefulWidget {
  VoidCallback refreshScore;
  final QuizQuestion question;
  BuildQuestion( this.question,this.refreshScore);

  @override
  _BuildQuestionState createState() => _BuildQuestionState();
}

class _BuildQuestionState extends State<BuildQuestion>{

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(
            top: 50,
            right: 30,
            left: 30,
            bottom: 30,
          ),
          decoration: BoxDecoration(
              color: Color(0xfffffbfa),
              borderRadius: BorderRadius.all(Radius.circular(40.0))),
          child: Column(
            children: [
              Text(
                widget.question.question,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'SegoeUIBlack',
                ),
                textAlign: TextAlign.justify,
              ),

              Expanded(child: Container(),),
              Center(child: _typeQuestion(question: widget.question),),
              Expanded(child: Container(),),
            ],
          ),
        ));

  }

  Widget _typeQuestion({QuizQuestion question,}) {
    if (question.type == 1) {
      return _buildTrueFalseOption(question);
    } else {
      return _buildMultipleOption(question);
    }
  }

  Widget _buildMultipleOption(QuizQuestion question) {
    List listOption = question.answers.split(',');
    String correct = question.correct;
    String option1 = listOption[0];
    String option2 = listOption[1];
    String option3 = listOption[2];
    String option4 = listOption[3];
    return Column(
      children: [
        _buildBouton(option1,correct),
        _buildBouton(option2,correct),
        _buildBouton(option3,correct),
        _buildBouton(option4,correct),
      ],
    );
  }

  Widget _buildTrueFalseOption(QuizQuestion question) {
    String correct = question.correct;
    String option1 = "Vrai";
    String option2 = "Faux";
    return Column(
      children: [
        _buildBouton(option1,correct),
        _buildBouton(option2,correct),
      ],
    );
  }
  Widget _buildBouton(String text, String correct) {

    Color color = getColor(text, correct);

    return Container(
      width: double.infinity,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(

          right: 10,
          left: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 3,
          ),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        child: TextButton(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'SegoeUIBlack',
                  color: Colors.black), //Color(0xfffffbfa)),
            ),
            onPressed: () {
              setState(() {
                if(text == correct && widget.question.enable == 0){
                  widget.refreshScore();

                 widget.question.enable = 1;
                }
                widget.question.enable = 1;
              });
            }));
  }

  Color getColor(String text, String correct,) {

    if (widget.question.enable == 0) {
      return Color(0xffBFBFBF);
    } else {
      return (correct == text) ? Colors.green : Colors.red;
    }
  }

}