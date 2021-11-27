import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//  {custid: 1419, selectedcustbranch: 2}
// ignore: non_constant_identifier_names
Future addToCart(user_id, itemid, price, quantity, foc, exfoc, disc,
    selectedCustbranch) async {
  String baseUrl =
      'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesmanaddtocart.php';

  Map<String, dynamic> data = {
    'user_id': user_id,
    'itemid': itemid,
    'price': price,
    // 'finalprice': finalprice,
    'quantity': quantity,
    'foc': foc,
    'ex_foc': exfoc,
    'disc': disc,
    'selectedcustbranch': selectedCustbranch,
  };
  print("Add to CART MAPPED DATA");
  print(data);

  var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));

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
  SharedPreferences pf = await SharedPreferences.getInstance();
  String customerId = pf.getString('customerId');
  Map<String, dynamic> data = {'userid': customerId};

  var response2 = await http.post(Uri.parse(baseUrl), body: json.encode(data));

  var cartTotal = jsonDecode(response2.body);
  print(
      "=================================================================================");
  print(cartTotal);
  print(cartTotal);
  // cart_total = jsonDecode(response2.body);
  // if (cart_total == null) {
  //   cart_total = '0';
  // }
}
