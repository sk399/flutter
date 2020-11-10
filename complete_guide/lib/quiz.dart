import 'package:complete_guide/question.dart';
import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final Function answerQuestion;
  final int questionIndex;
  Quiz(
      {@required this.questions,
      @required this.questionIndex,
      @required this.answerQuestion});
  @override
  Widget build(BuildContext context) {
    // print(questions);

    return Column(
      children: [
        Question(questions[questionIndex]['questionText']),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(answer['score']), answer['text']);
        }).toList(),
      ],
    );
  }
}
