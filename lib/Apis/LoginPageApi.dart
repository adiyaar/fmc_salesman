import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future salesmanLogin(emailAddress, password) async {
  final String baseUrl =
      'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/login_salesman.php';

  var data = {'email': emailAddress, 'password': password};

  var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));

  String message = jsonDecode(response.body);

  return message;
}

Future salesmanId(emailAddress) async {
  final String baseUrl =
      'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/getsalesmanid.php';

  var data = {'qatarid': emailAddress};

  var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));
  print(response.body);
  String message = jsonDecode(response.body);
  
  SharedPreferences pf = await SharedPreferences.getInstance();

  pf.setString("qatarid", message);
  pf.setString("email", emailAddress);

  print(pf.getString("qatardid"));
  

  return message;
}
