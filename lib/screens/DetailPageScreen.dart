import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsify/responsify.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:testing/Apis/AddToCart.dart';
import 'package:testing/Common/DetailShimmer.dart';

import 'package:testing/models/DetailPageModel.dart';
import 'package:http/http.dart' as http;
import 'package:testing/screens/ViewPastOrder.dart';

import 'CartPage.dart';

class DetailPageScreen extends StatefulWidget {
  final customerType;
  final itemDetails;
  DetailPageScreen({Key key, @required this.itemDetails, this.customerType})
      : super(key: key);

  @override
  _DetailPageScreenState createState() => _DetailPageScreenState();
}

class _DetailPageScreenState extends State<DetailPageScreen> {
  String customerType, customerBranchId, branchId;
  void customerInfo() async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    customerBranchId = pf.getString('customerId');
    branchId = pf.getString('branchId');
    customerType = pf.getString('cust_type');
  }

  List variants = [];
  List units = [];
  String selectedVariant;
  String selectedUnit;
  TextEditingController quantityController =
      TextEditingController(); // quantity
  TextEditingController focController = TextEditingController(); // foc
  TextEditingController extraFocController =
      TextEditingController(); // extra foc

  Future<List<Salesmandetailpage>> fetchProductInfo() async {
    final baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmandetailpage.php';
    var data = {'itemproductgroupid': widget.itemDetails.itemproductgroupid};
    final response =
        await http.post(Uri.parse(baseUrl), body: jsonEncode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse
          .map((e) => new Salesmandetailpage.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future getVariant() async {
    var data = {'itemproductgroupid': widget.itemDetails.itemproductgroupid};
    var response = await http.post(
        Uri.parse(
            'https://onlinefamilypharmacy.com/mobileapplication/pages/dropdown_api.php'),
        body: json.encode(data));
    var jsonResponse = response.body;
    var jsonData = json.decode(jsonResponse);

    print(jsonData);

    setState(() {
      variants = jsonData;
    });
  }

  Future getUnitsandPrice() async {
    String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/pages/dropdown.php';

    var data = {'id': widget.itemDetails.itemid};
    var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));
    var jsondataval = json.decode(response.body);
    print(jsondataval);
    setState(() {
      units = jsondataval;
    });
  }

  @override
  void initState() {
    super.initState();
    // fetchProductInfo();
    getVariant();
    getUnitsandPrice();
    customerInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Detail page"),
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
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
          ),
        ],
      ),
      body: ResponsiveUiWidget(
        targetOlderComputers: false,
        builder: (context, deviceInfo) {
          if (deviceInfo.deviceTypeInformation ==
                  DeviceTypeInformation.TABLET &&
              deviceInfo.orientation == Orientation.landscape) {
            return FutureBuilder(
              future: fetchProductInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Salesmandetailpage> iteminfo = snapshot.data;
                  return SingleChildScrollView(
                      child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 17,
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: 'https://onlinefamilypharmacy.com/images/item/${widget.itemDetails.img}' ==
                                          'https://onlinefamilypharmacy.com/images/item/null'
                                      ? Image.network(
                                          'https://onlinefamilypharmacy.com/images/noimage.jpg')
                                      : Image.network(
                                          'https://onlinefamilypharmacy.com/images/item/${widget.itemDetails.img}'),
                                  // child: SnapShotCarousel.snapShotCarousel(
                                  //   [
                                  //     'https://onlinefamilypharmacy.com/images/item/${widget.itemDetails.img}' ==
                                  //             'https://onlinefamilypharmacy.com/images/item/null'
                                  //         ? Image.network(
                                  //             'https://onlinefamilypharmacy.com/images/noimage.jpg')
                                  //         : Image.network(
                                  //             'https://onlinefamilypharmacy.com/images/item/${widget.itemDetails.img}'),
                                  //     'https://onlinefamilypharmacy.com/images/item/${widget.itemDetails.img}' ==
                                  //             'https://onlinefamilypharmacy.com/images/item/null'
                                  //         ? Image.network(
                                  //             'https://onlinefamilypharmacy.com/images/noimage.jpg')
                                  //         : Image.network(
                                  //             'https://onlinefamilypharmacy.com/images/item/${widget.itemDetails.img}'),
                                  //     // Image.network(
                                  //     //     "https://d2f9uwgpmber13.cloudfront.net/public/uploads/mobile/87e5d8fda7b970c4fe5ffd23ad400436"),
                                  //   ],
                                  // ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 1.7,
                            // color: Colors.yellow,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      iteminfo[0].itemproductgrouptitle,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 40),
                                      child: Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.checkCircle,
                                            color: Colors.green,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            "5 in Stock",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Manufacturer - FMC",
                                    // + iteminfo[0].manufactureshortname,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                //  Container(
                                //     height: 30,
                                //     child: FutureBuilder(
                                //       future: getUnitsandPrice(),
                                //       builder: (ctx, snapshot) {
                                //         if (snapshot.hasData) {
                                //           if (snapshot.data.length == 0) {
                                //             return Text(
                                //                 "No Data on this ItemPack");
                                //           }
                                //           return ListView.builder(
                                //               itemCount: 1,
                                //               // ignore: missing_return
                                //               itemBuilder: (ctx, index) {
                                //                 var list = snapshot.data[index];
                                //                 if (customerType == null ||
                                //                     customerType == 'Retail') {
                                //                   return ListTile(
                                //                     title: Text(
                                //                       "\QR ${list['rs'].toString()}",
                                //                       style: TextStyle(
                                //                           fontSize: 18,
                                //                           fontWeight:
                                //                               FontWeight.bold),
                                //                     ),
                                //                   );
                                //                 } else if (customerType ==
                                //                     'Wholesale') {
                                //                   return ListTile(
                                //                     title: Text(
                                //                       "\QR ${list['ws'].toString()}",
                                //                       style: TextStyle(
                                //                           fontSize: 18,
                                //                           fontWeight:
                                //                               FontWeight.bold),
                                //                     ),
                                //                   );
                                //                 }
                                //               });
                                //         }
                                //         return Text("");
                                //       },
                                //     )),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "\QR ${iteminfo[0].minretailprice}" +
                                        "-" +
                                        "\QR ${iteminfo[0].maxretailprice}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Colors.orange),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 18,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Select Variant",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 220.0),
                                        child: Text(
                                          "Select Units",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Container(
                                          margin: EdgeInsets.only(top: 3),
                                          padding: EdgeInsets.all(10),
                                          // child: Text(
                                          //   "Expiry",
                                          //   style: TextStyle(
                                          //       fontSize: 16,
                                          //       fontWeight: FontWeight.w800),
                                          //   textAlign: TextAlign.left,
                                          // ),
                                          child: DropdownButton(
                                            underline: SizedBox(),
                                            value: selectedVariant,
                                            hint: Text("Select Variants"),
                                            items: variants.map(
                                              (list) {
                                                return DropdownMenuItem(
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4.7,
                                                      child: Text(
                                                        list['itempack'],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                    value: list['id']);
                                              },
                                            ).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedVariant = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Container(
                                          margin: EdgeInsets.only(top: 5),
                                          padding: EdgeInsets.all(10),
                                          child: DropdownButton(
                                            underline: SizedBox(),
                                            value: selectedVariant,
                                            hint: Text("Select Unit"),
                                            items: units.map(
                                              (list) {
                                                return DropdownMenuItem(
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4.7,
                                                      child: Text(
                                                        list['unit'] == null
                                                            ? 'No Unit'
                                                            : list['unit'],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                    value: list['id']);
                                              },
                                            ).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedUnit = value;
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Qty",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 50),
                                        child: Text(
                                          "Alloc FOC",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 140),
                                        child: Text(
                                          "Extra FOC",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Container(
                                          margin: EdgeInsets.only(top: 5),
                                          padding: EdgeInsets.all(10),
                                          // child: Text(
                                          //   "10",
                                          //   style: TextStyle(
                                          //       fontSize: 16,
                                          //       fontWeight: FontWeight.w800),
                                          //   textAlign: TextAlign.left,
                                          // ),
                                          child: TextFormField(
                                            controller: quantityController,
                                            keyboardType: TextInputType
                                                .numberWithOptions(),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Container(
                                          margin: EdgeInsets.only(top: 5),
                                          padding: EdgeInsets.all(10),
                                          // child: Text(
                                          //   "10",
                                          //   style: TextStyle(
                                          //       fontSize: 16,
                                          //       fontWeight: FontWeight.w800),
                                          //   textAlign: TextAlign.left,
                                          // ),
                                          child: TextFormField(
                                            controller: focController,
                                            keyboardType: TextInputType
                                                .numberWithOptions(),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              // fillColor: Color(0xfff3f3f4),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Container(
                                          margin: EdgeInsets.only(top: 5),
                                          padding: EdgeInsets.all(10),
                                          // child: Text(
                                          //   "10",
                                          //   style: TextStyle(
                                          //       fontSize: 16,
                                          //       fontWeight: FontWeight.w800),
                                          //   textAlign: TextAlign.left,
                                          // ),
                                          child: TextFormField(
                                            controller: extraFocController,
                                            keyboardType: TextInputType
                                                .numberWithOptions(),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    widget.customerType == null
                                        ? GestureDetector(
                                            onTap: () {
                                              final snackBar = SnackBar(
                                                content: const Text(
                                                    'Please Select a Customer First'),
                                                action: SnackBarAction(
                                                  label: '',
                                                  onPressed: () {},
                                                ),
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0)),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Add to Cart",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              if (quantityController.text ==
                                                      '' ||
                                                  quantityController.text ==
                                                      null) {
                                                final snackBar = SnackBar(
                                                  content: const Text(
                                                      'Please enter quantity'),
                                                  action: SnackBarAction(
                                                    label: '',
                                                    onPressed: () {},
                                                  ),
                                                );

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              } else if (focController.text ==
                                                      '' ||
                                                  focController.text == null) {
                                                final snackBar = SnackBar(
                                                  content: const Text(
                                                      'Please enter FOC'),
                                                  action: SnackBarAction(
                                                    label: '',
                                                    onPressed: () {},
                                                  ),
                                                );

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                                ;
                                              } else if (extraFocController
                                                          .text ==
                                                      '' ||
                                                  extraFocController.text ==
                                                      null) {
                                                final snackBar = SnackBar(
                                                  content: const Text(
                                                      'Please enter exFOc'),
                                                  action: SnackBarAction(
                                                    label: '',
                                                    onPressed: () {},
                                                  ),
                                                );

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              } else {
                                                addToCart(
                                                    context,
                                                    customerBranchId,
                                                    widget.itemDetails.itemid,
                                                    iteminfo[0].minretailprice,
                                                    quantityController.text,
                                                    focController.text,
                                                    extraFocController.text,
                                                    "0",
                                                    branchId,
                                                    1000,
                                                    1000.00,
                                                    "Bundle",
                                                    1000.00,
                                                    1000.00,
                                                    1000.00,
                                                    "FMEAPP");
                                              }
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0)),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Add to Cart",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          ),
                                    InkWell(
                                      onTap: () {
                                        // fetchCartItem();

                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    ViewPastOrder()));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "View Order History",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 30),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Item Code - ${widget.itemDetails.itemid} \nItem name - ${widget.itemDetails.itemproductgrouptitle} \nType of Packing - Expiry\nQty Per packing - 1",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Short Description",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            // iteminfo[0].shortdescription,
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Content Description",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            // iteminfo[0].description,
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Content Description",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return DetailPageShimmer();
                }

                return DetailPageShimmer();
                // return Center(
                //   child: CircularPercentIndicator(
                //     radius: 100.0,
                //     lineWidth: 10.0,
                //     percent: 1.0,
                //     animationDuration: 8000,
                //     restartAnimation: true,
                //     animation: true,
                //     footer: Text("Fetching Data Securely!"),
                //     center: new Icon(
                //       Icons.lock,
                //       size: 50.0,
                //       color: Colors.black,
                //     ),
                //     backgroundColor: Colors.white,
                //     circularStrokeCap: CircularStrokeCap.round,
                //     progressColor: Colors.black,
                //   ),
                // );
              },
            );
          } else if (deviceInfo.deviceTypeInformation ==
                  DeviceTypeInformation.TABLET &&
              deviceInfo.orientation == Orientation.portrait) {
            return FutureBuilder(
              future: fetchProductInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Salesmandetailpage> iteminfo = snapshot.data;
                  return SingleChildScrollView(
                      child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: 'https://onlinefamilypharmacy.com/images/item/${widget.itemDetails.img}' ==
                                          'https://onlinefamilypharmacy.com/images/item/null'
                                      ? Image.network(
                                          'https://onlinefamilypharmacy.com/images/noimage.jpg')
                                      : Image.network(
                                          'https://onlinefamilypharmacy.com/images/item/${widget.itemDetails.img}'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 2.1,
                            // color: Colors.yellow,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      iteminfo[0].itemproductgrouptitle,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 40),
                                      child: Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.checkCircle,
                                            color: Colors.green,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            "5 in Stock",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Manufacturer - FMC",
                                    // + iteminfo[0].manufactureshortname,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "\QR ${iteminfo[0].minretailprice}" +
                                        "-" +
                                        "\QR ${iteminfo[0].maxretailprice}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Colors.orange),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 14,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Select Variant",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 130.0),
                                        child: Text(
                                          "Select Units",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Container(
                                          margin: EdgeInsets.only(top: 3),
                                          padding: EdgeInsets.all(10),
                                          // child: Text(
                                          //   "Expiry",
                                          //   style: TextStyle(
                                          //       fontSize: 16,
                                          //       fontWeight: FontWeight.w800),
                                          //   textAlign: TextAlign.left,
                                          // ),
                                          child: DropdownButton(
                                            underline: SizedBox(),
                                            value: selectedVariant,
                                            hint: Text("Select Variants"),
                                            items: variants.map(
                                              (list) {
                                                return DropdownMenuItem(
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                      child: Text(
                                                        list['itempack'],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                    value: list['id']);
                                              },
                                            ).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedVariant = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Container(
                                          margin: EdgeInsets.only(top: 5),
                                          padding: EdgeInsets.all(10),
                                          child: DropdownButton(
                                            underline: SizedBox(),
                                            value: selectedVariant,
                                            hint: Text("Select Unit"),
                                            items: units.map(
                                              (list) {
                                                return DropdownMenuItem(
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4.7,
                                                      child: Text(
                                                        list['unit'] == null
                                                            ? 'No Unit'
                                                            : list['unit'],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                    value: list['id']);
                                              },
                                            ).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedUnit = value;
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Qty",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 50),
                                        child: Text(
                                          "Alloc FOC",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 140),
                                        child: Text(
                                          "Extra FOC",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Container(
                                          margin: EdgeInsets.only(top: 5),
                                          padding: EdgeInsets.all(10),
                                          // child: Text(
                                          //   "10",
                                          //   style: TextStyle(
                                          //       fontSize: 16,
                                          //       fontWeight: FontWeight.w800),
                                          //   textAlign: TextAlign.left,
                                          // ),
                                          child: TextFormField(
                                            controller: quantityController,
                                            keyboardType: TextInputType
                                                .numberWithOptions(),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Container(
                                          margin: EdgeInsets.only(top: 5),
                                          padding: EdgeInsets.all(10),
                                          // child: Text(
                                          //   "10",
                                          //   style: TextStyle(
                                          //       fontSize: 16,
                                          //       fontWeight: FontWeight.w800),
                                          //   textAlign: TextAlign.left,
                                          // ),
                                          child: TextFormField(
                                            controller: focController,
                                            keyboardType: TextInputType
                                                .numberWithOptions(),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Container(
                                          margin: EdgeInsets.only(top: 5),
                                          padding: EdgeInsets.all(10),
                                          // child: Text(
                                          //   "10",
                                          //   style: TextStyle(
                                          //       fontSize: 16,
                                          //       fontWeight: FontWeight.w800),
                                          //   textAlign: TextAlign.left,
                                          // ),
                                          child: TextFormField(
                                              controller: extraFocController,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (quantityController.text == '' ||
                                            quantityController.text == null) {
                                          final snackBar = SnackBar(
                                            content: const Text(
                                                'Please enter quantity'),
                                            action: SnackBarAction(
                                              label: '',
                                              onPressed: () {},
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else if (focController.text == '' ||
                                            focController.text == null) {
                                          final snackBar = SnackBar(
                                            content:
                                                const Text('Please enter FOC'),
                                            action: SnackBarAction(
                                              label: '',
                                              onPressed: () {},
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else if (extraFocController.text ==
                                                '' ||
                                            extraFocController.text == null) {
                                          final snackBar = SnackBar(
                                            content: const Text(
                                                'Please enter EXFoc'),
                                            action: SnackBarAction(
                                              label: '',
                                              onPressed: () {},
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else {
                                          addToCart(
                                              context,
                                              customerBranchId,
                                              widget.itemDetails.itemid,
                                              iteminfo[0].minretailprice,
                                              quantityController.text,
                                              focController.text,
                                              extraFocController.text,
                                              "0",
                                              branchId,
                                              1000,
                                              1000.00,
                                              "Bundle",
                                              1000.00,
                                              1000.00,
                                              1000.00,
                                              "FMEAPP");
                                        }
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             CartPage()));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Add to Cart",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewPastOrder()));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4.5,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "View Order History",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 30),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Item Code - ${widget.itemDetails.itemid} \nItem name - ${widget.itemDetails.itemproductgrouptitle} \nType of Packing - Expiry\nQty Per packing - 1",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Short Description",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            // iteminfo[0].shortdescription,
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Content Description",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            // iteminfo[0].description,
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Content Description",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return DetailPageShimmer();
                }
                return DetailPageShimmer();
              },
            );
          } else if (deviceInfo.deviceTypeInformation ==
              DeviceTypeInformation.MOBILE) {
            return FutureBuilder(
              future: fetchProductInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Salesmandetailpage> iteminfo = snapshot.data;
                  return SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: 'https://onlinefamilypharmacy.com/images/item/${widget.itemDetails.img}' ==
                                'https://onlinefamilypharmacy.com/images/item/null'
                            ? Image.network(
                                'https://onlinefamilypharmacy.com/images/noimage.jpg')
                            : Image.network(
                                'https://onlinefamilypharmacy.com/images/item/${widget.itemDetails.img}'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        // alignment: Alignment.centerLeft,
                        // width: MediaQuery.of(context).size.width -
                        //     MediaQuery.of(context).size.width / 2.5,
                        // height: MediaQuery.of(context).size.height / 1,
                        // color: Colors.yellow,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              iteminfo[0].itemproductgrouptitle,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Manufacturer - FMC",
                                // + iteminfo[0].manufactureshortname,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "\QR ${iteminfo[0].minretailprice}" +
                                        "-" +
                                        "\QR ${iteminfo[0].maxretailprice}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.orange),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 60),
                                  child: Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.checkCircle,
                                        color: Colors.green,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "5 in Stock",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
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
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Select Variant",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 90.0),
                                  child: Text(
                                    "Select Units",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 3),
                                    padding: EdgeInsets.all(10),
                                    // child: Text(
                                    //   "Expiry",
                                    //   style: TextStyle(
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w800),
                                    //   textAlign: TextAlign.left,
                                    // ),
                                    child: DropdownButton(
                                      underline: SizedBox(),
                                      value: selectedVariant,
                                      hint: Text("Variants"),
                                      items: variants.map(
                                        (list) {
                                          return DropdownMenuItem(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    12,
                                                child: Text(
                                                  list['itempack'],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              value: list['id']);
                                        },
                                      ).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedVariant = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.only(right: 10),
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 2),
                                    padding: EdgeInsets.all(10),
                                    child: DropdownButton(
                                      underline: SizedBox(),
                                      value: selectedVariant,
                                      hint: Text("Select Unit"),
                                      items: units.map(
                                        (list) {
                                          return DropdownMenuItem(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        12 +
                                                    18,
                                                child: Text(
                                                  list['unit'] == null
                                                      ? 'No Unit'
                                                      : list['unit'],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              value: list['id']);
                                        },
                                      ).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedUnit = value;
                                        });
                                      },
                                    ),
                                  ),
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
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Qty",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 45),
                                  child: Text(
                                    "Alloc FOC",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 40),
                                  child: Text(
                                    "Extra FOC",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
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
                                  width: MediaQuery.of(context).size.width / 4,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5),
                                    padding: EdgeInsets.all(10),
                                    // child: Text(
                                    //   "10",
                                    //   style: TextStyle(
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w800),
                                    //   textAlign: TextAlign.left,
                                    // ),
                                    child: TextFormField(
                                      controller: quantityController,
                                      keyboardType:
                                          TextInputType.numberWithOptions(),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width / 4,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5),
                                    padding: EdgeInsets.all(10),
                                    // child: Text(
                                    //   "10",
                                    //   style: TextStyle(
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w800),
                                    //   textAlign: TextAlign.left,
                                    // ),
                                    child: TextFormField(
                                      controller: focController,
                                      keyboardType:
                                          TextInputType.numberWithOptions(),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width / 4,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5),
                                    padding: EdgeInsets.all(10),
                                    // child: Text(
                                    //   "10",
                                    //   style: TextStyle(
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w800),
                                    //   textAlign: TextAlign.left,
                                    // ),
                                    child: TextFormField(
                                        controller: extraFocController,
                                        keyboardType:
                                            TextInputType.numberWithOptions(),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        )),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (quantityController.text == '' ||
                                        quantityController.text == null) {
                                      final snackBar = SnackBar(
                                        content:
                                            const Text('Please Enter Quantity'),
                                        action: SnackBarAction(
                                          label: '',
                                          onPressed: () {},
                                        ),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else if (focController.text == '' ||
                                        focController.text == null) {
                                      final snackBar = SnackBar(
                                        content: const Text('Please Enter FOC'),
                                        action: SnackBarAction(
                                          label: '',
                                          onPressed: () {},
                                        ),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else if (extraFocController.text == '' ||
                                        extraFocController.text == null) {
                                      final snackBar = SnackBar(
                                        content: const Text(
                                            'Please Enter extra Foc '),
                                        action: SnackBarAction(
                                          label: '',
                                          onPressed: () {},
                                        ),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      addToCart(
                                          context,
                                          customerBranchId,
                                          widget.itemDetails.itemid,
                                          iteminfo[0].minretailprice,
                                          quantityController.text,
                                          focController.text,
                                          extraFocController.text,
                                          "0",
                                          branchId,
                                          1000,
                                          1000.00,
                                          "Bundle",
                                          1000.00,
                                          1000.00,
                                          1000.00,
                                          "FMEAPP");
                                    }

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => CartPage()));
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewPastOrder()));
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "View Order History",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
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
                                child: Text(
                                  "Item Code - ${widget.itemDetails.itemid} \nItem name - ${widget.itemDetails.itemproductgrouptitle} \nType of Packing - Expiry\nQty Per packing - 1",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Short Description",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            // iteminfo[0].shortdescription,
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Content Description",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            // iteminfo[0].description,
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return DetailPageShimmer();
                }
                return DetailPageShimmer();
              },
            );
          }
          return Center(
            child: Text("Not Compatible"),
          );
        },
      ),
    );
  }
}
