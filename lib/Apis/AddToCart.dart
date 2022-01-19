import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:testing/widget/GlobalSnackbar.dart';
// ignore: non_constant_identifier_names
Future addToCart(
    BuildContext context,
    // ignore: non_constant_identifier_names
    user_id,
    itemid,
    price,
    quantity,
    foc,
    exfoc,
    disc,
    selectedCustbranch,
    int packing,
    double itemWac,
    String units,
    double itemMgmt,
    double calcCost,
    double cutoFF,
    String itemWhchCOmpany) async {
  String baseUrl =
      'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesmanaddtocart.php';

  Map<String, dynamic> data = {
    'user_id': user_id,
    'itemid': itemid,
    'price': price,
    'quantity': quantity,
    'foc': foc,
    'ex_foc': exfoc,
    'disc': disc,
    'selectedcustbranch': selectedCustbranch,
    'packing': packing,
    'units': units,
    'item_wac': itemWac,
    'item_mgmtcost': itemMgmt,
    'item_cutoffcost': cutoFF,
    'calculationcost': calcCost,
    'item_whichcompany': itemWhchCOmpany,
  };

  var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));

  if (response.body.toString().contains("Added to Cart")) {
    return {GlobalSnackBar.show(context, 'Added to Cart')};
  } else {
    return {GlobalSnackBar.show(context, 'Already in Cart')};
  }
}


