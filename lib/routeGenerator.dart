import 'package:flutter/material.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/quizQuestionSceen.dart';
import 'package:quiz_app/quizScoreScreen.dart';
import 'package:quiz_app/quizThemeScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final int args = settings.arguments;

    switch (settings.name) {
      case '/MyHomePage':
        return MaterialPageRoute(builder: (_) => MyHomePage());

      case '/QuizThemePage':
        return MaterialPageRoute(builder: (_) => QuizThemePage());

      case '/QuestionPage':
        return MaterialPageRoute(builder: (_) => QuestionPage());

      case '/ScorePage':
      // Validation of correct data type
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) =>
                ScorePage(args),
          );
        }return _errorRoute();

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
