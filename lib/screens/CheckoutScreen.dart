import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsify/responsify_files/responsify_enum.dart';
import 'package:responsify/responsify_files/responsify_ui_widget.dart';
import 'package:signature/signature.dart';
import 'package:testing/Apis/AddToCart.dart';
import 'package:testing/Apis/CartPage.dart';
import 'package:testing/models/CartItem.dart';
import 'package:testing/screens/DoneOrdering.dart';

class CheckoutScreen extends StatefulWidget {
  final List<String> packagingunit;
  final List<int> packingqty;
  final int totalItems;
  final List<String> itemCodes;
  final List<String> itemName;
  final List<int> quantity;
  final List<int> foc;
  final List<int> exFoc;
  final List<double> price;
  final List<double> common;
  final double checkoutTotal;
  CheckoutScreen(
      {Key key,
      @required this.packagingunit,
      @required this.packingqty,
      @required this.totalItems,
      @required this.checkoutTotal,
      @required this.exFoc,
      @required this.foc,
      @required this.itemCodes,
      @required this.itemName,
      @required this.price,
      @required this.quantity,
      @required this.common})
      : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController soReferenceNumber = TextEditingController();
  TextEditingController typeOfLead = TextEditingController();
  TextEditingController orderPlacedBy = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController notes = TextEditingController();
  Future getCart;

