import 'package:flutter/material.dart';

import 'package:testing/dynamic/All_branch_add.dart';
import 'package:testing/dynamic/search_screen.dart';
import 'package:testing/homehorizontalrow.dart';
import 'package:testing/homeverticalcolumn.dart';
import 'package:testing/settings.dart';
import 'package:testing/widget/NavigationDrawer.dart';

import 'package:unicorndial/unicorndial.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final floatingButtons = List<UnicornButton>();

    floatingButtons.add(
      UnicornButton(
        hasLabel: true,
        labelText: "Search",
        currentButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Searchscreen()));
          },
          heroTag: "search",
          backgroundColor: Colors.black,
          mini: true,
          child: Icon(Icons.search),
        ),
      ),
    );

    floatingButtons.add(
      UnicornButton(
        hasLabel: true,
        labelText: "Create Company",
        currentButton: FloatingActionButton(
          onPressed: () {},
          heroTag: "Company",
          backgroundColor: Colors.black,
          mini: true,
          child: Icon(Icons.account_balance),
        ),
      ),
    );

    floatingButtons.add(
      UnicornButton(
        hasLabel: true,
        labelText: "Create Branch",
        currentButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => branch_add()),
            // );
          },
          heroTag: "Branch",
          backgroundColor: Colors.black,
          mini: true,
          child: Icon(Icons.device_hub),
        ),
      ),
    );

    floatingButtons.add(
      UnicornButton(
        hasLabel: true,
        labelText: "Create Customer",
        currentButton: FloatingActionButton(
          heroTag: "customer",
          backgroundColor: Colors.black,
          mini: true,
          child: Icon(Icons.supervisor_account),
          onPressed: () {},
        ),
      ),
    );
    floatingButtons.add(
      UnicornButton(
        hasLabel: true,
        labelText: "Create Item",
        currentButton: FloatingActionButton(
          onPressed: () {},
          heroTag: "Item",
          backgroundColor: Colors.black,
          mini: true,
          child: Icon(Icons.shopping_basket),
        ),
      ),
    );
// home page floating button end and call on scaffold below

    return Scaffold(
        floatingActionButton: UnicornDialer(
            backgroundColor: Colors.black38,
            parentButtonBackground: Colors.black,
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(Icons.add),
            childButtons: floatingButtons),
        appBar: AppBar(
          backgroundColor: Colors.black87,

          iconTheme: IconThemeData(color: Colors.white),
          //leading: Icon(Icons.menu, color: Colors.white),
          title: Text(
            'Family Medical Company',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            //IconButton
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ), //IconButton
          ],
        ),
        drawer: NavigationDrawer(),
        body: Container(
          decoration: new BoxDecoration(color: Color(0xFFf2f2f2)),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                    child: homehorizontalrow(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: homeverticalcolumn(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
