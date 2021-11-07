import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future addToCart() async {
  String baseUrl =
      'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesmanaddtocart.php';

  Map<String, dynamic> data = {
    'user_id': "125",
    'itemid': "10112",
    'price': "24",
    // 'finalprice': finalprice,
    'quantity': "6",
    'foc': "1",
    'ex_foc': "9",
    'disc': "0",
    'selectedcustbranch': "124",
  };

  var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));
  print(response.body.toString());
  if (response.body.toString().contains("Added to Cart")) {
    return {
      Fluttertoast.showToast(
          msg: "Added To Cart",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR),
      getCartCount()
    };
  } else {
    return {
      Fluttertoast.showToast(
          msg: "Already in  Cart",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM),
      getCartCount()
    };
  }
}

Future getCartCount() async {
  String baseUrl =
      'https://onlinefamilypharmacy.com/mobileapplication/getcart_count.php';
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var user_id = prefs.getString("id");
  Map<String, dynamic> data = {'userid': "125"};

  var response2 = await http.post(Uri.parse(baseUrl), body: json.encode(data));

  var cartTotal = jsonDecode(response2.body);
  print(cartTotal);
  // cart_total = jsonDecode(response2.body);
  // if (cart_total == null) {
  //   cart_total = '0';
  // }
}
