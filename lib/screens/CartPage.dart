import 'package:flutter/material.dart';
import 'package:responsify/responsify.dart';
import 'package:testing/Apis/CartPage.dart';
import 'package:testing/models/CartItem.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:testing/screens/CheckoutScreen.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int itemCount = 0;
  int quantityCount = 0;
  int foc = 0;
  int exFoc = 0;
  @override
  void initState() {
    super.initState();
    // fetchCartItem();
  }

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
      body: ResponsiveUiWidget(
        targetOlderComputers: true,
        builder: (context, deviceInfo) {
          if (deviceInfo.deviceTypeInformation ==
                  DeviceTypeInformation.TABLET ||
              deviceInfo.deviceTypeInformation ==
                  DeviceTypeInformation.MOBILE) {
            return FutureBuilder<List<CartItem>>(
                future: fetchCartItem(),
                builder: (context, snapshot) {
                  List<CartItem> cartItems = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data.length == 0) {
                      return Center(
                        child: Text("No Items in Cart"),
                      );
                    } else if (snapshot.data.length > 0) {
                      return SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(left: 05, right: 05),
                          width: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingRowHeight: 50,
                              dataRowHeight: 100,

                              columnSpacing: 110,
                              headingRowColor:
                                  MaterialStateProperty.all(Colors.white),
                              headingTextStyle: TextStyle(color: Colors.black),
                              // dataRowColor:
                              //     MaterialStateProperty.all(Colors.grey),
                              columns: [
                                DataColumn(
                                    label: Text(
                                        'Product Info')), // image , name of product , itemcode
                                DataColumn(label: Text('Quantity')),
                                DataColumn(label: Text('Price')),
                                DataColumn(label: Text('FOC')),
                                DataColumn(label: Text('Ex FOC')),
                                DataColumn(label: Text('Discount')),
                                DataColumn(label: Text('')),
                              ],
                              rows: cartItems
                                  .map((data) => DataRow(cells: [
                                        DataCell(ListTile(
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            child: Image.network(
                                                'https://onlinefamilypharmacy.com/images/noimage.jpg'),
                                          ),
                                          title: Text(data.itemName),
                                          subtitle: Text(data.itemCode),
                                        )),
                                        DataCell(Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  quantityCount--;
                                                });
                                              },
                                              icon: Icon(Icons.remove),
                                            ),
                                            Text(
                                              '${int.parse(data.quantity) + quantityCount}',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  quantityCount++;
                                                });
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ],
                                        )),
                                        DataCell(Text(
                                          data.finalprice,
                                          style: TextStyle(fontSize: 13),
                                        )),
                                        DataCell(Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  foc--;
                                                });
                                              },
                                              icon: Icon(Icons.remove),
                                            ),
                                            Text(
                                              '${int.parse(data.foc) + foc}',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  foc++;
                                                });
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ],
                                        )),
                                        DataCell(Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  exFoc--;
                                                });
                                              },
                                              icon: Icon(Icons.remove),
                                            ),
                                            Text(
                                              '${int.parse(data.exFoc) + exFoc}',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  exFoc++;
                                                });
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ],
                                        )),
                                        DataCell(Text(
                                          data.discount,
                                          style: TextStyle(fontSize: 13),
                                        )),
                                        DataCell(Row(
                                          children: [
                                            InkWell(
                                              child: Icon(
                                                Icons.delete_sharp,
                                                color: Colors.red,
                                              ),
                                              onTap: () {
                                                removeCart(data.itemCode);
                                                setState(() {});

                                                // Navigator.pushAndRemoveUntil(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             CartPage()));
                                              },
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                updateCart(
                                                    data.itemCode,
                                                    '${int.parse(data.quantity) + quantityCount}',
                                                    data.finalprice,
                                                    '${int.parse(data.foc) + foc}',
                                                    '${int.parse(data.exFoc) + exFoc}',
                                                    data.discount);
                                                setState(() {});
                                              },
                                              child: Icon(
                                                Icons.done_outline_outlined,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        )),
                                      ]))
                                  .toList(),
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Some Error Occured"),
                      );
                    }
                  }
                  return Center(
                    child: LinearProgressIndicator(),
                  );
                });
          }
          return Center(
            child: Text("Not Supported"),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen()));
            },
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
