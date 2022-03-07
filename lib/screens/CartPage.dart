import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsify/responsify.dart';
import 'package:testing/Apis/CartPage.dart';
import 'package:testing/models/CartItem.dart';
import 'package:flutter/foundation.dart';
import 'package:testing/screens/CheckoutScreen.dart';

class CartPage extends StatefulWidget {
  final List useriNfo;
  CartPage({Key key, this.useriNfo}) : super(key: key);

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
  List<int> packagingname = [];
  List<String> packaginunit = [];
  int exFoc = 0;
  List<String> itemCodes = [];
  List<double> common = [];
  List<String> itemName = [];
  List<int> quantity = [];
  List<int> focList = [];
  List<int> exFocList = [];
  List<double> price = [];
  List<double> wacCost = [];
  List<double> managementCost = [];
  List<double> calculatedCost = [];
  List<String> subtotalofItem = [];

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
    subtotalofItem = [];
    quantity = [];
    focList = [];
    packagingname = [];
    packaginunit = [];
    exFocList = [];
    price = [];
    common = [];
    calculatedCost = [];
    managementCost = [];
    wacCost = [];
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
              "${widget.useriNfo[0].employeename} \n${widget.useriNfo[0].workingin}",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          IconButton(
            icon: Icon(Icons.person_sharp),
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
                initialData: [],
                future: resultGetData,
                builder: (context, snapshot) {
                  List<CartItem> cartItems = snapshot.data;

                  itemCodes.addAll(cartItems.map((e) => e.itemCode));
                  common.addAll(cartItems.map((e) => double.parse(e.cutoFF)));
                  itemName.addAll(cartItems.map((e) => e.itemName));
                  quantity.addAll(cartItems.map((e) => int.parse(e.quantity)));
                  focList.addAll(cartItems.map((e) => int.parse(e.foc)));
                  exFocList.addAll(cartItems.map((e) => int.parse(e.exFoc)));
                  packagingname
                      .addAll(cartItems.map((e) => int.parse(e.packing)));
                  packaginunit.addAll(cartItems.map((e) => e.units));
                  wacCost.addAll(cartItems.map((e) => double.parse(e.itemWac)));
                  managementCost
                      .addAll(cartItems.map((e) => double.parse(e.itemMgmt)));
                  calculatedCost
                      .addAll(cartItems.map((e) => double.parse(e.cutoFF)));

                  subtotalofItem.addAll(cartItems.map((e) =>
                      (double.parse(e.finalprice) * double.parse(e.quantity))
                          .toStringAsFixed(2)));

                  price.addAll(cartItems.map((e) =>
                      (double.parse(e.finalprice) * double.parse(e.quantity))));

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
                      totalItems = snapshot.data.length;
                      for (int i = 0; i < snapshot.data.length; i++) {
                        String temp =
                            ((double.parse(snapshot.data[i].finalprice) *
                                    double.parse(snapshot.data[i].quantity))
                                .toStringAsFixed(2));

                        totalCheckout = double.parse(temp) + totalCheckout;
                      }
                      return SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          margin: EdgeInsets.only(left: 05, right: 05),
                          width: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              showBottomBorder: true,
                              headingRowHeight: 50,
                              dataRowHeight: 80,

                              // columnSpacing: 80,
                              headingRowColor:
                                  MaterialStateProperty.all(Colors.white),
                              headingTextStyle: TextStyle(color: Colors.black),

                              columns: [
                                DataColumn(
                                    label: Text(
                                        'Product Info')), // image , name of product , itemcode

                                DataColumn(label: Text('Units')),
                                DataColumn(label: Text('Price')),
                                DataColumn(label: Text('Quantity')),
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
                                            height: 100,
                                            width: 50,
                                            child: 'https://onlinefamilypharmacy.com/images/item/${data.image}' ==
                                                    'https://onlinefamilypharmacy.com/images/item/null'
                                                ? CachedNetworkImage(
                                                    imageUrl:
                                                        'https://onlinefamilypharmacy.com/images/noimage.jpg',
                                                    height: 130,
                                                    width: 100,
                                                    fit: BoxFit.fill,
                                                    progressIndicatorBuilder:
                                                        (_, url, download) {
                                                      if (download.progress !=
                                                          null) {
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: download
                                                                .progress,
                                                            color: Colors.black,
                                                          ),
                                                        );
                                                      }
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.black,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        'https://onlinefamilypharmacy.com/images/item/${data.image}',
                                                    height: 130,
                                                    width: 100,
                                                    fit: BoxFit.fill,
                                                    progressIndicatorBuilder:
                                                        (_, url, download) {
                                                      if (download.progress !=
                                                          null) {
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: download
                                                                .progress,
                                                            color: Colors.black,
                                                          ),
                                                        );
                                                      }
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.black,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                          ),
                                          title: Text(data.itemName),
                                          subtitle: Text(data.itemCode),
                                        )),
                                        DataCell(Text(
                                          data.units + ' - ' + data.packing,
                                          style: TextStyle(fontSize: 13),
                                        )),
                                        DataCell(Text(
                                          data.finalprice,
                                          style: TextStyle(fontSize: 13),
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
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[300],
                                                    border: InputBorder.none),

                                                    
                                                onFieldSubmitted: (string) {
                                                  setState(() {
                                                    data.quantity = string;
                                                  });
                                                  print(data.quantity);
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
                                        DataCell(Row(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 100,
                                              child: TextFormField(
                                                initialValue: data.foc,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[300],
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
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[300],
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
                                            '${(double.parse(data.finalprice) * double.parse(data.quantity)).toStringAsFixed(2)} QR')),
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
                                                Future.delayed(
                                                    Duration(seconds: 1), () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              super.widget));
                                                });
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckoutScreen(
                            itemSubtotal: subtotalofItem,
                            userInfo: widget.useriNfo,
                            packagingunit: packaginunit,
                            packingqty: packagingname,
                            totalItems: totalItems,
                            checkoutTotal:
                                double.parse(totalCheckout.toStringAsFixed(2)),
                            exFoc: exFocList,
                            foc: focList,
                            itemCodes: itemCodes,
                            itemName: itemName,
                            price: price,
                            quantity: quantity,
                            wacCost: wacCost,
                            calcCOst: calculatedCost,
                            mgmtCost: managementCost,
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
