import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  String get resultPhrase {
    var resultText = 'You did it already!';
    if (resultScore <= 20) {
      resultText = 'You are Awesome!';
    } else if (resultScore <= 40) {
      resultText = 'You are super Awesome!';
    } else {
      resultText = 'You are meow!';
    }
    return resultText;
  }

  Result(this.resultScore, this.resetHandler);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text(
              'Start again',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: resetHandler,
          )
        ],
      ),
    );
  }
}
