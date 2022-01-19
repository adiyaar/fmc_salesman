import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:testing/dynamic/All_branch.dart';
import 'package:testing/dynamic/Contact_Us.dart';
import 'package:testing/dynamic/itemmaster.dart';

import 'package:testing/screens/GenerateSales.dart';
import 'package:testing/screens/HomeScreen.dart';

import 'package:testing/screens/LoginScreen.dart';
import 'package:testing/settings.dart';

class NavigationDrawer extends StatefulWidget {
  List userInfo;
  NavigationDrawer({Key key, this.userInfo}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String workingIn;
  String employeeName;
  String employeeCode;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20.0,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black87,
              ),
              accountName: Text(
                widget.userInfo[0].employeename,
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.black,
                child: Text(
                  widget.userInfo[0].workingin,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
                title: new Text("Dashboard"),
                contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                leading: new Icon(Icons.home),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 0.0),
              //padding: EdgeInsets.all(10.0),
              // padding: EdgeInsets. symmetric(vertical: 20.0, horizontal: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  child: Text(
                    'Master',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            ListTile(
                title: new Text("Generate Sales"),
                contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                leading: new Icon(Icons.account_balance),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GenerateSalesOrder()));
                }),

            // ListTile(
            //     title: new Text("Detail Page"),
            //     contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
            //     trailing: Icon(Icons.keyboard_arrow_right),
            //     leading: new Icon(Icons.account_balance),
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => DetailPageScreen()));
            //     }),
            // ListTile(
            //     title: new Text("Checkout Page"),
            //     contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
            //     trailing: Icon(Icons.keyboard_arrow_right),
            //     leading: new Icon(Icons.account_balance),
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => CheckoutScreen()));
            //     }),
            // ListTile(
            //     title: new Text("Cart Page"),
            //     contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
            //     trailing: Icon(Icons.keyboard_arrow_right),
            //     leading: new Icon(Icons.account_balance),
            //     onTap: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => CartPage()));
            //     }),
            ListTile(
                title: new Text("Company"),
                contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                leading: new Icon(Icons.account_balance),
                onTap: () {}),
            ListTile(
                title: new Text("Branch"),
                contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                leading: new Icon(Icons.device_hub),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => All_branch()),
                  );
                }),
            ListTile(
                title: new Text("Items"),
                contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                leading: new Icon(Icons.shopping_basket),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Itemmaster()),
                  );
                }),
            ListTile(
                title: new Text("Customer"),
                contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                leading: new Icon(Icons.supervisor_account),
                onTap: () {}),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 0.0),
              //padding: EdgeInsets.all(10.0),
              // padding: EdgeInsets. symmetric(vertical: 20.0, horizontal: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  child: Text(
                    'Purchase',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            ListTile(
                title: new Text("Branch Request"),
                contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                leading: new Icon(Icons.assignment_return),
                onTap: () {}),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 0.0),
              //padding: EdgeInsets.all(10.0),
              // padding: EdgeInsets. symmetric(vertical: 20.0, horizontal: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  child: Text(
                    'Sales',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            ListTile(
                title: new Text("Leads"),
                contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                leading: new Icon(Icons.chat_bubble),
                onTap: () {}),
            ListTile(
                title: new Text("Sales Quotation"),
                contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                leading: new Icon(Icons.chrome_reader_mode),
                onTap: () {}),
            ListTile(
                title: new Text("Sales Order"),
                contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                leading: new Icon(Icons.collections_bookmark),
                onTap: () {}),
            ListTile(
                title: new Text("Delivery Note"),
                contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                leading: new Icon(Icons.directions_bus),
                onTap: () {}),
            ListTile(
                title: new Text("Delivery Note Return"),
                contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                leading: new Icon(Icons.directions_car),
                onTap: () {}),
            ListTile(
                title: new Text("Sales Invoice"),
                contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                leading: new Icon(Icons.confirmation_number),
                onTap: () {}),
            ListTile(
                title: new Text("Contact"),
                leading: new Icon(Icons.contact_phone),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Contact_Us()),
                  );
                }),
            ListTile(
                title: new Text("Setting"),
                leading: new Icon(Icons.contact_phone),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                }),
            ListTile(
                title: new Text("Log Out"),
                leading: new Icon(Icons.lock),
                onTap: () async {
                  SharedPreferences pf = await SharedPreferences.getInstance();
                  pf.clear();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreenPage()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
