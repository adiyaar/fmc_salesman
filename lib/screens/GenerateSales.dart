import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsify/responsify.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/Common/CustomerListLoader.dart';
import 'package:testing/models/GenerateBranch.dart';
import 'package:http/http.dart' as http;
import 'package:testing/models/GenerateCustomerList.dart';
import 'package:testing/widget/GlobalSnackbar.dart';

import 'HomeScreen.dart';

class GenerateSalesOrder extends StatefulWidget {
  List userInfo;
  GenerateSalesOrder({Key key, @required this.userInfo}) : super(key: key);

  @override
  _GenerateSalesOrderState createState() => _GenerateSalesOrderState();
}

class _GenerateSalesOrderState extends State<GenerateSalesOrder> {
  // ignore: non_constant_identifier_names
  String cust_email,
      branch_name,
      cust_type,
      credit_days,
      credit_limit,
      selectedcustbranch,
      staticValue,
      invoiceprice,
      invoicetype,
      cust_name;
  String customerSelected, branchSelected;

  TextEditingController customerEmailId = TextEditingController();

  String latitude;
  String longitude;

  addCustomerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('customerId', customerSelected);

    if (branchSelected == null) {
      prefs.setString('branchId', "null");
    } else {
      prefs.setString('branchId', branchSelected);
    }

