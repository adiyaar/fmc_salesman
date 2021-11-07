import 'package:flutter/material.dart';

import 'package:testing/widget/NavigationDrawer.dart';

class dynamiclistview extends StatefulWidget {
  @override
  _dynamiclistviewState createState() => _dynamiclistviewState();
}

class _dynamiclistviewState extends State<dynamiclistview> {

  List<String> litems = ["1","2","Third","4"];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Dynamic List View'),
      ),
      drawer:NavigationDrawer(),

        body: new ListView.builder
          (
            itemCount: litems.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return new Text(litems[index]);
            }
        )

    );
  }
}
