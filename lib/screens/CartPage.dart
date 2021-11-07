import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Cart"),
        actions: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Manu Kumar \nEMP0001",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          IconButton(
            icon: Icon(Icons.person_sharp),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.yellow,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              color: Colors.grey[200],
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Product",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7.5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Price",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 18,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Units",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 18,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Qty",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 18,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Fixed Foc",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 18,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Alloc FOC",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 18,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Ex FOC",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 18,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Discount",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 18,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Discount %",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 18,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Total",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 13,
                  ),
                  Text(
                    "",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            "https://d2f9uwgpmber13.cloudfront.net/public/uploads/mobile/7c902eb8a6f1f3453fc9e0e99f34838c",
                            height: 90,
                            width: 90,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "RegisterBook",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                "Item Code - 10015",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              Text(
                                "Item name - Loreum",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              Text(
                                "Variant - Expiry",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("130.00")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 18,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("Box")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 14.5,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("10")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 12,
                  ),
                  Container(margin: EdgeInsets.only(top: 30), child: Text("1")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 8,
                  ),
                  Container(margin: EdgeInsets.only(top: 30), child: Text("1")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 11,
                  ),
                  Container(margin: EdgeInsets.only(top: 30), child: Text("0")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("5.00")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("0.00")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 13,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("125.00")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 14,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 27),
                      alignment: Alignment.topCenter,
                      child: Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            Container(
              height: 100,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            "https://d2f9uwgpmber13.cloudfront.net/public/uploads/mobile/7c902eb8a6f1f3453fc9e0e99f34838c",
                            height: 90,
                            width: 90,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "RegisterBook",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                "Item Code - 10015",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              Text(
                                "Item name - Loreum",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              Text(
                                "Variant - Expiry",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("130.00")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 18,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("Box")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 14.5,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("10")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 12,
                  ),
                  Container(margin: EdgeInsets.only(top: 30), child: Text("1")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 8,
                  ),
                  Container(margin: EdgeInsets.only(top: 30), child: Text("1")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 11,
                  ),
                  Container(margin: EdgeInsets.only(top: 30), child: Text("0")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("5.00")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("0.00")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 13,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("125.00")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 14,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 27),
                      alignment: Alignment.topCenter,
                      child: Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            Container(
              height: 100,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            "https://d2f9uwgpmber13.cloudfront.net/public/uploads/mobile/7c902eb8a6f1f3453fc9e0e99f34838c",
                            height: 90,
                            width: 90,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "RegisterBook",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                "Item Code - 10015",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              Text(
                                "Item name - Loreum",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              Text(
                                "Variant - Expiry",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("130.00")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 18,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("Box")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 14.5,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("10")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 12,
                  ),
                  Container(margin: EdgeInsets.only(top: 30), child: Text("1")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 8,
                  ),
                  Container(margin: EdgeInsets.only(top: 30), child: Text("1")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 11,
                  ),
                  Container(margin: EdgeInsets.only(top: 30), child: Text("0")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("5.00")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("0.00")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 13,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30), child: Text("125.00")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 14,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 27),
                      alignment: Alignment.topCenter,
                      child: Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("Subtotal",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text("130.00 QR",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("Discount",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 32,
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text("0.00 QR",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("Total",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 45,
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text("125.00 QR",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width / 3,
        child: FloatingActionButton.extended(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.amber,
            ),
            backgroundColor: Colors.black,
            splashColor: Colors.amber,
            label: Text("Finish Ordering")),
      ),
    );
  }
}
