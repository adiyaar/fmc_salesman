import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/dynamic/All_branch.dart';
import 'package:testing/dynamic/All_branch_add.dart';
import 'package:testing/dynamic/itemmaster.dart';
import 'package:http/http.dart' as http;
import 'package:testing/models/UserInfo.dart';
import 'package:testing/screens/CartPage.dart';
import 'package:testing/screens/GenerateSales.dart';
import 'package:testing/screens/LoginScreen.dart';
import 'package:testing/widget/NavigationDrawer.dart';
import 'package:unicorndial/unicorndial.dart';
import 'ItemMainGroup.dart';
import 'SearchScreen.dart';

class HomeScreen extends StatefulWidget {
  final List userList;
  const HomeScreen({Key key, @required this.userList}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String customerName,
      branchname,
      creditDays,
      creditLimit,
      customerEmail,
      customerType;
  void fetchAllCustomerData() async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    pf.reload();
    setState(() {
      branchname = pf.getString('customerBranch');
      customerName = pf.getString('customerName');
      creditLimit = pf.getString('credit_limit');
      creditDays = pf.getString('credit_days');
      customerEmail = pf.getString('cemail');
      customerType = pf.getString('cust_type');
    });
  }

  int a;
  Future fetchCrtCOunt() async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    String customerId = pf.getString('customerId');
    String branchId = pf.get('branchId');
    Map<String, dynamic> data = {
      'userid': customerId,
      'selectedcustbranch': branchId
    };
    String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesman_cart.php';
    var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    // print(jsonResponse);
    print(jsonResponse.length);
    a = jsonResponse.length;
    setState(() {});
    return a;
  }

  @override
  void initState() {
    super.initState();
    fetchAllCustomerData();
    fetchCrtCOunt();
  }

  @override
  Widget build(BuildContext context) {
    fetchCrtCOunt();
    final floatingButtons = <UnicornButton>[];
    floatingButtons.add(
      UnicornButton(
        hasLabel: true,
        labelText: "Search",
        currentButton: FloatingActionButton(
          onPressed: () {},
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => branch_add()),
            );
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
        labelText: "Login ",
        currentButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreenPage()),
            );
          },
          heroTag: "Login",
          backgroundColor: Colors.black,
          mini: true,
          child: Icon(Icons.login),
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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.search_rounded),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchScreen(
                        userInfo: widget.userList,
                      )));
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Family Medical Company',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          //IconButton
          IconButton(
            icon: Icon(Icons.star_border),
            tooltip: 'MainGroup',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemMainGroup(
                            userInfo: widget.userList,
                          )));
            },
          ), //IconButton
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart_outlined),
                tooltip: 'MainGroup',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartPage(
                                useriNfo: widget.userList,
                              )));
                },
              ),
              CircleAvatar(
                radius: 9,
                backgroundColor: Colors.yellow,
                child: Visibility(
                  visible: a != null,
                  child: Text(
                    '$a',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ), //IconButton
        ],
      ),
      drawer: NavigationDrawer(
        userInfo: widget.userList,
      ),
      body: SingleChildScrollView(
          child: Container(
        decoration: new BoxDecoration(color: Color(0xFFf2f2f2)),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFd9d9d9)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFd9d9d9),
                                    offset: const Offset(
                                      1.0,
                                      1.0,
                                    ),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ),
                                  //BoxShadow
                                ],
                                color: Colors.white,
                              ),
                              width: 150.0,
                              height: 100.0,
                              //color: Colors.white,
                              child: Center(
                                child: InkWell(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 25.0,
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              '3',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              'Company',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFb3b3b3),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {}),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFd9d9d9)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFd9d9d9),
                                  offset: const Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ),
                                //BoxShadow
                              ],
                              color: Colors.white,
                            ),
                            width: 150.0,
                            height: 100.0,
                            //color: Colors.white,
                            child: Center(
                              child: InkWell(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 25.0,
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text(
                                            '12',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text(
                                            'Branch',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFb3b3b3),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => All_branch()),
                                    );
                                  }),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFd9d9d9)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFd9d9d9),
                                  offset: const Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ),
                                //BoxShadow
                              ],
                              color: Colors.white,
                            ),
                            width: 150.0,
                            height: 100.0,
                            //color: Colors.white,
                            child: Center(
                              child: InkWell(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 25.0,
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text(
                                            '22000',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text(
                                            'Items',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFb3b3b3),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Itemmaster()),
                                    );
                                  }),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFd9d9d9)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFd9d9d9),
                                    offset: const Offset(
                                      1.0,
                                      1.0,
                                    ),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ),
                                  //BoxShadow
                                ],
                                color: Colors.white,
                              ),
                              width: 150.0,
                              height: 100.0,
                              //color: Colors.white,
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 25.0,
                                    ),
                                    Container(
                                      child: Center(
                                        child: Text(
                                          '102',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Center(
                                        child: Text(
                                          'Employees',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFb3b3b3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFd9d9d9)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFd9d9d9),
                                    offset: const Offset(
                                      1.0,
                                      1.0,
                                    ),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ),
                                  //BoxShadow
                                ],
                                color: Colors.white,
                              ),
                              width: 150.0,
                              height: 100.0,
                              //color: Colors.white,
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 25.0,
                                    ),
                                    Container(
                                      child: Center(
                                        child: Text(
                                          '986',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Center(
                                        child: Text(
                                          'Customer',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFb3b3b3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFd9d9d9)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFd9d9d9),
                                    offset: const Offset(
                                      1.0,
                                      1.0,
                                    ),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ),
                                  //BoxShadow
                                ],
                                color: Colors.white,
                              ),
                              width: 150.0,
                              height: 100.0,
                              //color: Colors.white,
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 25.0,
                                    ),
                                    Container(
                                      child: Center(
                                        child: Text(
                                          '189',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Center(
                                        child: Text(
                                          'Supplier',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFb3b3b3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFd9d9d9)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFd9d9d9),
                                offset: const Offset(
                                  1.0,
                                  1.0,
                                ),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ),
                              //BoxShadow
                            ],
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          height: 100.0,
                          //color: Colors.white, if box decoration is there u cant keep color outside it should be compulsory inside
                          child: Row(
                            children: [
                              MaterialButton(
                                onPressed: () {},
                                color: Colors.red,
                                textColor: Colors.white,
                                child: Icon(
                                  Icons.chat_bubble,
                                  size: 24,
                                ),
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    width: 230.0,
                                    height: 40.0,
                                    color: Colors.white,
                                    child: Text(
                                      '18',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 230.0,
                                    height: 30.0,
                                    color: Colors.white,
                                    child: Text(
                                      'No of Leads',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFb3b3b3),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //     height: 30,
                        //     alignment: Alignment.centerLeft,
                        //     child: TextButton(
                        //       onPressed: () async {
                        //         SharedPreferences pf =
                        //             await SharedPreferences.getInstance();
                        //         pf.clear();
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) =>
                        //                     GenerateSalesOrder()));
                        //       },
                        //       child: Text("Generate Sales Order",
                        //           style: TextStyle(color: Colors.black)),
                        //     )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible: customerName != null,
                              child: Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  customerName == null ? "" : customerName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                SharedPreferences pf =
                                    await SharedPreferences.getInstance();

                                pf.remove('customerName');
                                pf.remove('credit_limit');
                                pf.remove('credit_days');
                                pf.remove('customerBranch');
                                pf.remove('cust_type');

                                print("Clearred");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GenerateSalesOrder(
                                            userInfo: widget.userList,
                                          )),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.yellow),
                                child: customerName == null
                                    ? Text(
                                        "Generate Sales Order",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : Text(
                                        "Clear Customer",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                              ),
                            )
                          ],
                        ),
                        Visibility(
                          visible: branchname != null,
                          child: Container(
                            margin: EdgeInsets.only(left: 8),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Customer Branch - $branchname",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: creditLimit != null,
                          child: Container(
                            margin: EdgeInsets.only(left: 8),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Credit Limit - $creditLimit",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: creditDays != null,
                          child: Container(
                            margin: EdgeInsets.only(left: 8),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Credit Days - $creditDays",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: customerType != null,
                          child: Container(
                            margin: EdgeInsets.only(left: 8),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Invoice Price - $customerType",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Container(
                        //   child: customerName == null
                        //       ? Text("")
                        //       : Text(customerName),
                        // ),
                        // Container(
                        //   child:
                        //       creditDays == null ? Text("") : Text(creditDays),
                        // ),
                        // Container(
                        //   child: creditLimit == null
                        //       ? Text("")
                        //       : Text(creditLimit),
                        // ),
                        // Container(
                        //   child: customerType == null
                        //       ? Text("")
                        //       : Text(customerType),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(),
                        // ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFd9d9d9)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFd9d9d9),
                                offset: const Offset(
                                  1.0,
                                  1.0,
                                ),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ),
                              //BoxShadow
                            ],
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          height: 100.0,
                          //color: Colors.white,
                          child: Row(
                            children: [
                              MaterialButton(
                                onPressed: () {},
                                color: Colors.blue,
                                textColor: Colors.white,
                                child: Icon(
                                  Icons.chrome_reader_mode,
                                  size: 24,
                                ),
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    width: 230.0,
                                    height: 40.0,
                                    color: Colors.white,
                                    child: Text(
                                      '15',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 230.0,
                                    height: 30.0,
                                    color: Colors.white,
                                    child: Text(
                                      'No of Sales Quotation',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFb3b3b3),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFd9d9d9)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFd9d9d9),
                                offset: const Offset(
                                  1.0,
                                  1.0,
                                ),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ),
                              //BoxShadow
                            ],
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          height: 100.0,
                          //color: Colors.white,
                          child: Row(
                            children: [
                              MaterialButton(
                                onPressed: () {},
                                color: Colors.yellow,
                                textColor: Colors.white,
                                child: Icon(
                                  Icons.collections_bookmark,
                                  size: 24,
                                ),
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    width: 230.0,
                                    height: 40.0,
                                    color: Colors.white,
                                    child: Text(
                                      '10',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 230.0,
                                    height: 30.0,
                                    color: Colors.white,
                                    child: Text(
                                      'No of Sales Order',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFb3b3b3),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFd9d9d9)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFd9d9d9),
                                offset: const Offset(
                                  1.0,
                                  1.0,
                                ),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ),
                              //BoxShadow
                            ],
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          height: 100.0,
                          //color: Colors.white,
                          child: Row(
                            children: [
                              MaterialButton(
                                onPressed: () {},
                                color: Colors.orange,
                                textColor: Colors.white,
                                child: Icon(
                                  Icons.directions_bus,
                                  size: 24,
                                ),
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    width: 230.0,
                                    height: 40.0,
                                    color: Colors.white,
                                    child: Text(
                                      '7',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 230.0,
                                    height: 30.0,
                                    color: Colors.white,
                                    child: Text(
                                      'No of Delivery Note',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFb3b3b3),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFd9d9d9)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFd9d9d9),
                                offset: const Offset(
                                  1.0,
                                  1.0,
                                ),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ),
                              //BoxShadow
                            ],
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          height: 100.0,
                          //color: Colors.white,
                          child: Row(
                            children: [
                              MaterialButton(
                                onPressed: () {},
                                color: Colors.green,
                                textColor: Colors.white,
                                child: Icon(
                                  Icons.confirmation_number,
                                  size: 24,
                                ),
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    width: 230.0,
                                    height: 40.0,
                                    color: Colors.white,
                                    child: Text(
                                      '5',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 230.0,
                                    height: 30.0,
                                    color: Colors.white,
                                    child: Text(
                                      'No of Sales Invoice',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFb3b3b3),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
