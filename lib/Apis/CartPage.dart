import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/models/CartItem.dart';
import 'package:http/http.dart' as http;
import 'package:testing/models/PastOrders.dart';
import 'package:testing/widget/GlobalSnackbar.dart';

//  {custid: 1419, selectedcustbranch: 2}
int custId = 1419;
String whichCo = "FPG";
String whichb = 'W01';
List<String> variant = ['null', 'null'];
List<int> packing = [1, 10];

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
  print(jsonResponse.length);
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

  var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));

  var message = jsonDecode(response.body);

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

Future salesorder(
  List<int> quantity,
  List<double> price,
  List<String> itemCodes,
  List<String> itemName,
  List<int> foc,
  List<int> exFoc,
  int soRef,
  String notes,
  String typeofLead,
  String orderPlacedby,
  List<double> common,
) async {
  SharedPreferences pf = await SharedPreferences.getInstance();
  String customerBranchId = pf.getString('customerId');
  String customerType = pf.getString('cust_type');
  String creditLimit = pf.getString('credit_limit');
  String creditDays = pf.getString('credit_days');
  String custemail = pf.getString('credit_days');

  // employee info
// add branch // add company name

// customer name - id dalna hai
// units and packing

// units is type of backing that is
  var data = {
    'invoiceprice': customerType,
    'customername': int.parse(customerBranchId),
    'customeremail': custemail == null ? '' : custemail,
    'customertype': customerType,
    'units': itemName, // variant
    'packing': foc, // packaging
    'item_whichcompany': "FMC",
    'item_wac': common,
    'item_mgmtcost': common,
    'item_cutoffcost': common,
    'calculationtotal': common,

    'itemcode': itemCodes,
    'quantity': quantity,
    'price': price,
    'itemname': "Rest",
    'foc': foc,
    'ex_foc': exFoc,
    'soreferenceno': soRef,
    'typeoflead': typeofLead,
    'orderplacedby': orderPlacedby,
    'notess': notes,
    'supplyto': orderPlacedby,
    'whichcompany': whichCo, // employee company
    'whichbranch': whichb, // employee branch

    'invoicetype': customerType,
    'billingon': customerType,
    'creditlimits': creditLimit,
    'creditdays': creditDays,
    'customerstatus': 1
    // 'user_id': '125'
  };

  print(data);
  var url =
      'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesman_confirm_order.php';

  var response = await http.post(Uri.parse(url), body: json.encode(data));

  print(response.body.toString());
}
