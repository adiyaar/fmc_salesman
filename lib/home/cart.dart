import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fmc_salesman/home/order_summary.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

var totalid;
String? invoiceprice, selectedcustbranch;

class CartItem {
  final String? item_code;
  final String? itemid;
  final String? user_id;
  final String? selectedcustbranch;
  final String? img;
  final String? itemname_en;
  final String? qty;
  final String? cust_type;
  final String? foc;
  final String? ex_foc;
  final String? disc;
  final String? rs;
  final String? ws;

  // final String email;
  CartItem(
      {this.item_code,
      this.user_id,
      this.itemid,
      this.img,
      this.selectedcustbranch,
      this.itemname_en,
      this.qty,
      this.cust_type,
      this.foc,
      this.ex_foc,
      this.disc,
      this.rs,
      this.ws});
//List data;
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        item_code: json['item_code'],
        itemid: json['itemid'],
        user_id: json['user_id'],
        img: json['img'],
        selectedcustbranch: json['selectedcustbranch'],
        itemname_en: json['itemname_en'],
        qty: json['qty'],
        cust_type: json['cust_type'],
        foc: json['foc'],
        ex_foc: json['ex_foc'],
        disc: json['disc'],
        rs: json['rs'],
        ws: json['ws']);
  }
}

class TotalItem {
  final String? Total;

