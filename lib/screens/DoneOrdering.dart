import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'HomeScreen.dart';

class DoneOrdering extends StatefulWidget {
  List userInfo;
  DoneOrdering({Key key, this.userInfo}) : super(key: key);

  @override
  _DoneOrderingState createState() => _DoneOrderingState();
}

class _DoneOrderingState extends State<DoneOrdering> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      userList: widget.userInfo,
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Order Placed Successfully !',
              style: TextStyle(fontSize: 28, color: Colors.black),
            ),
            Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_Dcbowq.json',
                height: 350,
                width: 350),
          ],
        ),
      ),
    );
  }
}
