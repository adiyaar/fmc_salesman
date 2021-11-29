import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/models/CartItem.dart';
import 'package:http/http.dart' as http;
import 'package:testing/models/PastOrders.dart';
import 'package:testing/widget/GlobalSnackbar.dart';

//  {custid: 1419, selectedcustbranch: 2}

Future<List<CartItem>> fetchCartItem() async {
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
  print(jsonResponse);

  return jsonResponse.map((item) => new CartItem.fromJson(item)).toList();
}

Future<List<PastOrder>> fetchPastOrder() async {
  String baseUrl =
      'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesmanviewitemhistory.php';

  Map data = {'customerid': "10014", 'itemcode': '117929'};

  var response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => new PastOrder.fromJson(job)).toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}

Future updateCart(BuildContext context, itemCode, quantity, finalPrice,
    allocatedFoc, exFoc, discount) async {
  SharedPreferences pf = await SharedPreferences.getInstance();
  String customerId = pf.getString('customerId');
  String selectedCustomerBranch = pf.get('branchId');

  String baseUrl =
      'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesman_update_cart.php';

  Map<String, dynamic> data = {
    'item_code': itemCode,
    'cust_id': customerId,
    'selectedcustbranch': selectedCustomerBranch,
    'quantity': quantity,
    'finalprice': finalPrice,
    'allocated_foc': allocatedFoc,
    'ex_foc': exFoc,
    'disc': discount
  };
  print(data);

  var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));
  print(response.body);

  var message = jsonDecode(response.body);
  print("I am update message");
  if (message == 'Account Details Updated') {
    GlobalSnackBar.show(context, 'Cart Updated');
  }
}

Future removeCart(BuildContext context, itemCode) async {
  final String baseUrl =
      'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesmanremovecart.php';
  SharedPreferences pf = await SharedPreferences.getInstance();
  String customerId = pf.getString('customerId');
  String selectedCustomerBranch = pf.get('branchId');
  Map<String, dynamic> data = {
    'item_code': itemCode,
    'cust_id': customerId,
    'selectedcustbranch': selectedCustomerBranch,
  };

  var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));
  var message = jsonDecode(response.body);
  print("I am removed message");
  print(message);
}
