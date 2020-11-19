import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;
  static const _questions = const [
    {
      'questionText': 'What\'s my favourite color?',
      'answers': [
        {'text': 'Red', 'score': 10},
        {'text': 'Blue', 'score': 20},
        {'text': 'Black', 'score': 5},
        {'text': 'Green', 'score': 10},
      ]
    },
    {
      'questionText': 'What\'s my favourite snax?',
      'answers': [
        {'text': 'Ice cream', 'score': 10},
        {'text': 'Choclate', 'score': 11},
        {'text': 'Pudding', 'score': 10},
        {'text': 'Haldiram', 'score': 20},
      ]
    },
    {
      'questionText': 'What\'s my favourite animal?',
      'answers': [
        {'text': 'Tiger', 'score': 10},
        {'text': 'Lion', 'score': 20},
        {'text': 'Dog', 'score': 10},
        {'text': 'Cat', 'score': 10},
      ]
    },
    {
      'questionText': 'What\'s my favourite pass time?',
      'answers': [
        {'text': 'Netflix', 'score': 10},
        {'text': 'Amazon Prime', 'score': 10},
        {'text': 'Zee 5', 'score': 10},
      ]
    },
  ];
  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    // print(_questionIndex);
    _totalScore += score;
    print('Total score:$_totalScore');
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('Question index:$_questionIndex');
    // print('Total Questions:$_questions.length');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz app'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
