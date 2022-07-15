import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/screens/HomeScreen.dart';
import 'package:testing/screens/LoginScreen.dart';
import 'package:http/http.dart' as http;
import 'package:testing/screens/ViewDetailSalesQuotation.dart';

import 'models/UserInfo.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isAuthenticated = await Authentication.authenticateWithBiometrics();

  // if (isAuthenticated == true) {
  runApp(MaterialApp(
    navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    
  ));
  // }
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loggedIn;
  String email = '';
  String password = '';
  List userInfo = [];

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      loggedIn = (prefs.getBool('loggedIn') ?? false);
    });

    if (loggedIn == true) {
      continueLogin();
    } else {
      print(loggedIn);
    }
  }

  continueLogin() async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    email = pf.getString('loginEmail');
    password = pf.getString('loginPassword');

    final String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/login_salesman.php';

    var data = {'email': email, 'password': password};

    var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));

    String message = jsonDecode(response.body);
    if (message == "Login Matched") {
      final String baseUrl1 =
          'https://onlinefamilypharmacy.com/mobileapplication/salesmanprofile.php';

      var data1 = {'qatarid': email};

      var response1 =
          await http.post(Uri.parse(baseUrl1), body: jsonEncode(data1));

      var jsonReponse = json.decode(response1.body);

      userInfo = jsonReponse.map((e) => new UserInfoModel.fromJson(e)).toList();
      setState(() {});

      return userInfo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loggedIn == true
        ? HomeScreen(userList: userInfo)
        : LoginScreenPage();
  }
}

class Authentication {
  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticate(
          localizedReason: 'Scan to proceed', stickyAuth: true);
    }

    return isAuthenticated;
  }
}