  void getcart() {
    setState(() {
      getCart = fetchCartItem();
    });
  }

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed'));
    getcart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.black,
            onPressed: () {
              if (soReferenceNumber == null ||
                  soReferenceNumber.text == '' && notes.text == null ||
                  notes.text == '' && typeOfLead.text == null ||
                  typeOfLead.text == '' && orderPlacedBy.text == null ||
                  orderPlacedBy.text == '') {
                final snackbar = SnackBar(
                  content: Text('Please Fill All the fields'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              } else {
                salesorder(
                    widget.quantity.toList(),
                    widget.price.toList(),
                    widget.itemCodes.toSet().toList(),
                    widget.packagingunit.toList(),
                    widget.packingqty.toList(),
                    widget.itemName.toList(),
                    widget.foc.toList(),
                    widget.exFoc.toList(),
                    int.parse(soReferenceNumber.text),
                    notes.text,
                    typeOfLead.text,
                    orderPlacedBy.text,
                    widget.common.toList());

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DoneOrdering()));
              }
            },
            label: Text('Place Order')),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Checkout"),
          actions: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Meet Shah \nP01",
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
            targetOlderComputers: false,
            builder: (context, deviceInfo) {
              if (deviceInfo.deviceTypeInformation ==
                      DeviceTypeInformation.TABLET &&
                  deviceInfo.orientation == Orientation.landscape) {
                return SingleChildScrollView(
                    child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width / 1.5,
                        // color: Colors.grey[300],
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                "Other Details",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    "SO Reference Number",
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 250),
                                  child: Text("Type of Lead"),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width: 280,
                                  margin: EdgeInsets.only(left: 20),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: soReferenceNumber,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 280,
                                  margin: EdgeInsets.only(right: 60),
                                  child: TextFormField(
                                    controller: typeOfLead,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    "Order Placed By",
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Text(
                                    "Email Id",
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 175),
                                  child: Text("Contact Number"),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width: 220,
                                  margin: EdgeInsets.only(left: 20),
                                  child: TextFormField(
                                    controller: orderPlacedBy,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 220,
                                  margin: EdgeInsets.only(left: 20),
                                  child: TextFormField(
                                    controller: emailId,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 220,
                                  margin: EdgeInsets.only(right: 60),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: contactNumber,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                "Notes",
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 200,
                              width: MediaQuery.of(context).size.width / 1.7,
                              margin: EdgeInsets.only(right: 60),
                              child: TextFormField(
                                controller: notes,
                                keyboardType: TextInputType.multiline,
                                maxLines: 6,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                "Signature",
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 150,
                              width: MediaQuery.of(context).size.width / 1.7,
                              margin: EdgeInsets.only(right: 60),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Signature(
                                controller: _controller,
                                height: 150,
                                backgroundColor: Colors.grey[100],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                _controller.clear();
                              },
                              child: Container(
                                  margin: EdgeInsets.only(right: 15),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    "Clear Signature",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width / 1.5,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Text(
                                    "Order Details",
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Container(
                                      margin: EdgeInsets.only(right: 15),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        "Total Items - ${widget.totalItems}",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                              FutureBuilder(
                                  future: getCart,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else {
                                      if (snapshot.data.length == 0) {
                                        return Center(
                                          child: Text("No Items"),
                                        );
                                      }
                                      if (snapshot.data.length > 0) {
                                        return Container(
                                          height: 300,
                                          child: ListView.separated(
                                              separatorBuilder:
                                                  (context, index) {
                                                return Divider(
                                                  thickness: 1,
                                                );
                                              },
                                              physics:
                                                  AlwaysScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: snapshot.data.length,
                                              itemBuilder: (context, index) {
                                                CartItem cart =
                                                    snapshot.data[index];

                                                return Row(
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: 100,
                                                      child: Image.network(
                                                          'https://onlinefamilypharmacy.com/images/noimage.jpg'),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                          "Item Code - ${cart.itemCode} \nItem Name - ${cart.itemName}\nPrice - ${double.parse(cart.finalprice).roundToDouble() * double.parse(cart.quantity).roundToDouble()} QR"),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        );
                                      }
                                    }
                                    return Container();
                                  }),
                              Divider(
                                thickness: 10.0,
                                color: Colors.grey[300],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text("Subtotal",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Text(
                                        widget.checkoutTotal.toString() + ' QR',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text("Discount",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text("Total Amount",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Text(
                                        widget.checkoutTotal.toString() + ' QR',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 10.0,
                                color: Colors.grey[300],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Customer Details",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Customer Name - United Intl Trdg",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Customer Email id - uitc@gmail.com",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Credit Limit - 0",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Credit Days - 0",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Invoice Price - Wholesale",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ));
              } else if (deviceInfo.deviceTypeInformation ==
                      DeviceTypeInformation.TABLET &&
                  deviceInfo.orientation == Orientation.portrait) {
                return SingleChildScrollView(
                    child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width / 1.5,
                        // color: Colors.grey[300],
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                "Other Details",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    "SO Reference Number",
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 250),
                                  child: Text("Type of Lead"),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width: 200,
                                  margin: EdgeInsets.only(left: 20),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: soReferenceNumber,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  margin: EdgeInsets.only(right: 130),
                                  child: TextFormField(
                                    controller: typeOfLead,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    "Order Placed By",
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Text(
                                    "Email Id",
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 145),
                                  child: Text("Contact Number"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width: 140,
                                  margin: EdgeInsets.only(left: 20),
                                  child: TextFormField(
                                    controller: orderPlacedBy,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 140,
                                  margin: EdgeInsets.only(right: 30),
                                  child: TextFormField(
                                    controller: emailId,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 140,
                                  margin: EdgeInsets.only(right: 100),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: contactNumber,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                "Notes",
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 200,
                              width: MediaQuery.of(context).size.width / 1.7,
                              margin: EdgeInsets.only(right: 60),
                              child: TextFormField(
                                controller: notes,
                                keyboardType: TextInputType.multiline,
                                maxLines: 6,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                "Signature",
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 150,
                              width: MediaQuery.of(context).size.width / 1.7,
                              margin: EdgeInsets.only(right: 60),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Signature(
                                controller: _controller,
                                height: 150,
                                backgroundColor: Colors.grey[300],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                _controller.clear();
                              },
                              child: Container(
                                  margin: EdgeInsets.only(right: 15),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    "Clear Signature",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width / 1.5,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Text(
                                    "Order Details",
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Container(
                                      margin: EdgeInsets.only(right: 15),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        "Total Items - ${widget.totalItems}",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                              FutureBuilder(
                                  future: getCart,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else {
                                      if (snapshot.data.length == 0) {
                                        return Center(
                                          child: Text("No Items"),
                                        );
                                      }
                                      if (snapshot.data.length > 0) {
                                        return Container(
                                          height: 300,
                                          child: ListView.separated(
                                              separatorBuilder:
                                                  (context, index) {
                                                return Divider(
                                                  thickness: 1,
                                                );
                                              },
                                              physics:
                                                  AlwaysScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: snapshot.data.length,
                                              itemBuilder: (context, index) {
                                                CartItem cart =
                                                    snapshot.data[index];

                                                return Row(
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: 100,
                                                      child: Image.network(
                                                          'https://onlinefamilypharmacy.com/images/noimage.jpg'),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Item Code - ${cart.itemCode}',
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                        Text(
                                                          '${cart.itemName}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                        ),
                                                        Text(
                                                            'Price - ${double.parse(cart.finalprice).roundToDouble() * double.parse(cart.quantity).roundToDouble()} QR')
                                                      ],
                                                    ),
                                                    // Container(
                                                    //   child: Text(
                                                    //       "Item Code - ${cart.itemCode} \nItem Name - ${cart.itemName}\nPrice - ${double.parse(cart.finalprice).roundToDouble() * double.parse(cart.quantity).roundToDouble()} QR"),
                                                    // ),
                                                    // Container(
                                                    //   child: Text($(double.parse(
                                                    //       cart.quantity) * double.parse(cart.finalprice).reduce(value,element){

                                                    //       })),
                                                    // )
                                                  ],
                                                );
                                              }),
                                        );
                                      }
                                    }
                                    return Container();
                                  }),
                              Divider(
                                thickness: 10.0,
                                color: Colors.grey[300],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text("Subtotal",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Text(
                                        widget.checkoutTotal.toString() + ' QR',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text("Discount",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text("Total Amount",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Text(
                                        widget.checkoutTotal.toString() + ' QR',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 10.0,
                                color: Colors.grey[300],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Customer Details",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Customer Name - United Intl Trdg",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Customer Email id - uitc@gmail.com",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Credit Limit - 0",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Credit Days - 10",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Invoice Price - Wholesale",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ));
              } else if (deviceInfo.deviceTypeInformation ==
                  DeviceTypeInformation.MOBILE) {
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Other Details",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 28),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  "SO Reference Number",
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 70),
                                child: Text("Type of Lead"),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                width: 140,
                                margin: EdgeInsets.only(right: 20, left: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: soReferenceNumber,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 140,
                                margin: EdgeInsets.only(right: 20),
                                child: TextFormField(
                                  controller: typeOfLead,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Order Placed By",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.1,
                            // margin: EdgeInsets.only(left: 20),
                            child: TextFormField(
                              controller: orderPlacedBy,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email Id",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.1,
                            // margin: EdgeInsets.only(right: 30),
                            child: TextFormField(
                              controller: emailId,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            child: Text("Contact"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.1,
                            // margin: EdgeInsets.only(right: 30),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: contactNumber,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Notes",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 140,
                            width: MediaQuery.of(context).size.width / 1.1,
                            // margin: EdgeInsets.only(right: 60),
                            child: TextFormField(
                              controller: notes,
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Signature",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 140,
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child: Signature(
                              controller: _controller,
                              height: 140,
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              _controller.clear();
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: 15),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  "Clear Signature",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        // height: MediaQuery.of(context).size.height,
                        // width: MediaQuery.of(context).size.width -
                        //     MediaQuery.of(context).size.width / 1.5,
                        child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: Text(
                              "Order Details",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            )),
                            Container(
                                margin: EdgeInsets.only(right: 15),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  "Total Items - ${widget.totalItems}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                        FutureBuilder(
                            future: getCart,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else {
                                if (snapshot.data.length == 0) {
                                  return Center(
                                    child: Text("No Items"),
                                  );
                                }
                                if (snapshot.data.length > 0) {
                                  return SizedBox(
                                    height: 300,
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            thickness: 1,
                                          );
                                        },
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          CartItem cart = snapshot.data[index];

                                          // itemCodes.add(
                                          //     cart.itemCode); // itemCode added
                                          // quantity
                                          //     .add(int.parse(cart.quantity));
                                          // foc.add(int.parse(cart.foc));
                                          // exFoc.add(int.parse(cart.exFoc));

                                          // price.add(
                                          //     double.parse(cart.finalprice)
                                          //             .roundToDouble() *
                                          //         double.parse(cart.quantity)
                                          //             .roundToDouble());
                                          // itemName.add(cart.itemName);

                                          // itemCodes.add(cart.itemCode);

                                          return Row(
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                child: Image.network(
                                                    'https://onlinefamilypharmacy.com/images/noimage.jpg'),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Item Code - ${cart.itemCode}',
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    '${cart.itemName}',
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                  Text(
                                                      'Price - ${double.parse(cart.finalprice).roundToDouble() * double.parse(cart.quantity).roundToDouble()} QR')
                                                ],
                                              ),
                                              // Container(
                                              //   child: Text(
                                              //       "Item Code - ${cart.itemCode} \nItem Name - ${cart.itemName}\nPrice - ${double.parse(cart.finalprice).roundToDouble() * double.parse(cart.quantity).roundToDouble()} QR"),
                                              // ),
                                              // Container(
                                              //   child: Text($(double.parse(
                                              //       cart.quantity) * double.parse(cart.finalprice).reduce(value,element){

                                              //       })),
                                              // )
                                            ],
                                          );
                                        }),
                                  );
                                }
                              }
                              return Container();
                            }),
                        Divider(
                          thickness: 10.0,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text("Subtotal",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Text(
                                  widget.checkoutTotal.toString() + ' QR',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text("Discount",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold)),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text("Total Amount",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Text(
                                  widget.checkoutTotal.toString() + ' QR',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 10.0,
                          color: Colors.grey[300],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Customer Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Customer Name - United Intl Trdg",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Customer Email id - uitc@gmail.com",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Credit Limit - 0",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Credit Days - 10",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Invoice Price - Wholesale",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ))
                  ],
                ));
              }
              return Center(
                child: Text("Unsupported Device Type"),
              );
            }));
  }
}
