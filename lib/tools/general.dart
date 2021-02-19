import 'package:flutter/material.dart';

void failMessage(message, context) {
  /// Showing Error messageSnackBarDemo
  /// Ability so close message
  final snackBar = SnackBar(
    content: Text('⚠️: $message'),
    duration: const Duration(seconds: 30),
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  Scaffold.of(context)
    // ignore: deprecated_member_use
    ..removeCurrentSnackBar()
    // ignore: deprecated_member_use
    ..showSnackBar(snackBar);
}
