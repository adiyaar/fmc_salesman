import 'package:flutter/material.dart';

class GlobalSnackBar {
  final String message;

  const GlobalSnackBar({
    @required this.message,
  });

  static show(
    BuildContext context,
    String message,
  ) {
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(
      SnackBar(
        elevation: 0.0,
        //behavior: SnackBarBehavior.floating,
        content: Text(message),
        duration: new Duration(seconds: 3),

        action: SnackBarAction(
          textColor: Color(0xFFFAF2FB),
          label: '',
          onPressed: () {},
        ),
      ),
    );
  }
}
