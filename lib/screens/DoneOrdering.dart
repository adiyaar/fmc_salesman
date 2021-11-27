import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'HomeScreen.dart';

class DoneOrder extends StatelessWidget {
  const DoneOrder({Key key}) : super(key: key);

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
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Text('Go to HomePage'))
          ],
        ),
      ),
    );
  }
}