  // final String email;
  TotalItem({
    this.Total,
  });
//List data;
  factory TotalItem.fromJson(Map<String, dynamic> json) {
    return TotalItem(
      Total: json['Total'],
    );
  }
}

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  CircularProgressIndicator? pr;
  double subtotal = 0.00;
  String? quantity, fixed_foc, allocated_foc, ex_foc, disc;
  List<int> _counter_ = [];
  List<int> finalprice = [];
  double? totalprice;
  int? sump;
  int? sum;
  int? price;
  var total;

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String? cust_id = prefs.getString('cust_id');

    return cust_id;
  }

  getvalues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    invoiceprice = prefs.getString('invoiceprice');

    selectedcustbranch = prefs.getString('selectedcustbranch');

    return selectedcustbranch;
  }

  int counter = 0;
  int subTotal = 0;
  //final productprice;

  void increment(price, counter) {
    setState(() {
      counter++;
      // finalprice = double.parse(price) * counter;
    });
  }

  void decrement(price, counter) {
    setState(() {
      counter--;

      //finalprice = double.parse(price) * counter;
    });
  }

  Future addquantity(finalprice, quantity, id) async {
    var data = {'finalprice': finalprice, 'quantity': quantity, 'id': id};
    var url =
        'https://onlinefamilypharmacy.com/mobileapplication/update_cart.php';
    var response = await http.post(url, body: json.encode(data));
  }

  Future removecart(item_code) async {
    dynamic cust_id = await getStringValues();
    dynamic branch = await getvalues();

    var url =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesmanremovecart.php';
    var data = {
      'item_code': item_code,
      'cust_id': cust_id,
      'selectedcustbranch': selectedcustbranch
    };
    var response = await http.post(url, body: json.encode(data));
    print("Message from removed");
    print(response.body);
    var message = jsonDecode(response.body);
    setState(() {
      _fetchCartItem();
    });
  }

  Future update_cart(item_code) async {
    //   dynamic cust_id = await getStringValues();
    // Future update_cart(itemid) async {
    dynamic cust_id = await getStringValues();
    dynamic branch = await getvalues();
    // SERVER API URL
    var url =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesman_update_cart.php';
    // print(firstname);print(lastname);print(email);
    // Store all data with Param Name.
    var data = {
      'item_code': item_code,
      'cust_id': cust_id,
      'selectedcustbranch': selectedcustbranch,
      'quantity': quantity,
      'finalprice': finalprice,
      'allocated_foc': allocated_foc,
      'ex_foc': ex_foc,
      'disc': 0
    };

    print(data);
    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));
    print("COOOL");
    print(response.statusCode);
    print(response.body);
    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    print("I am update message");
    print(message);
    _fetchCartItem();
  }

  @override
  void initState() {
    super.initState();
    getStringValues();
    getStringValues();
  }

  /*void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  } */

  @override
  Widget build(BuildContext context) {
    //  final cart = Provider.of<Cart_>(context);
    /* SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]); */
    return Scaffold(
      appBar: AppBar(title: Text("Cart List")),
      body: Column(children: <Widget>[
        Expanded(
          child: FutureBuilder<List<CartItem>>(
            future: _fetchCartItem(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CartItem>? data = snapshot.data;
                if (snapshot.data!.length == 0) {
                  return Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 80),
                    // child: Image.asset("assets/cart.png"));
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                  );
                }

                return imageSlider(context, data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(LightColor.blueColor),
              ));
            },
          ),
        ),
        Container(
            height: 80,
            child: Row(
              children: [
                Text(
                  "Subtotal: $subtotal",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  width: 650,
                ),
                ElevatedButton(
                  child: Text("Proceed"),
                  onPressed: () {},
                )
              ],
            )),
      ]),

      // floatingActionButton: Container(
      //     height: 50.0,
      //     width: 150.0,
      //     alignment: Alignment.center,
      //     //child: FittedBox(
      //     child: FloatingActionButton.extended(
      //       //  icon: Icon(Icons.add_shopping_cart),
      //       //  label: Text("Add to Cart"),
      //
      //       backgroundColor: LightColor.whiteColor,
      //       onPressed: () {
      //
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => Order_SummaryScreen()));
      //       },
      //       // icon: Icon(Icons.save),
      //       label: Center(
      //           child: Text(
      //         "Proceed",
      //         style: TextStyle(
      //             fontSize: 18,
      //             color: LightColor.blueColor,
      //             fontWeight: FontWeight.bold),
      //       )),
      //     ))
    );
  }

  Future<List<CartItem>> _fetchCartItem() async {
    dynamic token = await getStringValues();
    dynamic branch = await getvalues();

    var data = {'userid': token, 'selectedcustbranch': selectedcustbranch};
    // var data = {'userid': token};
    var url =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesman_cart.php';
    var response = await http.post(url, body: json.encode(data));

    List jsonResponse = json.decode(response.body.toString());

    //  _finalprice_= jsonResponse["price"].map((item) => new Item.fromJson(item)).toList();
    List<CartItem> temp =
        jsonResponse.map((item) => new CartItem.fromJson(item)).toList();
    subtotal = temp.map((e) {
      return double.parse(invoiceprice! == null || invoiceprice! == 'Retail'
              ? e.rs!
              : e.ws!) *
          double.parse(e.qty!);
    }).reduce(
      (value, element) => value + element,
    );
    print(subtotal);
    setState(() {});
    return jsonResponse.map((item) => new CartItem.fromJson(item)).toList();
  }

  imageSlider(context, data) {
    double total = 0;

    return ListView.builder(
      // scrollDirection: Axis.vertical,
      itemCount: data.length,

      itemBuilder: (context, index) {
        quantity = data[index].qty;

        int itemc = data.length;
        if (invoiceprice == null || invoiceprice == 'Retail') {
          total = double.parse(data[index].rs) * double.parse(data[index].qty);
        } else {
          total = double.parse(data[index].ws) * double.parse(data[index].qty);
        }

        final qtycontrol = TextEditingController();
        final pricecontrol = TextEditingController();

        // fixed_foc = data[index].foc;
        ex_foc = data[index].ex_foc;
        allocated_foc = data[index].foc;
        disc = data[index].disc;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  border: Border(
                      // bottom: BorderSide(color: Colors.grey[100], width: 1.0),
                      // top: BorderSide(color: Colors.grey[100], width: 1.0),
                      )),
              height: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5.0)
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                        image: DecorationImage(
                            // image: NetworkImage(
                            //     'https://onlinefamilypharmacy.com/images/item/' +
                            //         data[index].img),
                            // fit: BoxFit.fill)),
                            image: NetworkImage(
                                'https://i.picsum.photos/id/910/200/300.jpg?hmac=7qhIWU6_Tq8mQzJNTsBvtWdzNIz7uvspoAuLTJ3542M'),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 100.0,
                    width: 100.0,
                    child: Column(children: <Widget>[
                      Text(
                        '${data[index].item_code} - ${data[index].itemname_en}',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      )
                    ]),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      width: 90,
                      child: Column(children: <Widget>[
                        if (invoiceprice == null || invoiceprice == 'Retail')
                          (TextFormField(
                            initialValue: "${data[index].rs}",
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xfff3f3f4),
                                filled: true),
                          ))
                        else if (invoiceprice == 'Wholesale')
                          (TextFormField(
                            // controller: pricecontrol,
                            enabled: false,
                            initialValue: "\QR ${data[index].ws}",
                            style: TextStyle(
                              fontSize: 15, //fontWeight: FontWeight.bold
                            ),
                          )),
                      ])),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      width: 90,
                      child: Column(children: <Widget>[
                        Text(
                          'Qty',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15.0),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                        TextFormField(
                          initialValue: quantity,
                          // controller: qtycontrol,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                          onChanged: (text) {
                            quantity = text;
                          },
                        ),
                      ])),
                  SizedBox(
                    width: 5,
                  ),
                  // Container(
                  //     width: 90,
                  //     child: Column(children: <Widget>[
                  //       Text(
                  //         'Fixed FOC',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w600, fontSize: 15.0),
                  //         overflow: TextOverflow.ellipsis,
                  //         maxLines: 4,
                  //       ),
                  //       TextFormField(
                  //           initialValue: fixed_foc,
                  //           decoration: InputDecoration(
                  //               border: InputBorder.none,
                  //               fillColor: Color(0xfff3f3f4),
                  //               filled: true),
                  //           onChanged: (text) {
                  //             fixed_foc = text;
                  //           }),
                  //     ])),

                  Container(
                      width: 120,
                      child: Column(children: <Widget>[
                        Text(
                          'Allot. FOC',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15.0),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                        TextFormField(
                            initialValue: allocated_foc,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xfff3f3f4),
                                filled: true),
                            onChanged: (text) {
                              allocated_foc = text;
                            }),
                      ])),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      width: 90,
                      child: Column(children: <Widget>[
                        Text(
                          'Ex FOC',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15.0),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                        TextFormField(
                            initialValue: ex_foc,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xfff3f3f4),
                                filled: true),
                            onChanged: (text) {
                              ex_foc = text;
                            }),
                      ])),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      width: 90,
                      child: Column(children: <Widget>[
                        Text(
                          'Disc%',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15.0),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                        TextFormField(
                            initialValue: disc,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xfff3f3f4),
                                filled: true),
                            onChanged: (text) {
                              disc = text;
                            }),
                      ])),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      width: 90,
                      child: Column(children: <Widget>[
                        Text(
                          'Disc',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15.0),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                        TextFormField(
                            initialValue: disc,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xfff3f3f4),
                                filled: true),
                            onChanged: (text) {
                              disc = text;
                            }),
                      ])),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      width: 90,
                      child: Column(children: <Widget>[
                        Text(
                          'Total',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15.0),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                        TextFormField(
                            initialValue: total.toString(),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xfff3f3f4),
                                filled: true),
                            onChanged: (text) {
                              disc = text;
                            }),
                      ])),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    child: ElevatedButton(
                      child: Text("Update Cart"),
                      onPressed: () {
                        update_cart(data[index].item_code);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    child: ElevatedButton(
                      child: Icon(Icons.dangerous),
                      onPressed: () {
                        removecart(data[index].item_code);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// class Total_screen extends StatefulWidget {
//   @override
//   _TotalState createState() => _TotalState();
// }

// class _TotalState extends State<Total_screen> {
//   getStringValues() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     //Return String
//     print("TOtal state");
//     String? cust_id = prefs.getString('cust_id');
//     print(cust_id);
//     return cust_id;
//   }

  // @override
  // Widget build(BuildContext context) {
  //   // final cart = Provider.of<Cart_>(context);
  //   return Scaffold(
  //     // appBar: AppBar(title: Text("Cart List")),
  //     body: Column(children: <Widget>[
  //       FutureBuilder<List<TotalItem>>(
  //         future: _fetchTotal(),
  //         builder: (context, snapshot) {
  //           if (snapshot.hasData) {
  //             List<TotalItem>? data = snapshot.data;
  //             if (snapshot.data!.length == 0) {
  //               return Container(
  //                   padding: EdgeInsets.only(left: 15, right: 15, top: 80),
  //                   child: Image.asset("assets/cart.png"));
  //             }
  //             return totalSlider(context, data);
  //           } else if (snapshot.hasError) {
  //             return Text("${snapshot.error}");
  //           }
  //           return Center(
  //               child: CircularProgressIndicator(
  //             valueColor: AlwaysStoppedAnimation<Color>(LightColor.blueColor),
  //           ));
  //         },
  //       ),
  //     ]),
  //   );
  // }

  // Future<List<TotalItem>> _fetchTotal() async {
    
  //   // dynamic token = await getStringValues();
  //   // dynamic branch = await getvalues();
  //   // var data = {'cust_id': token,'selectedcustbranch': branch};
  //   // var url = 'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesman_cart.php';
  //   // var response = await http.post(url, body: json.encode(data));
  //   // print("I am on total part ");
  //   // List jsonResponse = json.decode(response.body.toString());

  //   // _finalprice_= jsonResponse["price"].map((item) => new Item.fromJson(item)).toList();

  //   // return jsonResponse.map((item) => new TotalItem.fromJson(item)).toList();
    
  // }

  getvalues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    selectedcustbranch = prefs.getString('selectedcustbranch');

    return selectedcustbranch;
  }

  totalSlider(context, data) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {
        totalid = data[index];

        return Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                height: 10.0,
                width: 10.0,
                child: Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
              ),
            ],
          ),
        );
      },
    );
  }


totalprice(int sum) {
  return sum;
}

// subtotal() {
//   length = data[]
//
// }

