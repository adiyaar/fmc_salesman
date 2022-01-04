import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsify/responsify.dart';
import 'package:testing/Apis/CartPage.dart';
import 'package:testing/models/CartItem.dart';
import 'package:flutter/foundation.dart';
import 'package:testing/screens/CheckoutScreen.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  bool loaderVisible = false;
  int totalItems = 0;
  double totalCheckout = 0.0;
  int itemCount = 0;
  int quantityCount = 0;
  int foc = 0;
  int exFoc = 0;
  List<String> itemCodes = [];
  List<double> common = [];
  List<String> itemName = [];
  List<int> quantity = [];
  List<int> focList = [];
  List<int> exFocList = [];
  List<double> price = [];

  Future resultGetData;

  void getData() {
    setState(() {
      resultGetData = fetchCartItem();
    });
  }

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    totalCheckout = 0.0;
    itemCodes = [];
    itemName = [];
    quantity = [];
    focList = [];
    exFocList = [];
    price = [];
    common = [];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Must include

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
      body: LoaderOverlay(
        disableBackButton: false,
        child: ResponsiveUiWidget(
          targetOlderComputers: true,
          builder: (context, deviceInfo) {
            if (deviceInfo.deviceTypeInformation ==
                    DeviceTypeInformation.TABLET ||
                deviceInfo.deviceTypeInformation ==
                    DeviceTypeInformation.MOBILE) {
              return FutureBuilder<List<CartItem>>(
                  initialData: [],
                  future: resultGetData,
                  builder: (context, snapshot) {
                    List<CartItem> cartItems = snapshot.data;
                    print(cartItems.length);
                    itemCodes.addAll(cartItems.map((e) => e.itemCode));
                    common.addAll(cartItems.map((e) => double.parse(e.cutoFF)));
                    itemName.addAll(cartItems.map((e) => e.itemName));
                    quantity
                        .addAll(cartItems.map((e) => int.parse(e.quantity)));
                    focList.addAll(cartItems.map((e) => int.parse(e.foc)));
                    exFocList.addAll(cartItems.map((e) => int.parse(e.exFoc)));

                    price.addAll(cartItems.map((e) =>
                        (double.parse(e.finalprice).roundToDouble() *
                            double.parse(e.quantity).roundToDouble())));

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.data.length == 0) {
                        return Center(
                          child: Text("No Items in Cart"),
                        );
                      } else if (snapshot.data.length > 0) {
                        totalItems = snapshot.data.length;
                        for (int i = 0; i < snapshot.data.length; i++) {
                          totalCheckout =
                              (double.parse(snapshot.data[i].finalprice)
                                          .roundToDouble() *
                                      double.parse(snapshot.data[i].quantity)
                                          .roundToDouble()) +
                                  totalCheckout;
                        }
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
                                headingTextStyle:
                                    TextStyle(color: Colors.black),
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
                                  DataColumn(label: Text('SubTotal')),
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
                                              // IconButton(
                                              //   onPressed: () {
                                              //     setState(() {
                                              //       quantityCount--;
                                              //     });
                                              //   },
                                              //   icon: Icon(Icons.remove),
                                              // ),

                                              Container(
                                                height: 30,
                                                width: 100,
                                                child: TextFormField(
                                                  initialValue: data.quantity,
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          Colors.grey[300],
                                                      border: InputBorder.none),
                                                  onFieldSubmitted: (string) {
                                                    setState(() {
                                                      data.quantity = string;
                                                    });

                                                    updateCart(
                                                        context,
                                                        data.itemCode,
                                                        data.quantity,
                                                        data.finalprice,
                                                        '${int.parse(data.foc) + foc}',
                                                        '${int.parse(data.exFoc) + exFoc}',
                                                        data.discount);
                                                  },
                                                ),
                                              ),
                                              // Text(
                                              //   '${int.parse(data.quantity) + quantityCount}',
                                              //   style: TextStyle(fontSize: 13),
                                              // ),
                                              // IconButton(
                                              //   onPressed: () {
                                              //     setState(() {
                                              //       quantityCount++;
                                              //     });
                                              //   },
                                              //   icon: Icon(Icons.add),
                                              // ),
                                            ],
                                          )),
                                          DataCell(Text(
                                            data.finalprice,
                                            style: TextStyle(fontSize: 13),
                                          )),
                                          DataCell(Row(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 100,
                                                child: TextFormField(
                                                  initialValue: data.foc,
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          Colors.grey[300],
                                                      border: InputBorder.none),
                                                  onFieldSubmitted: (string) {
                                                    setState(() {
                                                      data.foc = string;
                                                    });

                                                    updateCart(
                                                        context,
                                                        data.itemCode,
                                                        data.quantity,
                                                        data.finalprice,
                                                        data.foc,
                                                        '${int.parse(data.exFoc) + exFoc}',
                                                        data.discount);
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
                                          DataCell(Row(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 100,
                                                child: TextFormField(
                                                  initialValue: data.exFoc,
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          Colors.grey[300],
                                                      border: InputBorder.none),
                                                  onFieldSubmitted: (string) {
                                                    setState(() {
                                                      data.exFoc = string;
                                                    });

                                                    updateCart(
                                                        context,
                                                        data.itemCode,
                                                        data.quantity,
                                                        data.finalprice,
                                                        data.foc,
                                                        '${int.parse(data.exFoc) + exFoc}',
                                                        data.discount);
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
                                          DataCell(Text(
                                            data.discount,
                                            style: TextStyle(fontSize: 13),
                                          )),
                                          DataCell(Text(
                                              '${double.parse(data.finalprice).roundToDouble() * double.parse(data.quantity).roundToDouble()} QR')),
                                          DataCell(Row(
                                            children: [
                                              InkWell(
                                                child: Icon(
                                                  Icons.delete_sharp,
                                                  color: Colors.red,
                                                ),
                                                onTap: () {
                                                  removeCart(
                                                      context, data.itemCode);
                                                  setState(() {});
                                                },
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckoutScreen(
                            totalItems: totalItems,
                            checkoutTotal: totalCheckout,
                            exFoc: exFocList,
                            foc: focList,
                            itemCodes: itemCodes,
                            itemName: itemName,
                            price: price,
                            quantity: quantity,
                            common: common,
                          )));
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