    prefs.setString(
      'cemail',
      cust_email,
    );
    prefs.setString(
      'cust_type',
      cust_type,
    );
    prefs.setString(
      'credit_days',
      credit_days,
    );
    prefs.setString(
      'credit_limit',
      credit_limit,
    );
    prefs.setString('customerName', cust_name);
    if (branch_name == null) {
      prefs.setString('customerBranch', "No Branch");
    } else {
      prefs.setString('customerBranch', branch_name);
    }
  }

  Future getAllValue() async {
    final String url =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesman_selected_dropdown.php';
    var data = {
      'custid': customerSelected,
      'selectedcustbranch': branchSelected
    };

    var response = await http.post(Uri.parse(url), body: json.encode(data));
    var jsondataval = json.decode(response.body);

    return jsondataval;
  }

  List activity = ['Visit', 'Customer Visit', 'No Order', 'Order'];
  String activitySelected;

  sendUpdatetoServer() async {
    final String url =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/employee_order_tracking.php';
    var data = {
      'employee_id': int.parse(widget.userInfo[0].id),
      'employee_latitude': latitude,
      'employee_longitude': longitude,
      'customer_id': int.parse(customerSelected),
      'branch_id': branchSelected,
      'activity': activitySelected,
    };

    print(data);

    var response = await http.post(Uri.parse(url), body: json.encode(data));

    print(response.body);
  }

  Position currentposition;

  // ignore: missing_return
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      GlobalSnackBar.show(context, 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        GlobalSnackBar.show(context, 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      GlobalSnackBar.show(context,
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate Sales Order"),
        backgroundColor: Colors.black,
      ),
      body: ResponsiveUiWidget(
        targetOlderComputers: false,
        builder: (context, deviceInfo) {
          if (deviceInfo.deviceTypeInformation ==
              DeviceTypeInformation.MOBILE) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Select Customer *",
                            style: TextStyle(fontSize: 17),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2.32,
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.4)),
                          ),
                          child: DropdownSearch<CustomerList>(
                            showClearButton: true,
                            hint: "Select Customer",
                            mode: Mode.BOTTOM_SHEET,
                            dropdownSearchDecoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            showSearchBox: true,
                            emptyBuilder: (context, filter) {
                              return Container(
                                child: Center(
                                  child: Text("Sorry ! No Customer Found"),
                                ),
                              );
                            },
                            errorBuilder: (context, filter, dynamic) {
                              return Scaffold(
                                backgroundColor: Colors.white,
                                body: Center(
                                  child: Image.network(
                                      "https://media.istockphoto.com/photos/pug-dog-with-yellow-constructor-safety-helmet-and-cone-and-404-error-picture-id687810238?b=1&k=20&m=687810238&s=170667a&w=0&h=duenBlKFTSG0Ne4DmI8cBg47YZ6LACuLRiDlFD5doRQ="),
                                ),
                              );
                            },
                            loadingBuilder: (context, filter) {
                              return CustomerShimmer();
                            },
                            onFind: (String filter) async {
                              var response = await Dio().get(
                                "https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=customer",
                                queryParameters: {"filter": filter},
                              );

                              var models =
                                  CustomerList.fromJsonList(response.data);

                              return models;
                            },
                            onChanged: (CustomerList data) {
                              // printdata);
                              customerSelected = data.id;
                              cust_name = data.customername;
                              print(customerSelected);
                              // addCustomerData();
                            },
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 30,
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Select Branch ",
                        style: TextStyle(fontSize: 15),
                      )),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2.32,
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[500]),
                          ),
                          child: DropdownSearch(
                            mode: Mode.BOTTOM_SHEET,
                            hint: "Select Branch",
                            dropdownSearchDecoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            errorBuilder: (context, filter, dynamic) {
                              return Scaffold(
                                backgroundColor: Colors.white,
                                body: Center(
                                  child: Image.network(
                                      "https://media.istockphoto.com/photos/pug-dog-with-yellow-constructor-safety-helmet-and-cone-and-404-error-picture-id687810238?b=1&k=20&m=687810238&s=170667a&w=0&h=duenBlKFTSG0Ne4DmI8cBg47YZ6LACuLRiDlFD5doRQ="),
                                ),
                              );
                            },
                            loadingBuilder: (context, filter) {
                              return CustomerShimmer();
                            },
                            showSearchBox: true,
                            itemAsString: (CustomerBranch cb) => cb.branchname,
                            onFind: (String filter) async {
                              var response = await Dio().get(
                                "https://onlinefamilypharmacy.com/mobileapplication/salesmancustomerbranch.php?customerid=$customerSelected",
                                queryParameters: {"filter": filter},
                              );
                              var a = json.decode(response.data);
                              print(a);
                              var models = CustomerBranch.fromJsonList(a);

                              // printmodels);
                              return models;
                            },
                            onChanged: (CustomerBranch data) {
                              // printdata);
                              branchSelected = data.id;
                              branch_name = data.branchname;
                              // selectedvalue = data.id;
                              // addCustomerData();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Customer Email *",
                            style: TextStyle(fontSize: 17),
                          )),
                      SizedBox(
                        width: 80,
                      ),
                      Container(
                          child: Text(
                        "Customer Type *",
                        style: TextStyle(fontSize: 17),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[500])),
                          width: MediaQuery.of(context).size.width / 2.32,
                          child: FutureBuilder(
                            future: getAllValue(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Container(
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    itemBuilder: (context, index) {
                                  var list = snapshot.data[0];

                                  cust_email = list['cemail'];

                                  // addCustomerData();

                                  return TextFormField(
                                    enabled: true,
                                    initialValue:
                                        cust_email == null ? "" : cust_email,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: Color(0xfff3f3f4),
                                        filled: true),
                                    onChanged: (text) {
                                      cust_email = text;
                                      setState(() {});
                                      // printcust_email);
                                      // addCustomerData();
                                    },
                                  );
                                });
                              }
                              return Container(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          width: MediaQuery.of(context).size.width / 2.32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[500])),
                          child: FutureBuilder(
                            future: getAllValue(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Container(
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      var list = snapshot.data[0];

                                      cust_type = list['invoiceprice'];

                                      // addCustomerData();

                                      return TextFormField(
                                        enabled: false,
                                        initialValue: cust_type,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true),
                                      );
                                    });
                              }
                              return Container(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Credit Limit *",
                            style: TextStyle(fontSize: 17),
                          )),
                      SizedBox(
                        width: 110,
                      ),
                      Container(
                          child: Text(
                        "Credit Days *",
                        style: TextStyle(fontSize: 17),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[500])),
                          width: MediaQuery.of(context).size.width / 2.32,
                          child: FutureBuilder(
                            future: getAllValue(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Container(
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      var list = snapshot.data[0];

                                      credit_limit = list['creditlimits'];
                                      // addCustomerData();
                                      return TextFormField(
                                        enabled: false,
                                        initialValue: credit_limit,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true),
                                      );
                                    });
                              }
                              return Container(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          width: MediaQuery.of(context).size.width / 2.32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[500])),
                          child: FutureBuilder(
                            future: getAllValue(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Container(
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      var list = snapshot.data[0];

                                      credit_days = list['creditdays'];

                                      addCustomerData();

                                      return TextFormField(
                                        enabled: false,
                                        initialValue: credit_days,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true),
                                      );
                                    });
                              }
                              return Container(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Type of Visit",
                            style: TextStyle(fontSize: 17),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400])),
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: DropdownButton(
                        underline: SizedBox(),
                        value: activitySelected,
                        hint: Text("Select Type of Activity"),
                        items: activity
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            activitySelected = value;
                          });
                        },
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Attachment",
                            style: TextStyle(fontSize: 17),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[500])),
                          width: MediaQuery.of(context).size.width / 1.10,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Remarks",
                            style: TextStyle(fontSize: 17),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[500])),
                          width: MediaQuery.of(context).size.width / 1.10,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        if (customerSelected == null) {
                          final snackBar = SnackBar(
                            content:
                                const Text('Please Select a Customer First'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {},
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          addCustomerData();
                          sendUpdatetoServer();
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                        userList: widget.userInfo,
                                      )),
                            ).then((value) {
                              setState(() {
                                addCustomerData();
                              });
                            });
                          });
                        }
                      },
                      child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              "Confirm",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          } else if (deviceInfo.deviceTypeInformation ==
                  DeviceTypeInformation.TABLET &&
              deviceInfo.orientation == Orientation.landscape) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Select Customer *",
                                  style: TextStyle(fontSize: 17),
                                )),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(right: 220.0),
                                child: Text(
                                  "Select Branch ",
                                  style: TextStyle(fontSize: 17),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.47,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 3.32,
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                // color: Colors.black,
                                border: Border.all(color: Colors.grey[500]),
                              ),
                              margin: EdgeInsets.only(left: 10.0),
                              child: DropdownSearch<CustomerList>(
                                showClearButton: true,
                                hint: "Select Customer",
                                mode: Mode.BOTTOM_SHEET,
                                dropdownSearchDecoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent))),
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                showSearchBox: true,
                                emptyBuilder: (context, filter) {
                                  return Container(
                                    child: Center(
                                      child: Text("Sorry ! No Customer Found"),
                                    ),
                                  );
                                },
                                errorBuilder: (context, filter, dynamic) {
                                  return Scaffold(
                                    backgroundColor: Colors.white,
                                    body: Center(
                                      child: Image.network(
                                          "https://media.istockphoto.com/photos/pug-dog-with-yellow-constructor-safety-helmet-and-cone-and-404-error-picture-id687810238?b=1&k=20&m=687810238&s=170667a&w=0&h=duenBlKFTSG0Ne4DmI8cBg47YZ6LACuLRiDlFD5doRQ="),
                                    ),
                                  );
                                },
                                loadingBuilder: (context, filter) {
                                  return CustomerShimmer();
                                },
                                onFind: (String filter) async {
                                  var response = await Dio().get(
                                    "https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=customer",
                                    queryParameters: {"filter": filter},
                                  );
                                  // printresponse.data.length);
                                  var models =
                                      CustomerList.fromJsonList(response.data);

                                  // printmodels);
                                  return models;
                                },
                                onChanged: (CustomerList data) {
                                  customerSelected = data.id;
                                  cust_name = data.customername;
                                  // printcust_name);

                                  // printcustomerSelected);
                                  getAllValue();
                                },
                              ),
                            ),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 3.32,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[500]),
                              ),
                              padding: EdgeInsets.only(left: 10),
                              margin: EdgeInsets.only(right: 20.0),
                              child: DropdownSearch<CustomerBranch>(
                                hint: "Select Branch",
                                mode: Mode.BOTTOM_SHEET,
                                dropdownSearchDecoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent))),
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                showSearchBox: true,
                                emptyBuilder: (context, filter) {
                                  return Container(
                                    child: Center(
                                      child: Text("Sorry ! No Customer Found"),
                                    ),
                                  );
                                },
                                // errorBuilder: (context, filter, dynamic) {
                                //   return Scaffold(
                                //     backgroundColor: Colors.white,
                                //     body: Center(
                                //       child: Image.network(
                                //           "https://media.istockphoto.com/photos/pug-dog-with-yellow-constructor-safety-helmet-and-cone-and-404-error-picture-id687810238?b=1&k=20&m=687810238&s=170667a&w=0&h=duenBlKFTSG0Ne4DmI8cBg47YZ6LACuLRiDlFD5doRQ="),
                                //     ),
                                //   );
                                // },
                                loadingBuilder: (context, filter) {
                                  return CustomerShimmer();
                                },
                                itemAsString: (CustomerBranch cb) =>
                                    cb.branchname,
                                onFind: (String filter) async {
                                  var response = await Dio().get(
                                    "https://onlinefamilypharmacy.com/mobileapplication/salesmancustomerbranch.php?customerid=$customerSelected",
                                    queryParameters: {"filter": filter},
                                  );
                                  var a = json.decode(response.data);
                                  print(a);
                                  var models = CustomerBranch.fromJsonList(a);

                                  // printmodels);
                                  return models;
                                },
                                onChanged: (CustomerBranch data) {
                                  branchSelected = data.id;
                                  branch_name = data.branchname;
                                  // printbranch_name);
                                  // printbranchSelected);
                                  getAllValue();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Customer EmailId *",
                                  style: TextStyle(fontSize: 17),
                                )),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(right: 200.0),
                                child: Text(
                                  "Customer Type *",
                                  style: TextStyle(fontSize: 17),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          width: MediaQuery.of(context).size.width / 3.32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300])),
                          child: FutureBuilder(
                            future: getAllValue(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 3),
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.grey[300],
                                          fontSize: 17),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      var list = snapshot.data[0];

                                      cust_email = list['cemail'];

                                      // printcust_email);
                                      return TextFormField(
                                        enabled: true,
                                        initialValue: cust_email == null
                                            ? ""
                                            : cust_email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true),
                                        onChanged: (text) {
                                          setState(() {
                                            cust_email = text;
                                          });

                                          // addCustomerData();
                                        },
                                      );
                                    });
                              }
                              return Container(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          width: MediaQuery.of(context).size.width / 3.32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300])),
                          child: FutureBuilder(
                            future: getAllValue(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Container(
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.grey[300],
                                          fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      var list = snapshot.data[0];

                                      cust_type = list['invoiceprice'];
                                      // printcust_type);

                                      return TextFormField(
                                        enabled: false,
                                        initialValue: cust_type,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true),
                                      );
                                    });
                              }
                              return Container(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Credit Days *",
                                  style: TextStyle(fontSize: 17),
                                )),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(right: 200.0),
                                child: Text(
                                  "Customer Limit *",
                                  style: TextStyle(fontSize: 17),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          width: MediaQuery.of(context).size.width / 3.32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300])),
                          child: FutureBuilder(
                            future: getAllValue(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 3),
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      var list = snapshot.data[0];

                                      credit_days = list['creditdays'];

                                      // printcredit_days);

                                      return TextFormField(
                                        enabled: true,
                                        initialValue: credit_days == null
                                            ? ""
                                            : credit_days,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true),
                                      );
                                    });
                              }
                              return Container(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          width: MediaQuery.of(context).size.width / 3.32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300])),
                          child: FutureBuilder(
                            future: getAllValue(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Container(
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      var list = snapshot.data[0];

                                      credit_limit = list['creditlimits'];

                                      // printcredit_limit);

                                      return TextFormField(
                                        initialValue: credit_limit == null
                                            ? ""
                                            : credit_limit,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true),
                                      );
                                    });
                              }
                              return Container(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   children: [
                  //     Container(
                  //       alignment: Alignment.centerLeft,
                  //       width: MediaQuery.of(context).size.width / 1.6,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Container(
                  //               margin: EdgeInsets.only(left: 10.0),
                  //               child: Text(
                  //                 "Credit Limit *",
                  //                 style: TextStyle(fontSize: 17),
                  //               )),
                  //           Container(
                  //               alignment: Alignment.centerLeft,
                  //               margin: EdgeInsets.only(right: 170.0),
                  //               child: Text(
                  //                 "Credit Days *",
                  //                 style: TextStyle(fontSize: 17),
                  //               )),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Row(
                  //   children: [
                  //     Container(
                  //         height: 50,
                  //         margin: EdgeInsets.only(left: 10.0),
                  //         decoration: BoxDecoration(
                  //             border: Border.all(color: Colors.black)),
                  //         width: MediaQuery.of(context).size.width / 4.5,
                  //         child: FutureBuilder(
                  //           future: getAllValue(),
                  //           builder: (context, snapshot) {
                  //             if (snapshot.hasData) {
                  //               if (snapshot.data.length == 0) {
                  //                 return Container(
                  //                   child: Text(
                  //                     "",
                  //                     style: TextStyle(
                  //                         color: Colors.black, fontSize: 20),
                  //                     textAlign: TextAlign.center,
                  //                   ),
                  //                 );
                  //               }
                  //               return ListView.builder(
                  //                   itemBuilder: (context, index) {
                  //                 var list = snapshot.data[index];

                  //                 credit_limit = list['creditlimits'];

                  //                 return TextFormField(
                  //                   enabled: false,
                  //                   initialValue: list['creditlimits'],
                  //                   keyboardType: TextInputType.number,
                  //                   decoration: InputDecoration(
                  //                       border: InputBorder.none,
                  //                       fillColor: Color(0xfff3f3f4),
                  //                       filled: true),
                  //                 );
                  //               });
                  //             }
                  //             return Container(
                  //               child: Text(
                  //                 "Fetching Info",
                  //                 style: TextStyle(
                  //                     color: Colors.black, fontSize: 20),
                  //                 textAlign: TextAlign.center,
                  //               ),
                  //             );
                  //           },
                  //         )),
                  //     SizedBox(
                  //       width: MediaQuery.of(context).size.width / 6,
                  //     ),
                  //     Container(
                  //         height: 50,
                  //         margin: EdgeInsets.only(left: 10.0),
                  //         width: MediaQuery.of(context).size.width / 4.5,
                  //         decoration: BoxDecoration(
                  //             border: Border.all(color: Colors.black)),
                  //         child: FutureBuilder(
                  //           future: getAllValue(),
                  //           builder: (context, snapshot) {
                  //             if (snapshot.hasData) {
                  //               if (snapshot.data.length == 0) {
                  //                 return Container(
                  //                   child: Text(
                  //                     "",
                  //                     style: TextStyle(
                  //                         color: Colors.black, fontSize: 20),
                  //                     textAlign: TextAlign.center,
                  //                   ),
                  //                 );
                  //               }
                  //               return ListView.builder(
                  //                   itemBuilder: (context, index) {
                  //                 var list = snapshot.data[index];

                  //                 credit_days = list['creditdays'];

                  //                 addCustomerData();

                  //                 return TextFormField(
                  //                   enabled: false,
                  //                   initialValue: list['creditdays'],
                  //                   keyboardType: TextInputType.number,
                  //                   decoration: InputDecoration(
                  //                       border: InputBorder.none,
                  //                       fillColor: Color(0xfff3f3f4),
                  //                       filled: true),
                  //                 );
                  //               });
                  //             }
                  //             return Container(
                  //               child: Text(
                  //                 "Fetching Info",
                  //                 style: TextStyle(
                  //                     color: Colors.black, fontSize: 20),
                  //                 textAlign: TextAlign.center,
                  //               ),
                  //             );
                  //           },
                  //         )),
                  //   ],
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Attachment",
                            style: TextStyle(fontSize: 17),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300])),
                          width: MediaQuery.of(context).size.width / 1.52,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Remarks",
                            style: TextStyle(fontSize: 17),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300])),
                          width: MediaQuery.of(context).size.width / 1.52,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            autofocus: true,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 380),
                    child: InkWell(
                      onTap: () {
                        if (customerSelected == null) {
                          final snackBar = SnackBar(
                            content:
                                const Text('Please Select a Customer First'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {},
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          addCustomerData();
                          sendUpdatetoServer();
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                        userList: widget.userInfo,
                                      )),
                            ).then((value) {
                              setState(() {
                                addCustomerData();
                              });
                            });
                          });
                        }
                      },
                      child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Container(
                            margin: EdgeInsets.only(top: 13),
                            child: Text(
                              "Confirm",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            );
          } else if (deviceInfo.deviceTypeInformation ==
                  DeviceTypeInformation.TABLET &&
              deviceInfo.orientation == Orientation.portrait) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Select Customer *",
                                  style: TextStyle(fontSize: 17),
                                )),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(right: 300.0),
                                child: Text(
                                  "Select Branch ",
                                  style: TextStyle(fontSize: 17),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 2.32,
                              decoration: BoxDecoration(
                                // color: Colors.black,
                                border: Border.all(color: Colors.grey[500]),
                              ),
                              margin: EdgeInsets.only(left: 10.0),
                              padding: EdgeInsets.only(left: 10),
                              child: DropdownSearch<CustomerList>(
                                showClearButton: true,
                                hint: "Select Customer",
                                mode: Mode.BOTTOM_SHEET,
                                dropdownSearchDecoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent))),
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                showSearchBox: true,
                                emptyBuilder: (context, filter) {
                                  return Container(
                                    child: Center(
                                      child: Text("Sorry ! No Customer Found"),
                                    ),
                                  );
                                },
                                errorBuilder: (context, filter, dynamic) {
                                  return Scaffold(
                                    backgroundColor: Colors.white,
                                    body: Center(
                                      child: Image.network(
                                          "https://media.istockphoto.com/photos/pug-dog-with-yellow-constructor-safety-helmet-and-cone-and-404-error-picture-id687810238?b=1&k=20&m=687810238&s=170667a&w=0&h=duenBlKFTSG0Ne4DmI8cBg47YZ6LACuLRiDlFD5doRQ="),
                                    ),
                                  );
                                },
                                loadingBuilder: (context, filter) {
                                  return CustomerShimmer();
                                },
                                onFind: (String filter) async {
                                  var response = await Dio().get(
                                    "https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=customer",
                                    queryParameters: {"filter": filter},
                                  );
                                  // printresponse.data.length);
                                  var models =
                                      CustomerList.fromJsonList(response.data);

                                  return models;
                                },
                                onChanged: (CustomerList data) {
                                  // printdata);
                                  customerSelected = data.id;
                                  print(customerSelected);
                                  getAllValue();
                                },
                              ),
                            ),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 2.32,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[500]),
                              ),
                              margin: EdgeInsets.only(right: 20.0),
                              padding: EdgeInsets.only(left: 10),
                              child: DropdownSearch<CustomerBranch>(
                                hint: "Select Branch",
                                mode: Mode.BOTTOM_SHEET,
                                dropdownSearchDecoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent))),
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                showSearchBox: true,
                                emptyBuilder: (context, filter) {
                                  return Container(
                                    child: Center(
                                      child: Text("Sorry ! No Customer Found"),
                                    ),
                                  );
                                },
                                errorBuilder: (context, filter, dynamic) {
                                  return Scaffold(
                                    backgroundColor: Colors.white,
                                    body: Center(
                                      child: Image.network(
                                          "https://media.istockphoto.com/photos/pug-dog-with-yellow-constructor-safety-helmet-and-cone-and-404-error-picture-id687810238?b=1&k=20&m=687810238&s=170667a&w=0&h=duenBlKFTSG0Ne4DmI8cBg47YZ6LACuLRiDlFD5doRQ="),
                                    ),
                                  );
                                },
                                loadingBuilder: (context, filter) {
                                  return CustomerShimmer();
                                },
                                onFind: (String filter) async {
                                  var response = await Dio().get(
                                    "https://onlinefamilypharmacy.com/mobileapplication/salesmancustomerbranch.php?customerid=$customerSelected",
                                    queryParameters: {"filter": filter},
                                  );
                                  var a = json.decode(response.data);
                                  print(a);
                                  var models = CustomerBranch.fromJsonList(a);

                                  // printmodels);
                                  return models;
                                },
                                onChanged: (CustomerBranch data) {
                                  // printdata);
                                  branchSelected = data.id;
                                  getAllValue();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Customer EmailId *",
                                  style: TextStyle(fontSize: 17),
                                )),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(right: 280.0),
                                child: Text(
                                  "Customer Type *",
                                  style: TextStyle(fontSize: 17),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          width: MediaQuery.of(context).size.width / 2.32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300])),
                          child: FutureBuilder(
                            future: getAllValue(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 3),
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.grey[300],
                                          fontSize: 17),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    itemBuilder: (context, index) {
                                  var list = snapshot.data[index];

                                  cust_email = list['cemail'];

                                  return TextFormField(
                                    enabled: true,
                                    initialValue:
                                        cust_email == null ? "" : cust_email,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: Color(0xfff3f3f4),
                                        filled: true),
                                    onChanged: (text) {
                                      cust_email = text;
                                      // addCustomerData();
                                    },
                                  );
                                });
                              }
                              return Container(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.grey[300], fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 18,
                      ),
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 30.0),
                          width: MediaQuery.of(context).size.width / 2.32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300])),
                          child: FutureBuilder(
                            future: getAllValue(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Container(
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.grey[300],
                                          fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    itemBuilder: (context, index) {
                                  var list = snapshot.data[index];

                                  cust_type = list['invoiceprice'];

                                  return TextFormField(
                                    initialValue: list['invoiceprice'],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: Color(0xfff3f3f4),
                                        filled: true),
                                  );
                                });
                              }
                              return Container(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Credit Days *",
                                  style: TextStyle(fontSize: 17),
                                )),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(right: 280.0),
                                child: Text(
                                  "Customer Limit *",
                                  style: TextStyle(fontSize: 17),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          width: MediaQuery.of(context).size.width / 2.32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300])),
                          child: FutureBuilder(
                            future: getAllValue(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 3),
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.grey[300],
                                          fontSize: 17),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    itemBuilder: (context, index) {
                                  var list = snapshot.data[index];

                                  credit_days = list['credit_days'];

                                  return TextFormField(
                                    enabled: true,
                                    initialValue:
                                        credit_days == null ? "" : credit_days,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: Color(0xfff3f3f4),
                                        filled: true),
                                  );
                                });
                              }
                              return Container(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.grey[300], fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 30.0),
                          width: MediaQuery.of(context).size.width / 2.32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300])),
                          child: FutureBuilder(
                            future: getAllValue(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Container(
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.grey[300],
                                          fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    itemBuilder: (context, index) {
                                  var list = snapshot.data[index];

                                  cust_type = list['invoiceprice'];

                                  return TextFormField(
                                    initialValue: list['invoiceprice'],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: Color(0xfff3f3f4),
                                        filled: true),
                                  );
                                });
                              }
                              return Container(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.grey[300], fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   children: [
                  //     Container(
                  //       alignment: Alignment.centerLeft,
                  //       width: MediaQuery.of(context).size.width / 1.6,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Container(
                  //               margin: EdgeInsets.only(left: 10.0),
                  //               child: Text(
                  //                 "Credit Limit *",
                  //                 style: TextStyle(fontSize: 17),
                  //               )),
                  //           Container(
                  //               alignment: Alignment.centerLeft,
                  //               margin: EdgeInsets.only(right: 170.0),
                  //               child: Text(
                  //                 "Credit Days *",
                  //                 style: TextStyle(fontSize: 17),
                  //               )),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Row(
                  //   children: [
                  //     Container(
                  //         height: 50,
                  //         margin: EdgeInsets.only(left: 10.0),
                  //         decoration: BoxDecoration(
                  //             border: Border.all(color: Colors.black)),
                  //         width: MediaQuery.of(context).size.width / 4.5,
                  //         child: FutureBuilder(
                  //           future: getAllValue(),
                  //           builder: (context, snapshot) {
                  //             if (snapshot.hasData) {
                  //               if (snapshot.data.length == 0) {
                  //                 return Container(
                  //                   child: Text(
                  //                     "",
                  //                     style: TextStyle(
                  //                         color: Colors.black, fontSize: 20),
                  //                     textAlign: TextAlign.center,
                  //                   ),
                  //                 );
                  //               }
                  //               return ListView.builder(
                  //                   itemBuilder: (context, index) {
                  //                 var list = snapshot.data[index];

                  //                 credit_limit = list['creditlimits'];

                  //                 return TextFormField(
                  //                   enabled: false,
                  //                   initialValue: list['creditlimits'],
                  //                   keyboardType: TextInputType.number,
                  //                   decoration: InputDecoration(
                  //                       border: InputBorder.none,
                  //                       fillColor: Color(0xfff3f3f4),
                  //                       filled: true),
                  //                 );
                  //               });
                  //             }
                  //             return Container(
                  //               child: Text(
                  //                 "Fetching Info",
                  //                 style: TextStyle(
                  //                     color: Colors.black, fontSize: 20),
                  //                 textAlign: TextAlign.center,
                  //               ),
                  //             );
                  //           },
                  //         )),
                  //     SizedBox(
                  //       width: MediaQuery.of(context).size.width / 6,
                  //     ),
                  //     Container(
                  //         height: 50,
                  //         margin: EdgeInsets.only(left: 10.0),
                  //         width: MediaQuery.of(context).size.width / 4.5,
                  //         decoration: BoxDecoration(
                  //             border: Border.all(color: Colors.black)),
                  //         child: FutureBuilder(
                  //           future: getAllValue(),
                  //           builder: (context, snapshot) {
                  //             if (snapshot.hasData) {
                  //               if (snapshot.data.length == 0) {
                  //                 return Container(
                  //                   child: Text(
                  //                     "",
                  //                     style: TextStyle(
                  //                         color: Colors.black, fontSize: 20),
                  //                     textAlign: TextAlign.center,
                  //                   ),
                  //                 );
                  //               }
                  //               return ListView.builder(
                  //                   itemBuilder: (context, index) {
                  //                 var list = snapshot.data[index];

                  //                 credit_days = list['creditdays'];

                  //                 addCustomerData();

                  //                 return TextFormField(
                  //                   enabled: false,
                  //                   initialValue: list['creditdays'],
                  //                   keyboardType: TextInputType.number,
                  //                   decoration: InputDecoration(
                  //                       border: InputBorder.none,
                  //                       fillColor: Color(0xfff3f3f4),
                  //                       filled: true),
                  //                 );
                  //               });
                  //             }
                  //             return Container(
                  //               child: Text(
                  //                 "Fetching Info",
                  //                 style: TextStyle(
                  //                     color: Colors.black, fontSize: 20),
                  //                 textAlign: TextAlign.center,
                  //               ),
                  //             );
                  //           },
                  //         )),
                  //   ],
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Attachment",
                            style: TextStyle(fontSize: 17),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300])),
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[300])),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Remarks",
                            style: TextStyle(fontSize: 17),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300])),
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: TextFormField(
                            cursorColor: Colors.grey[300],
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[300])),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            autofocus: true,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    // margin: EdgeInsets.only(right: 380),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        if (customerSelected == null) {
                          final snackBar = SnackBar(
                            content:
                                const Text('Please Select a Customer First'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {},
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          addCustomerData();
                          sendUpdatetoServer();
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                        userList: widget.userInfo,
                                      )),
                            ).then((value) {
                              setState(() {
                                addCustomerData();
                              });
                            });
                          });
                        }
                      },
                      child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Container(
                            margin: EdgeInsets.only(top: 13),
                            child: Text(
                              "Confirm",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Text("Not Compatible"),
          );
        },
      ),
    );
  }
}

// Future<List<CustomerListModel>> getData(filter) async {
//   var response = await Dio().get(
//     "https://5d85ccfb1e61af001471bf60.mockapi.io/user",
//     queryParameters: {"filter": filter},
//   );

//   final data = response.data;
//   if (data != null) {
//     return CustomerListModel.fromJsonList(data);
//   }

//   return [];
// }

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
