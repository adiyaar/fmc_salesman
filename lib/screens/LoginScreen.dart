import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:testing/Apis/LoginPageApi.dart';
import 'package:http/http.dart' as http;
import 'package:testing/models/UserInfo.dart';
import 'HomeScreen.dart';
import 'package:responsify/responsify.dart';

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({Key key}) : super(key: key);

  @override
  _LoginScreenPageState createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  final futureGroup = FutureGroup();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ResponsiveUiWidget(
          targetOlderComputers: false,
          builder: (context, deviceInfo) {
            if (deviceInfo.deviceTypeInformation ==
                    DeviceTypeInformation.TABLET &&
                deviceInfo.orientation == Orientation.portrait) {
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.1), BlendMode.dstATop),
                      image: AssetImage('assets/images/backgroundImage.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   colorFilter: new ColorFilter.mode(
                            //       Colors.black.withOpacity(0.1), BlendMode.dstATop),
                            //   image: NetworkImage(
                            //       "https://images.unsplash.com/photo-1467664631004-58beab1ece0d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8c2FsZXNtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
                            //   fit: BoxFit.cover,
                            // ),
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 250,
                            ),
                            Container(
                                alignment: Alignment.topCenter,
                                height: 300,
                                padding: EdgeInsets.all(75.0),
                                child: Center(
                                    child: Image.asset("assets/logo.png"))),
                            Form(
                              key: _formKey,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Text(

                                    //   "Qatar Id",
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold, fontSize: 15),
                                    // ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: TextFormField(
                                        controller: emailcontroller,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return 'Enter your QATAR ID!';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Qatar Id",
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: TextFormField(
                                          obscureText: true,
                                          validator: (val) {
                                            if (val.isEmpty ||
                                                val.length <= 3) {
                                              return 'Password Length would be greater than 3!';
                                            }
                                            return null;
                                          },
                                          controller: passwordcontroller,
                                          decoration: InputDecoration(
                                              hintText: "Password",
                                              border: InputBorder.none,
                                              fillColor: Color(0xfff3f3f4),
                                              filled: true)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 20,
                            ),
                            InkWell(
                              onTap: () async {
                                bool formFilled =
                                    _formKey.currentState.validate();
                                if (formFilled == true) {
                                  SharedPreferences pf =
                                      await SharedPreferences.getInstance();
                                  // futureGroup.add(salesmanLogin(
                                  //     emailcontroller.text,
                                  //     passwordcontroller.text));
                                  // futureGroup
                                  //     .add(salesmanId(emailcontroller.text));

                                  final String baseUrl =
                                      'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/login_salesman.php';

                                  var data = {
                                    'email': emailcontroller.text,
                                    'password': passwordcontroller.text
                                  };

                                  var response = await http.post(
                                      Uri.parse(baseUrl),
                                      body: json.encode(data));

                                  String message = jsonDecode(response.body);
                                  if (message == "Login Matched") {
                                    final String baseUrl1 =
                                        'https://onlinefamilypharmacy.com/mobileapplication/salesmanprofile.php';

                                    var data1 = {
                                      'qatarid': emailcontroller.text
                                    };

                                    var response1 = await http.post(
                                        Uri.parse(baseUrl1),
                                        body: jsonEncode(data1));
                                    print(response1.body);
                                    var jsonReponse =
                                        json.decode(response1.body);

                                    List userInfo = jsonReponse
                                        .map((e) =>
                                            new UserInfoModel.fromJson(e))
                                        .toList();

                                    print('Here');
                                    print(userInfo.length);

                                    Future.delayed(Duration(milliseconds: 100),
                                        () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomeScreen(
                                                    userList: userInfo,
                                                  )));
                                    });
                                  } else {
                                    final snackBar = SnackBar(
                                      backgroundColor: Colors.blue,
                                      content:
                                          const Text('Incorrect Credentials'),
                                      action: SnackBarAction(
                                        label: '',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    );

                                    // Find the ScaffoldMessenger in the widget tree
                                    // and use it to show a SnackBar.
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.8,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  color: Colors.black,
                                ),
                                child: Text(
                                  'Salesman Login',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (deviceInfo.deviceTypeInformation ==
                    DeviceTypeInformation.TABLET &&
                deviceInfo.orientation == Orientation.landscape) {
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.1), BlendMode.dstATop),
                      image: AssetImage('assets/images/backgroundImage.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   colorFilter: new ColorFilter.mode(
                            //       Colors.black.withOpacity(0.1), BlendMode.dstATop),
                            //   image: NetworkImage(
                            //       "https://images.unsplash.com/photo-1467664631004-58beab1ece0d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8c2FsZXNtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
                            //   fit: BoxFit.cover,
                            // ),
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                alignment: Alignment.topCenter,
                                height: 300,
                                padding: EdgeInsets.all(75.0),
                                child: Center(
                                    child: Image.asset("assets/logo.png"))),
                            Form(
                              key: _formKey,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Text(

                                    //   "Qatar Id",
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold, fontSize: 15),
                                    // ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: TextFormField(
                                        controller: emailcontroller,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return 'Enter a valid QATAR ID!';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Qatar Id",
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: TextFormField(
                                          obscureText: true,
                                          validator: (val) {
                                            if (val.isEmpty ||
                                                val.length <= 3) {
                                              return 'Password Length would be greater than 3!';
                                            }
                                            return null;
                                          },
                                          controller: passwordcontroller,
                                          decoration: InputDecoration(
                                              hintText: "Password",
                                              border: InputBorder.none,
                                              fillColor: Color(0xfff3f3f4),
                                              filled: true)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 20,
                            ),
                            InkWell(
                              onTap: () async {
                                bool formFilled =
                                    _formKey.currentState.validate();
                                if (formFilled == true) {
                                  SharedPreferences pf =
                                      await SharedPreferences.getInstance();
                                  // futureGroup.add(salesmanLogin(
                                  //     emailcontroller.text,
                                  //     passwordcontroller.text));
                                  // futureGroup
                                  //     .add(salesmanId(emailcontroller.text));

                                  final String baseUrl =
                                      'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/login_salesman.php';

                                  var data = {
                                    'email': emailcontroller.text,
                                    'password': passwordcontroller.text
                                  };

                                  var response = await http.post(
                                      Uri.parse(baseUrl),
                                      body: json.encode(data));

                                  String message = jsonDecode(response.body);
                                  if (message == "Login Matched") {
                                    final String baseUrl1 =
                                        'https://onlinefamilypharmacy.com/mobileapplication/salesmanprofile.php';

                                    var data1 = {
                                      'qatarid': emailcontroller.text
                                    };

                                    var response1 = await http.post(
                                        Uri.parse(baseUrl1),
                                        body: jsonEncode(data1));
                                    print(response1.body);
                                    var jsonReponse =
                                        json.decode(response1.body);

                                    List userInfo = jsonReponse
                                        .map((e) =>
                                            new UserInfoModel.fromJson(e))
                                        .toList();

                                    print('Here');
                                    print(userInfo.length);

                                    Future.delayed(Duration(milliseconds: 100),
                                        () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomeScreen(
                                                    userList: userInfo,
                                                  )));
                                    });
                                  } else {
                                    final snackBar = SnackBar(
                                      backgroundColor: Colors.blue,
                                      content:
                                          const Text('Incorrect Credentials'),
                                      action: SnackBarAction(
                                        label: '',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    );

                                    // Find the ScaffoldMessenger in the widget tree
                                    // and use it to show a SnackBar.
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.8,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  color: Colors.black,
                                ),
                                child: Text(
                                  'Salesman Login',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Family Medical Company",
                              style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(12.0),
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Our story began in 1989. Back then we were a medicine retailer with our first branch at Bin Mahmoud road. Today we are privileged to connect and provide quality healthcare directly to a very large section of our community and indirectly through our wholesale and distribution activities to almost all of the healthcare providers in Qatar",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if (deviceInfo.deviceTypeInformation ==
                DeviceTypeInformation.MOBILE) {
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.1), BlendMode.dstATop),
                      image: AssetImage('assets/images/backgroundImage.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                alignment: Alignment.topCenter,
                                height: 300,
                                padding: EdgeInsets.all(75.0),
                                child: Center(
                                    child: Image.asset("assets/logo.png"))),
                            Form(
                              key: _formKey,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Text(

                                    //   "Qatar Id",
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold, fontSize: 15),
                                    // ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: TextFormField(
                                        controller: emailcontroller,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return 'Enter a your QATAR ID!';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Qatar Id",
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: TextFormField(
                                          obscureText: true,
                                          validator: (val) {
                                            if (val.isEmpty ||
                                                val.length <= 3) {
                                              return 'Password Length would be greater than 3!';
                                            }
                                            return null;
                                          },
                                          controller: passwordcontroller,
                                          decoration: InputDecoration(
                                              hintText: "Password",
                                              border: InputBorder.none,
                                              fillColor: Color(0xfff3f3f4),
                                              filled: true)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 20,
                            ),
                            InkWell(
                              onTap: () async {
                                bool formFilled =
                                    _formKey.currentState.validate();
                                if (formFilled == true) {
                                  SharedPreferences pf =
                                      await SharedPreferences.getInstance();
                                  // futureGroup.add(salesmanLogin(
                                  //     emailcontroller.text,
                                  //     passwordcontroller.text));
                                  // futureGroup
                                  //     .add(salesmanId(emailcontroller.text));

                                  final String baseUrl =
                                      'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/login_salesman.php';

                                  var data = {
                                    'email': emailcontroller.text,
                                    'password': passwordcontroller.text
                                  };

                                  var response = await http.post(
                                      Uri.parse(baseUrl),
                                      body: json.encode(data));

                                  String message = jsonDecode(response.body);
                                  if (message == "Login Matched") {
                                    final String baseUrl1 =
                                        'https://onlinefamilypharmacy.com/mobileapplication/salesmanprofile.php';

                                    var data1 = {
                                      'qatarid': emailcontroller.text
                                    };

                                    var response1 = await http.post(
                                        Uri.parse(baseUrl1),
                                        body: jsonEncode(data1));
                                    print(response1.body);
                                    var jsonReponse =
                                        json.decode(response1.body);

                                    List userInfo = jsonReponse
                                        .map((e) =>
                                            new UserInfoModel.fromJson(e))
                                        .toList();

                                    print('Here');
                                    print(userInfo.length);

                                    Future.delayed(Duration(milliseconds: 100),
                                        () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomeScreen(
                                                    userList: userInfo,
                                                  )));
                                    });
                                  } else {
                                    final snackBar = SnackBar(
                                      backgroundColor: Colors.blue,
                                      content:
                                          const Text('Incorrect Credentials'),
                                      action: SnackBarAction(
                                        label: '',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    );

                                    // Find the ScaffoldMessenger in the widget tree
                                    // and use it to show a SnackBar.
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.8,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  color: Colors.black,
                                ),
                                child: Text(
                                  'Salesman Login',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Text("HI");
          },
        ),
      ),
    );
  }
}
