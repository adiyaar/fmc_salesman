import 'dart:convert';

import 'package:testing/models/CartItem.dart';
import 'package:http/http.dart' as http;
import 'package:testing/models/PastOrders.dart';

Future<List<CartItem>> fetchCartItem() async {
  Map<String, dynamic> data = {'userid': "125"};
  String baseUrl =
      'https://onlinefamilypharmacy.com/mobileapplication/cart_api.php';
  var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));

  List jsonResponse = json.decode(response.body);
  // (jsonResponse.length == 0) ? print("hi") : print("h");
  print(jsonResponse.map((item) => new CartItem.fromJson(item)).toList());
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
