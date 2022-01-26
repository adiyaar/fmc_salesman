import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:responsify/responsify.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:testing/Apis/AddToCart.dart';
import 'package:testing/Common/DetailShimmer.dart';
import 'package:testing/models/CartItem.dart';

import 'package:testing/models/DetailPageModel.dart';
import 'package:http/http.dart' as http;
import 'package:testing/screens/ViewPastOrder.dart';

import 'CartPage.dart';

class DetailPageScreen extends StatefulWidget {
  final customerType;
  final itemDetails;
  List userInfo;
  DetailPageScreen(
      {Key key, @required this.itemDetails, this.customerType, this.userInfo})
      : super(key: key);

  @override
  _DetailPageScreenState createState() => _DetailPageScreenState();
}

class _DetailPageScreenState extends State<DetailPageScreen> {
  String customerType, customerBranchId, branchId;
  String employeeWhichCompany;
  void customerInfo() async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    customerBranchId = pf.getString('customerId');
    branchId = pf.getString('branchId');
    customerType = pf.getString('cust_type');
  }

  List variants = [];
  List units = [];
  List<VariantsD> a = [];
  List<UnitsD> b = [];

  List<PriceSetting> priceSetting = [];
  List<PriceSettingCutoff> priceSettingCutoff = [];
  String selectedVariant;
  double wacCost = 0.0;
  double managementCost = 0.0;
  double calculatedCost = 0.0;
  String selectedVariantName = '';
  String packing = '';
  String packingunit = '';
  String selectedUnit;
  String selectedUnitName = '';

  String price;

  TextEditingController quantityController =
      TextEditingController(text: '1'); // quantity
  TextEditingController focController = TextEditingController(text: '0'); // foc
  TextEditingController extraFocController =
      TextEditingController(text: '0'); // extra foc

  Future<List<Salesmandetailpage>> fetchProductInfo() async {
    final baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmandetailpage.php';
    var data = {'itemproductgroupid': widget.itemDetails.itemproductgroupid};

    print(data);
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
            'https://onlinefamilypharmacy.com/mobileapplication/pages/selectvariant.php'),
        body: json.encode(data));
    var jsonResponse = response.body;
    List jsonData = json.decode(jsonResponse);
    a = jsonData.map((e) => VariantsD.fromJson(e)).toList();

    setState(() {
      variants = jsonData;
    });

    return a;
  }

  Future getPriceSettingPhp(String type, String itemCompany) async {
    // employee company
    // employee branch
    // item MohPrice - 0 - moh || 1 - Non-Moh

    var data = {
      'branch': widget.userInfo[0].workingin,
      'company': itemCompany,
      'type': type,
    };
    print(data);
    String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/pages/pricesetting.php';

    var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));
    List jsondataval = json.decode(response.body);
    print("!111");
    print(jsondataval);
    priceSetting = jsondataval.map((e) => PriceSetting.fromJson(e)).toList();

    return priceSetting;
  }

  Future getPriceSettingPhpCutOff(String type, String itemCompany) async {
    var data = {
      'branch': widget.userInfo[0].workingin,
      'company': itemCompany,
      'type': type,
    };

    String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/pages/pricesetting_cutofprice.php';

    var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));
    List jsondataval = json.decode(response.body);
    priceSettingCutoff =
        jsondataval.map((e) => PriceSettingCutoff.fromJson(e)).toList();

    return priceSettingCutoff;
  }

  Future getUnitsandPrice(itemid) async {
    String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/pages/selectunit.php';

    var data = {'itemid': itemid};
    var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));
    List jsondataval = json.decode(response.body);
    b = jsondataval.map((e) => UnitsD.fromJson(e)).toList();
    // print('2');

    setState(() {
      units = jsondataval;
    });
    return b;
  }

  int a1;
  Future fetchCrtCOunt() async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    String customerId = pf.getString('customerId');
    String branchId = pf.get('branchId');
    Map<String, dynamic> data = {
      'userid': customerId,
      'selectedcustbranch': branchId
    };
    String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesman_cart.php';
    var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    // print(jsonResponse);

    a1 = jsonResponse.length;
    setState(() {});
    return a1;
  }

  @override
  void initState() {
    super.initState();
    // fetchProductInfo();
    getVariant();
    employeeWhichCompany = widget.userInfo[0].employeeCompany;
    fetchCrtCOunt();
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
              "${widget.userInfo[0].username} \n${widget.userInfo[0].workingin}",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          IconButton(
            icon: Icon(Icons.person_sharp),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart_outlined),
                tooltip: 'MainGroup',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartPage(
                                useriNfo: widget.userInfo,
                              )));
                },
              ),
              CircleAvatar(
                radius: 9,
                backgroundColor: Colors.yellow,
                child: Visibility(
                  visible: a != null,
                  child: Text(
                    '$a1',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
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
                  print("========");
                  print(iteminfo[0].mohprice);
                  if (iteminfo[0].mohprice == "1") {
                    getPriceSettingPhp("MOH", iteminfo[0].whichcompany);
                    getPriceSettingPhpCutOff("MOH", iteminfo[0].whichcompany);
                  } else {
                    getPriceSettingPhp("NONMOH", iteminfo[0].whichcompany);
                    getPriceSettingPhpCutOff(
                        "NONMOH", iteminfo[0].whichcompany);
                  }

                  Future.delayed(Duration(seconds: 1), () {
                    managementCost = (double.parse(iteminfo[0].wacCost) /
                        (1 - double.parse(priceSetting[0].margin)));
                    print("object");
                    print(priceSettingCutoff[0].realmargincost);

                    double a =
                        (double.parse(priceSettingCutoff[0].realmargincost)) /
                            100;
                    print(a);
                    double x = 1 - a;
                    print(managementCost);
                    print(x);

                    calculatedCost = (managementCost / x).roundToDouble();
                    print(calculatedCost);
                    // ((double.parse(iteminfo[0].wholeSalePrice) -
                    //             double.parse(iteminfo[0].wacCost)) *
                    //         double.parse(
                    //             priceSettingCutoff[0].bonuspercentage) /
                    //         100)
                  });
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
                                Visibility(
                                  visible: selectedUnitName == '',
                                  child: Container(
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
                                ),
                                Visibility(
                                  visible: selectedUnitName != '',
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      calculatedCost >=
                                              double.parse(
                                                  iteminfo[0].wholeSalePrice)
                                          ? "\QR $selectedUnitName"
                                          : "\QR ${iteminfo[0].wholeSalePrice}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                          color: Colors.green),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
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
                                                        list['itempack'] == ''
                                                            ? 'No Variant'
                                                            : list['itempack'],
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

                                                selectedVariantName = a
                                                    .where((element) =>
                                                        element.id ==
                                                        selectedVariant)
                                                    .map((e) => e.itempack)
                                                    .first;
                                                getUnitsandPrice(
                                                    selectedVariant);
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
                                            value: selectedUnit,
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
                                                // price ==>
                                                (customerType == null ||
                                                        customerType ==
                                                            'Retail')
                                                    ? selectedUnitName = b
                                                        .where((element) =>
                                                            element.id ==
                                                            selectedUnit)
                                                        .map((e) => e.rss)
                                                        .first
                                                        .toString()
                                                    : selectedUnitName = b
                                                        .where((element) =>
                                                            element.id ==
                                                            selectedUnit)
                                                        .map((e) => e.wss)
                                                        .first
                                                        .toString();

                                                //type of packagin
                                                packing = b
                                                    .where((element) =>
                                                        element.id ==
                                                        selectedUnit)
                                                    .map((e) => e.packing)
                                                    .first
                                                    .toString();

                                                packingunit = b
                                                    .where((element) =>
                                                        element.id ==
                                                        selectedUnit)
                                                    .map((e) => e.unit)
                                                    .first
                                                    .toString();
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
                                                (employeeWhichCompany
                                                                .trim()
                                                                .toLowerCase() ==
                                                            "fme" &&
                                                        iteminfo[0]
                                                                .whichcompany
                                                                .trim()
                                                                .toLowerCase() ==
                                                            "fme" &&
                                                        customerType
                                                                .toLowerCase() ==
                                                            "wholesale")
                                                    ? addToCart(
                                                        context,
                                                        customerBranchId,
                                                        widget
                                                            .itemDetails.itemid,
                                                        iteminfo[0]
                                                            .wholeSalePrice,
                                                        quantityController.text,
                                                        focController.text,
                                                        extraFocController.text,
                                                        "0",
                                                        branchId,
                                                        int.parse(packing),
                                                        double.parse(iteminfo[0]
                                                            .wacCost),
                                                        packingunit,
                                                        managementCost,
                                                        calculatedCost,
                                                        1000.00,
                                                        iteminfo[0]
                                                            .whichcompany)
                                                    : addToCart(
                                                        context,
                                                        customerBranchId,
                                                        widget
                                                            .itemDetails.itemid,
                                                        iteminfo[0]
                                                            .minretailprice,
                                                        quantityController.text,
                                                        focController.text,
                                                        extraFocController.text,
                                                        "0",
                                                        branchId,
                                                        int.parse(packing),
                                                        double.parse(iteminfo[0]
                                                            .wacCost),
                                                        packingunit,
                                                        managementCost,
                                                        calculatedCost,
                                                        1000.00,
                                                        iteminfo[0]
                                                            .whichcompany);
                                                Future.delayed(
                                                    Duration(seconds: 5), () {
                                                  fetchCrtCOunt();
                                                });
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
                                  height: 2,
                                ),
                                selectedVariant == null
                                    ? Container(
                                        margin: EdgeInsets.only(left: 10),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Item Code - ${widget.itemDetails.itemid} \nItem name - ${widget.itemDetails.itemproductgrouptitle} \nType of Packing - ''\nQty Per packing - 1\nSelected Variant -$selectedVariantName",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ))
                                    : Container(
                                        margin: EdgeInsets.only(left: 10),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Item Code - $selectedVariant \nItem name - ${widget.itemDetails.itemproductgrouptitle} \nQty of Packing - $packingunit\nType Per packing - $packing\nSelected Variant -$selectedVariantName",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        )),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Max Retail Price - ${iteminfo[0].maxretailprice}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              'Max Wholesale Price - ${iteminfo[0].wholeSalePrice}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              'Selected Variant Price-- ${selectedUnitName}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              'Product Which Company - ${iteminfo[0].whichcompany}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              'WAC Cost -  ${iteminfo[0].wacCost}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              'Management COST $managementCost',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              'Cutoff COST $calculatedCost',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              'MOH Price ${iteminfo[0].mohprice}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              'Salesman Which Company -  ${widget.userInfo[0].employeeCompany}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              'Packing Qty -  $packing',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ]),
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
                  print("========");
                  print(iteminfo[0].mohprice);
                  if (iteminfo[0].mohprice == "1") {
                    getPriceSettingPhp("MOH", iteminfo[0].whichcompany);
                    getPriceSettingPhpCutOff("MOH", iteminfo[0].whichcompany);
                  } else {
                    getPriceSettingPhp("NONMOH", iteminfo[0].whichcompany);
                    getPriceSettingPhpCutOff(
                        "NONMOH", iteminfo[0].whichcompany);
                  }

                  Future.delayed(Duration(seconds: 1), () {
                    managementCost = (double.parse(iteminfo[0].wacCost) /
                        (1 - double.parse(priceSetting[0].margin)));
                    print("object");
                    print(priceSettingCutoff[0].realmargincost);

                    double a =
                        (double.parse(priceSettingCutoff[0].realmargincost)) /
                            100;
                    print(a);
                    double x = 1 - a;
                    print(managementCost);
                    print(x);

                    calculatedCost = (managementCost / x).roundToDouble();
                    print(calculatedCost);
                  });
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
                                Visibility(
                                  visible: selectedUnitName == '',
                                  child: Container(
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
                                ),
                                Visibility(
                                  visible: selectedUnitName != '',
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      calculatedCost >=
                                              double.parse(
                                                  iteminfo[0].wholeSalePrice)
                                          ? "\QR $selectedUnitName"
                                          : "\QR ${iteminfo[0].wholeSalePrice}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                          color: Colors.green),
                                    ),
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
                                                        list['itempack'] == ''
                                                            ? 'No Variant'
                                                            : list['itempack'],
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

                                                selectedVariantName = a
                                                    .where((element) =>
                                                        element.id ==
                                                        selectedVariant)
                                                    .map((e) => e.itempack)
                                                    .first;
                                                getUnitsandPrice(
                                                    selectedVariant);
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
                                            value: selectedUnit,
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
                                                // price ==>
                                                (customerType == null ||
                                                        customerType ==
                                                            'Retail')
                                                    ? selectedUnitName = b
                                                        .where((element) =>
                                                            element.id ==
                                                            selectedUnit)
                                                        .map((e) => e.rss)
                                                        .first
                                                        .toString()
                                                    : selectedUnitName = b
                                                        .where((element) =>
                                                            element.id ==
                                                            selectedUnit)
                                                        .map((e) => e.wss)
                                                        .first
                                                        .toString();

                                                //type of packagin
                                                packing = b
                                                    .where((element) =>
                                                        element.id ==
                                                        selectedUnit)
                                                    .map((e) => e.unit)
                                                    .first
                                                    .toString();

                                                packingunit = b
                                                    .where((element) =>
                                                        element.id ==
                                                        selectedUnit)
                                                    .map((e) => e.unit)
                                                    .first
                                                    .toString();
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
                                          (employeeWhichCompany
                                                          .trim()
                                                          .toLowerCase() ==
                                                      "fme" &&
                                                  iteminfo[0]
                                                          .whichcompany
                                                          .trim()
                                                          .toLowerCase() ==
                                                      "fme" &&
                                                  customerType.toLowerCase() ==
                                                      "wholesale")
                                              ? addToCart(
                                                  context,
                                                  customerBranchId,
                                                  widget.itemDetails.itemid,
                                                  iteminfo[0].wholeSalePrice,
                                                  quantityController.text,
                                                  focController.text,
                                                  extraFocController.text,
                                                  "0",
                                                  branchId,
                                                  int.parse(packing),
                                                  double.parse(
                                                      iteminfo[0].wacCost),
                                                  packingunit,
                                                  managementCost,
                                                  calculatedCost,
                                                  1000.00,
                                                  iteminfo[0].whichcompany)
                                              : addToCart(
                                                  context,
                                                  customerBranchId,
                                                  widget.itemDetails.itemid,
                                                  iteminfo[0].minretailprice,
                                                  quantityController.text,
                                                  focController.text,
                                                  extraFocController.text,
                                                  "0",
                                                  branchId,
                                                  int.parse(packing),
                                                  double.parse(
                                                      iteminfo[0].wacCost),
                                                  packingunit,
                                                  managementCost,
                                                  calculatedCost,
                                                  1000.00,
                                                  iteminfo[0].whichcompany);
                                          Future.delayed(Duration(seconds: 5),
                                              () {
                                            print(
                                                " This line is execute after 5 seconds");
                                            fetchCrtCOunt();
                                          });
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
                                selectedVariant == null
                                    ? Container(
                                        margin: EdgeInsets.only(left: 30),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Item Code - ${widget.itemDetails.itemid} \nItem name - ${widget.itemDetails.itemproductgrouptitle} \nType of Packing - ''\nQty Per packing - 1\nSelected Variant -$selectedVariantName",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ))
                                    : Container(
                                        margin: EdgeInsets.only(left: 30),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Item Code - $selectedVariant \nItem name - ${widget.itemDetails.itemproductgrouptitle} \nQty of Packing - $packingunit\nType Per packing - $packing\nSelected Variant -$selectedVariantName",
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
                      Text('Vital Info'),
                      Text(
                        'Max Retail Price - ${iteminfo[0].maxretailprice}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        'Max Wholesale Price - ${iteminfo[0].wholeSalePrice}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        'Selected Variant Price-- ${selectedUnitName}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        'Product Which Company - ${iteminfo[0].whichcompany}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        'WAC Cost -  ${iteminfo[0].wacCost}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        'Management COST $managementCost',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        'Cutoff COST $calculatedCost',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        'Salesman Which Company -  ${widget.userInfo[0].employeeCompany}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        'Packing Qty -  $packing',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
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
                  print("========");
                  print(iteminfo[0].mohprice);
                  if (iteminfo[0].mohprice == "1") {
                    getPriceSettingPhp("MOH", iteminfo[0].whichcompany);
                    getPriceSettingPhpCutOff("MOH", iteminfo[0].whichcompany);
                  } else {
                    getPriceSettingPhp("NONMOH", iteminfo[0].whichcompany);
                    getPriceSettingPhpCutOff(
                        "NONMOH", iteminfo[0].whichcompany);
                  }

                  Future.delayed(Duration(seconds: 1), () {
                    String temp = (double.parse(iteminfo[0].wacCost) /
                            (1 - double.parse(priceSetting[0].margin) / 100))
                        .toStringAsFixed(2);
                    managementCost = double.parse(temp);
                    print("object");
                    print(double.parse(iteminfo[0].wacCost));
                    print(priceSettingCutoff[0].realmargincost);

                    double a =
                        (double.parse(priceSettingCutoff[0].realmargincost)) /
                            100;
                    print(a);
                    double x = 1 - a;
                    print(managementCost);
                    print(x);
                    String temp2 = (managementCost / x).toStringAsFixed(2);
                    calculatedCost = double.parse(temp2);
                    print(calculatedCost);
                    // ((double.parse(iteminfo[0].wholeSalePrice) -
                    //             double.parse(iteminfo[0].wacCost)) *
                    //         double.parse(
                    //             priceSettingCutoff[0].bonuspercentage) /
                    //         100)
                  });
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
                                Visibility(
                                  visible: selectedUnitName == '',
                                  child: Container(
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
                                ),
                                Visibility(
                                  visible: selectedUnitName != '',
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      calculatedCost >=
                                              double.parse(
                                                  iteminfo[0].wholeSalePrice)
                                          ? "\QR $selectedUnitName"
                                          : "\QR ${iteminfo[0].wholeSalePrice}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                          color: Colors.green),
                                    ),
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
                            SizedBox(height: 10),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 1.1,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12.0)),
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
                                                1.3,
                                            child: Text(
                                              list['itempack'] == ''
                                                  ? 'No Variant'
                                                  : list['itempack'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          value: list['id']);
                                    },
                                  ).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedVariant = value;

                                      selectedVariantName = a
                                          .where((element) =>
                                              element.id == selectedVariant)
                                          .map((e) => e.itempack)
                                          .first;
                                      getUnitsandPrice(selectedVariant);
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
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
                            SizedBox(height: 10),
                            Container(
                              height: 50,
                              margin: EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width / 1.1,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Container(
                                margin: EdgeInsets.only(top: 2),
                                padding: EdgeInsets.all(10),
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  value: selectedUnit,
                                  hint: Text("Select Unit"),
                                  items: units.map(
                                    (list) {
                                      return DropdownMenuItem(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.3,
                                            child: Text(
                                              list['unit'] == null ||
                                                      list['unit'] == 0
                                                  ? 'No Unit'
                                                  : list['unit'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          value: list['id']);
                                    },
                                  ).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedUnit = value;
                                      // price ==>
                                      (customerType == null ||
                                              customerType == 'Retail')
                                          ? selectedUnitName = b
                                              .where((element) =>
                                                  element.id == selectedUnit)
                                              .map((e) => e.rss)
                                              .first
                                              .toString()
                                          : selectedUnitName = b
                                              .where((element) =>
                                                  element.id == selectedUnit)
                                              .map((e) => e.wss)
                                              .first
                                              .toString();

                                      //type of packagin
                                      packing = b
                                          .where((element) =>
                                              element.id == selectedUnit)
                                          .map((e) => e.packing)
                                          .first
                                          .toString();
                                      packingunit = b
                                          .where((element) =>
                                              element.id == selectedUnit)
                                          .map((e) => e.unit)
                                          .first
                                          .toString();
                                    });
                                  },
                                ),
                              ),
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
                                      print(calculatedCost);
                                      print("her");
                                      (employeeWhichCompany
                                                      .trim()
                                                      .toLowerCase() ==
                                                  "fme" &&
                                              iteminfo[0]
                                                      .whichcompany
                                                      .trim()
                                                      .toLowerCase() ==
                                                  "fme" &&
                                              customerType.toLowerCase() ==
                                                  "wholesale")
                                          ? addToCart(
                                              context,
                                              customerBranchId,
                                              widget.itemDetails.itemid,
                                              iteminfo[0].wholeSalePrice,
                                              quantityController.text,
                                              focController.text,
                                              extraFocController.text,
                                              "0",
                                              branchId,
                                              int.parse(packing),
                                              double.parse(iteminfo[0].wacCost),
                                              packingunit,
                                              managementCost,
                                              calculatedCost,
                                              1000.00,
                                              iteminfo[0].whichcompany)
                                          : addToCart(
                                              context,
                                              customerBranchId,
                                              widget.itemDetails.itemid,
                                              iteminfo[0].minretailprice,
                                              quantityController.text,
                                              focController.text,
                                              extraFocController.text,
                                              "0",
                                              branchId,
                                              int.parse(packing),
                                              double.parse(iteminfo[0].wacCost),
                                              packingunit,
                                              managementCost,
                                              calculatedCost,
                                              1000.00,
                                              iteminfo[0].whichcompany);
                                      Future.delayed(Duration(seconds: 5), () {
                                        fetchCrtCOunt();
                                      });
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
                            selectedVariant == null
                                ? Container(
                                    // margin: EdgeInsets.only(left: 30),
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Item Code - ${widget.itemDetails.itemid} \nItem name - ${widget.itemDetails.itemproductgrouptitle} \nType of Packing - ''\nQty Per packing - 1\nSelected Variant -$selectedVariantName",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          'Max Retail Price - ${iteminfo[0].maxretailprice}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Max Wholesale Price - ${iteminfo[0].wholeSalePrice}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Selected Variant Price-- $selectedUnitName',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Product Which Company - ${iteminfo[0].whichcompany}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'WAC Cost -  ${iteminfo[0].wacCost}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Management COST $managementCost',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Cutoff COST $calculatedCost',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Salesman Which Company -  ${widget.userInfo[0].employeeCompany}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Packing Qty -  $packing',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ))
                                : Container(

                                    // margin: EdgeInsets.only(left: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Item Code - $selectedVariant \nItem name - ${widget.itemDetails.itemproductgrouptitle} \nQty of Packing - $packing\nType Per packing - $packingunit\nSelected Variant -$selectedVariantName",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          'Max Retail Price - ${iteminfo[0].maxretailprice}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Max Wholesale Price - ${iteminfo[0].wholeSalePrice}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Selected Variant Price-- ${selectedUnitName}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Product Which Company - ${iteminfo[0].whichcompany}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'WAC Cost -  ${iteminfo[0].wacCost}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Management COST $managementCost',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Cutoff COST $calculatedCost',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Salesman Which Company -  ${widget.userInfo[0].employeeCompany}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Packing Qty -  $packing',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ],
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
