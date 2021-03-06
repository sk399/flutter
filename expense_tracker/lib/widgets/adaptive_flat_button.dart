import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdpativeFlatButton extends StatelessWidget {
  final String text;
  final Function handler;
  AdpativeFlatButton(this.text, this.handler);
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return TextButton(
        //color: Theme.of(context).accentColor,
        child: Text(text),
        onPressed: () {
          handler();
        },
      );
    }
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(text),
            onPressed: () {
              handler();
            },
          )
        : TextButton(
            //color: Theme.of(context).accentColor,
            child: Text(text),
            onPressed: () {
              handler();
            },
          );
  }
}
