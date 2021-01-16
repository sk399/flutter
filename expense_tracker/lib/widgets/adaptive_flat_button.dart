import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdpativeFlatButton extends StatelessWidget {
  final String text;
  final Function handler;
  AdpativeFlatButton(this.text, this.handler);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(text),
            onPressed: () {
              handler();
            },
          )
        : FlatButton(
            //color: Theme.of(context).accentColor,
            child: Text(text),
            onPressed: () {
              handler();
            },
          );
  }
}
