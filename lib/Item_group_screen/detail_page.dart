import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:fmc_salesman/Item_group_screen/salesorder_history.dart';
import 'package:fmc_salesman/Sales_Order/generate_sales_order.dart';
import 'package:fmc_salesman/home/cart.dart';
import 'package:fmc_salesman/home/home_slider.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:share/share.dart';

String? selectedcustbranch;
getStringValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  selectedcustbranch = prefs.getString('selectedcustbranch');
}

class ListDetails extends StatefulWidget {
  // final todo, invoiceprice;
  final todo, invoiceprice;

  ListDetails({Key? key, @required this.todo, this.invoiceprice})
      : super(key: key);

  @override
  _ListDetailsState createState() => _ListDetailsState();
}

class _ListDetailsState extends State<ListDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GoogleTranslator translator = GoogleTranslator();
  String? selectedvalue, selecteditemvalue, selectunit;
  String? units;
  String? enitemproductgrouptitle;
  String? description_;
  String? endescription;
  String? addinformation;
  String? enaddinformation;
  String? Description_ = "Description";
  String? shortdesc;
  String? enshortdesc;
  String addDescription_ = "Additional Description";
  double manufacture = 14;
  double itemproductgrouptitle = 19;
  double shortdescription = 13;
  double Description = 15;
  // CarouselController buttonCarouselController = CarouselController();
  List dropdata = [];
  List itemdropdata = [];
  List unit = [];
  String? cart ;
  TextEditingController efocController = TextEditingController(); // extra foc
  TextEditingController quantityController =
      TextEditingController(); // quantity
  TextEditingController discpController =
      TextEditingController(); // discpercentage controller
  TextEditingController alocController =
      TextEditingController(); // alocated foc
  TextEditingController fixedController = TextEditingController(); // fixed foc
  final discController = TextEditingController(); // discount based on currency
  String? itemproductgrouptitle_;
  Future getallvalue() async {
    var data = {'itemproductgroupid': widget.todo.itemproductgroupid};
    var response = await http.post(
        'https://onlinefamilypharmacy.com/mobileapplication/pages/dropdown_api.php',
        body: json.encode(data));
    var jsonbody = response.body;
    var jsondata = json.decode(jsonbody);
    setState(() {
      dropdata = jsondata;
    });
  }

  Future getallitemvalue(item) async {
    var data = {'itemid': item};
    var response = await http.post(
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesman_item_dropdown_api.php',
        body: json.encode(data));
    var jsonbody = response.body;
    var jsondata = json.decode(jsonbody);
    setState(() {
      itemdropdata = jsondata;
    });
  }

  Future getunit(item) async {
    var data = {'itemid': item};
    print("_____________________");
    print(data);
    var response = await http.post(
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesman_item_dropdown_api.php',
        body: json.encode(data));
    print("Get unit item");

    var jsonbody = response.body;
    var jsondata = json.decode(jsonbody);
    print("___________________________");
    print(jsondata);
    setState(() {
      unit = jsondata;
    });
  }

  Future getUnitVal() async {
    var url =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesman_item_dropdown_api.php';
    var data = {'itemid': selectunit};
    print(data);
    var response = await http.post(url, body: json.encode(data));
    print("Get unit val");
    print(response);

    var jsondataval = json.decode(response.body);

    return jsondataval;
  }

  Future getselectedvalue() async {
    var url =
        'https://onlinefamilypharmacy.com/mobileapplication/pages/dropdown.php';
    var data = {'id': selectedvalue};
    var response = await http.post(url, body: json.encode(data));
    var jsondataval = json.decode(response.body);
    print(jsondataval);
    return jsondataval;
  }

  Future getselecteditemvalue() async {
    var url =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesman_dropdown_item.php';
    var data = {'id': selecteditemvalue};
    var response = await http.post(url, body: json.encode(data));
    var jsondataval = json.decode(response.body);
    return jsondataval;
  }

  double? finalapricedata;
  bool visible = false;
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String? cust_id = prefs.getString('cust_id');
    return cust_id;
  }

  getvalues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? invoiceprice;
    invoiceprice = prefs.getString('invoiceprice');
    selectedcustbranch = prefs.getString('selectedcustbranch');
    return selectedcustbranch;
  }

  Future addtocart() async {


    if(alocController.text == '' || efocController.text == '' || quantityController.text == '' || units == '' || selectedvalue == '')
      {

        final snackBar = SnackBar(
          content: Text('Please Fill All The Details!'),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else{
      int foc = int.parse(alocController.text); // allocated foc
      int ex_foc = int.parse(efocController.text); // extra foc
      int quantity =
      int.parse(quantityController.text); // quantity entered by user
      int disc = 0;
      print(quantityController.text);
      print(finalapricedata);
      double totalitem = double.parse(quantityController.text) * dropprice;
      dynamic token = await getStringValues();
      dynamic branch = await getvalues();
      if (token == null && branch == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Generate_Sales()));
      } else {
        var url =
            'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesmanaddtocart.php';
        if (selectedvalue == null) {
          setState(() {
            finalapricedata = finalprice;
          });
        } else {
          print(dropprice);
          finalapricedata = dropprice;
          print(finalapricedata);
        }
        var data = {
          'user_id': token,
          'itemid': itemid,
          'price': widget.todo.maxretailprice,
          // 'finalprice': finalprice,
          'quantity': quantity,
          'foc': foc,
          'ex_foc': ex_foc,
          'disc': 0,
          'selectedcustbranch': selectedcustbranch,
        };

        // Starting Web API Call.
        print("Data printing");
        var response = await http.post(url, body: json.encode(data));
        print(response.body.toString());
        if(response.body.toString().contains("Added to Cart"))
        {
          final snackBar = SnackBar(
            content: Text('Added to Cart'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else{
          final snackBar = SnackBar(
            content: Text('Already Added to Cart'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

    }


      // print(jsonDecode(response.body));
      // Getting Server response into variable.
      // var message = jsonDecode(response.body);
      // showInSnackBar(message);
      // SweetAlert.show(context, title:message,confirmButtonColor:LightColor.midnightBlue, );
    }
  }

  double? dropprice;
  int? itemid;
  int? counter;
  //final productprice;
  double? finalprice;
  double? prices;

  void increment() {
    if (selectedvalue == null) {
      setState(() {
        counter++;
        finalprice = double.parse(widget.todo.maxretailprice) * counter!;
      });
    } else {
      setState(() {
        counter++;
        dropprice = prices * counter!;
      });
    }
  }

  void decrement() {
    if (selectedvalue == null) {
      setState(() {
        counter--;
        finalprice = double.parse(widget.todo.maxretailprice) * counter;
      });
    } else {
      setState(() {
        counter--;
        dropprice = prices * counter;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    itemid = int.parse(widget.todo.itemid);
    getallvalue();
    getallitemvalue(itemid);
    getunit(itemid);
    getStringValues();
    // finalprice = double.parse(widget.todo.maxretailprice);
    counter = 1;
    itemproductgrouptitle_ = widget.todo.itemproductgrouptitle;
    enitemproductgrouptitle = widget.todo.itemproductgrouptitle;
    enaddinformation = widget.todo.additionalinformation;
    description_ = widget.todo.description;
    endescription = widget.todo.description;
    addinformation = widget.todo.additionalinformation;
    shortdesc = widget.todo.shortdescription;
    enshortdesc = widget.todo.shortdescription;
  }

  Future<List<SalesOrderData>> _fetchSalesOrderData() async {
    var data = {'itemid': itemid};

    var jobsListAPIUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesorder_item.php';
    var response = await http.post(jobsListAPIUrl, body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((job) => new SalesOrderData.fromJson(job))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  void changeFontSize(value) async {
    var val = value;
    if (val == 2) {
      setState(() {
        manufacture = 18;
        itemproductgrouptitle = 23;
        shortdescription = 17;
        Description = 19;
      });
    } else if (val == 3) {
      setState(() {
        manufacture = 10;
        itemproductgrouptitle = 15;
        shortdescription = 9;
        Description = 11;
      });
    } else {
      setState(() {
        manufacture = 14;
        itemproductgrouptitle = 19;
        shortdescription = 13;
        Description = 15;
      });
    }
  }

  String text = 'hi';
  void translate(value) {
    var val = value;
    if (val == 1) {
      translator.translate(itemproductgrouptitle_, to: "ar").then((output) {
        setState(() {
          itemproductgrouptitle_ = output.toString();
        });
      });
      translator.translate(Description_, to: "ar").then((output) {
        setState(() {
          Description_ = output.toString();
        });
      });
      translator.translate(addDescription_, to: "ar").then((output) {
        setState(() {
          addDescription_ = output.toString();
        });
      });
      translator.translate(description_, to: "ar").then((output) {
        setState(() {
          description_ = output.toString();
        });
      });
      translator.translate(addinformation, to: "ar").then((output) {
        setState(() {
          addinformation = output.toString();
        });
      });
      translator.translate(shortdesc, to: "ar").then((output) {
        setState(() {
          shortdesc = output.toString();
        });
      });
    } else {
      setState(() {
        itemproductgrouptitle_ = enitemproductgrouptitle;
        Description_ = "Description";
        addDescription_ = "Additional Description";
        description_ = endescription;
        addinformation = enaddinformation;
        shortdesc = enshortdesc;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //List<int> sizeList = [7, 8, 9, 10];
    Color cyan = Color(0xff37d6ba);
    //List<Color> colorsList = [Colors.black, Colors.blue, Colors.red];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    int itemCount = 0;
    var _value;
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: LightColor.yellowColor,
      appBar: AppBar(
        title: Text(itemproductgrouptitle_.toString()),
        backgroundColor: Colors.black,
        actions: <Widget>[
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text("Default"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("Large"),
              ),
              PopupMenuItem(
                value: 3,
                child: Text("Small"),
              ),
            ],
            onSelected: (value) {
              setState(() {
                _value = value;
                changeFontSize(value);
              });
            },
            icon: ImageIcon(AssetImage('assets/font.png'),
                // size: 50,
                color: LightColor.whiteColor),
          ),
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text("Arabic"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("English"),
              ),
            ],
            onSelected: (value) {
              setState(() {
                _value = value;
                translate(value);
              });
            },
            icon: ImageIcon(
              AssetImage("assets/arabic.png"),
              // size: 50,
            ),
          ),

          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: LightColor.whiteColor,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart()));
              // do something
            },
          ),
          //),
        ],
        // backgroundColor: LightColor.whiteColor,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: Container(
            child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  //padding: EdgeInsets.only(left: 15, right: 15),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      width < 600
                          ? Column(children: <Widget>[
                              Container(
                                  // padding: EdgeInsets.only(left: 15, right: 15),
                                  height: 300.0,
                                  width: width,
                                  child: Carousel(
                                    images: [
                                      // NetworkImage(
                                      //     'https://onlinefamilypharmacy.com/images/item/' +
                                      //         widget.todo.img),
                                      // NetworkImage(
                                      //     'https://onlinefamilypharmacy.com/images/item/' +
                                      //         widget.todo.img),
                                      NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      NetworkImage(
                                          'https://picsum.photos/200/300'),
                                    ],
                                    dotSize: 6.0,
                                    dotSpacing: 15.0,
                                    dotColor: LightColor.blueColor,
                                    indicatorBgPadding: 5.0,
                                    // dotBgColor: LightColor.whiteColor.withOpacity(0.5),
                                    borderRadius: true,
                                  )),
                              // SizedBox(),

                              /*  Positioned.fill(
                        child: Image.network(
                          widget.todo.url,
                        ),
                      ),*/
                              SizedBox(height: 10),
                              /*  */
                              Container(
                                padding: EdgeInsets.only(left: 5, right: 15),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  itemproductgrouptitle_.toString(),
                                  style: TextStyle(
                                      fontSize: itemproductgrouptitle,
                                      color: LightColor.blueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              // SizedBox(width: 5),
                              /**/
                              // ]),),

                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "\ Manufacture- ${widget.todo.manufactureshortname}",
                                          style: TextStyle(
                                              fontSize: manufacture,
                                              color: LightColor.blueColor),
                                        ),
                                      ),
                                      SizedBox(width: 130),
                                      // IconButton(
                                      //   icon: Icon(
                                      //     Icons.share,
                                      //     size: 30.0,
                                      //   ),
                                      //   onPressed: () {
                                      //     final RenderBox box =
                                      //         context.findRenderObject();
                                      //     Share.share(
                                      //         widget.todo.itemname_en +
                                      //             '\n\n Shop online on Qatar’s Most trusted pharmacy with a wide collection of items ranging from personal care, Baby care, Home care products, Medical equipment & supplements we are the healthcare with best priced deals we offer Home delivery across Qatar.' +
                                      //             '\n\n https://www.onlinefamilypharmacy.com/productdetails.php?code=' +
                                      //             widget.todo.itemid,
                                      //         subject: "this is the subject",
                                      //         sharePositionOrigin:
                                      //             box.localToGlobal(
                                      //                     Offset.zero) &
                                      //                 box.size);
                                      //   },
                                      // ),
                                    ]),
                              ),
                              widget.invoiceprice == null ||
                                      widget.invoiceprice == 'Retail'
                                  ? getprice(widget.todo.maxretailprice,
                                      widget.todo.minretailprice)
                                  : getprice(widget.todo.maxwsprice,
                                      widget.todo.minwsprice),

                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Text(
                                  shortdesc.toString(),
                                  style: TextStyle(
                                      fontSize: shortdescription,
                                      color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              ),
                              SizedBox(height: 10),

                              Container(
                                height: 15,
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Salesorder(
                                                        itemid: widget
                                                            .todo.itemid)));
                                      },
                                      child: Text(
                                        "View Order History",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: LightColor.blueColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ),
                              SizedBox(height: 10),
                            ])
                          : Row(children: <Widget>[
                              Container(
                                  // padding: EdgeInsets.only(left: 15, right: 15),
                                  alignment: Alignment.topLeft,
                                  height: 370.0,
                                  width: 390.0,
                                  child: Carousel(
                                    images: [
                                      NetworkImage(
                                          'https://onlinefamilypharmacy.com/images/item/' +
                                              widget.todo.img),
                                      NetworkImage(
                                          'https://onlinefamilypharmacy.com/images/item/' +
                                              widget.todo.img),
                                      NetworkImage(
                                          'https://onlinefamilypharmacy.com/images/item/' +
                                              widget.todo.img),
                                    ],
                                    dotSize: 6.0,
                                    dotSpacing: 15.0,
                                    dotColor: LightColor.blueColor,
                                    indicatorBgPadding: 5.0,
                                    dotBgColor:
                                        LightColor.whiteColor.withOpacity(0.5),
                                    borderRadius: true,
                                  )),
                              // SizedBox(),

                              /*  Positioned.fill(
                        child: Image.network(
                          widget.todo.url,
                        ),
                      ),*/
                              SizedBox(width: 10),
                              /*  */

                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              itemproductgrouptitle_.toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                      itemproductgrouptitle,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              "\ Manufacture- ${widget.todo.manufactureshortname}",
                                              style: TextStyle(
                                                  fontSize: manufacture,
                                                  color: LightColor.blueColor),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            widget.invoiceprice == null ||
                                                    widget.invoiceprice ==
                                                        'Retail'
                                                ? getprice(
                                                    widget.todo.maxretailprice,
                                                    widget.todo.minretailprice)
                                                : getprice(
                                                    widget.todo.maxwsprice,
                                                    widget.todo.minwsprice),

                                            SizedBox(height: 10),
                                            // Container(
                                            //   padding: EdgeInsets.only(
                                            //       left: 15, right: 15),
                                            //   child: Text(
                                            //     shortdesc.toString(),
                                            //     style: TextStyle(
                                            //         fontSize: shortdescription,
                                            //         color: Colors.grey),
                                            //     overflow: TextOverflow.ellipsis,
                                            //     maxLines: 6,
                                            //   ),
                                            // ),
                                            Row(
                                              children: [
                                                Container(
                                                    width: width / 3.6,
                                                    child: Text(
                                                      "Select Variants",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    )),
                                                SizedBox(
                                                  width: 150.0,
                                                ),
                                                Container(
                                                  width: width / 3.6,
                                                  child: Text("Select The Unit",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),
                                                )
                                              ],
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xfff3f3f4),
                                                    ),
                                                    child: DropdownButton(
                                                      value: selectedvalue,
                                                      hint: Text(
                                                          "Select Variants"),
                                                      items: dropdata.map(
                                                        (list) {
                                                          return DropdownMenuItem(
                                                              child: SizedBox(
                                                                width:
                                                                    width / 4,
                                                                child: Text(list[
                                                                    'itempack']),
                                                              ),
                                                              value:
                                                                  list['id']);
                                                        },
                                                      ).toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedvalue = value;
                                                          getselectedvalue();
                                                          getallitemvalue(
                                                              value);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 3),
                                                  selectedvalue != null
                                                      ? Container(
                                                          height: 50,
                                                          width: 100,
                                                          child: FutureBuilder(
                                                              future:
                                                                  getselectedvalue(),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  if (snapshot
                                                                          .data
                                                                          .length ==
                                                                      0) {
                                                                    return Text(
                                                                        "No data on this itempack");
                                                                  }
                                                                  return ListView
                                                                      .builder(
                                                                          itemCount: snapshot
                                                                              .data
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            var list =
                                                                                snapshot.data[index];
                                                                            itemid =
                                                                                int.parse(list['id']);

                                                                            if (widget.invoiceprice == null ||
                                                                                widget.invoiceprice == 'Retail') {
                                                                              dropprice = double.parse(list['rs']);
                                                                            } else if (widget.invoiceprice ==
                                                                                'Wholesale') {
                                                                              dropprice = double.parse(list['ws']);
                                                                            }
                                                                            prices =
                                                                                dropprice;
                                                                            print('invoice');
                                                                            print(widget.invoiceprice);
                                                                            if (widget.invoiceprice == null ||
                                                                                widget.invoiceprice == 'Retail') {
                                                                              return ListTile(
                                                                                title: Text(
                                                                                  "\QR ${list['rs'].toString()}",
                                                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              );
                                                                            } else if (widget.invoiceprice ==
                                                                                'Wholesale') {
                                                                              return ListTile(
                                                                                title: Text(
                                                                                  "\QR ${list['ws'].toString()}",
                                                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              );
                                                                            }
                                                                          });
                                                                }
                                                                return Text(
                                                                    "No data found");
                                                              }))
                                                      : Text(""),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xfff3f3f4),
                                                    ),
                                                    child: DropdownButton(
                                                      value: units,
                                                      hint: Text(
                                                          "Select the Unit"),
                                                      items: unit.map(
                                                        (list) {
                                                          return DropdownMenuItem(
                                                              child: SizedBox(
                                                                width:
                                                                    width / 6,
                                                                child: Text(list[
                                                                    'unit']),
                                                              ),
                                                              value:
                                                                  list['id']);
                                                        },
                                                      ).toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          units = value;
                                                          getUnitVal();
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ]),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width: width / 8,
                                                    child: Text(
                                                      "Quantity",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    )),
                                                SizedBox(
                                                  width: width / 38,
                                                ),
                                                Container(
                                                  width: width / 8,
                                                  child: Text(
                                                    "Fixed FOC",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 38,
                                                ),
                                                Container(
                                                  width: width / 8,
                                                  child: Text(
                                                    "Allocated FOC",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 38,
                                                ),
                                                Container(
                                                  width: width / 8,
                                                  child: Text(
                                                    "Extra FOC",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: width / 8,
                                                  child: TextFormField(
                                                    validator: (value){
                                                      if(value == null || value.isEmpty){
                                                        return "Enter The Value Before proceeding";
                                                      }
                                                      return null;
                                                    },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          quantityController,
                                                      onChanged: (value) {
                                                        _calculate();
                                                      },
                                                      // initialValue: '',
                                                      decoration:
                                                          InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              fillColor: Color(
                                                                  0xfff3f3f4),
                                                              filled: true)),
                                                ),
                                                SizedBox(
                                                  width: width / 38,
                                                ),
                                                Container(
                                                  width: width / 8,
                                                  child: AbsorbPointer(
                                                    child: TextFormField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller:
                                                            fixedController,
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                fillColor: Color(
                                                                    0xfff3f3f4),
                                                                filled: true)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 38,
                                                ),
                                                Container(
                                                  width: width / 8,

                                                  child: TextFormField(
                                                      validator: (value){
                                                        if(value == null || value.isEmpty){
                                                          return "Enter The Value Before proceeding";
                                                        }
                                                        return null;
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          alocController,
                                                      onChanged: (value) {
                                                        _compare();
                                                      },
                                                      // initialValue: '',
                                                      decoration:
                                                          InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              fillColor: Color(
                                                                  0xfff3f3f4),
                                                              filled: true)),
                                                ),
                                                SizedBox(
                                                  width: width / 38,
                                                ),
                                                Container(
                                                  width: width / 8,
                                                  child: TextFormField(
                                                      validator: (value){
                                                        if(value == null || value.isEmpty){
                                                          return "Enter The Value Before proceeding";
                                                        }
                                                        return null;
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          efocController,
                                                      // initialValue: '',
                                                      decoration:
                                                          InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              fillColor: Color(
                                                                  0xfff3f3f4),
                                                              filled: true)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    child: ElevatedButton(
                                                        onPressed: addtocart, child: Text("Add To Cart")

                                                    )

                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                selectedvalue != null
                                                    ? Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10.0,
                                                                left: 15.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              "\ Item Code- ${widget.todo.itemid}",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .blue),
                                                            ),

                                                            SizedBox(
                                                              height: 1.0,
                                                            ),
                                                            //finalprice=data[index].price,
                                                            Text(
                                                              "\ Item Name- ${widget.todo.itemname_en}",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                            SizedBox(height: 1),
                                                            Text(
                                                              "\ Type Of Packing- ${widget.todo.itempack}",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .blue),
                                                            ),

                                                            SizedBox(height: 1),
                                                          ],
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 70,
                                                        width: 150,
                                                        child: FutureBuilder(
                                                            future:
                                                                getUnitVal(),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                if (snapshot
                                                                        .data
                                                                        .length ==
                                                                    0) {
                                                                  return Text(
                                                                      "No data on this itempack");
                                                                }
                                                                return ListView
                                                                    .builder(
                                                                        itemCount: snapshot
                                                                            .data
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          var list =
                                                                              snapshot.data[index];
                                                                          return Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                "\ Item Code- ${list['id'].toString()}",
                                                                                style: TextStyle(fontSize: 14, color: Colors.blue),
                                                                              ),

                                                                              SizedBox(
                                                                                height: 1.0,
                                                                              ),
                                                                              //finalprice=data[index].price,
                                                                              Text(
                                                                                "\ Item Name- ${list['itemname_en']}",
                                                                                style: TextStyle(fontSize: 14, color: Colors.blue),
                                                                              ),
                                                                              SizedBox(height: 1),
                                                                              Text(
                                                                                "\ Type Of Packing- ${list['itempack']}",
                                                                                style: TextStyle(fontSize: 14, color: Colors.blue),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        });
                                                              }
                                                              return Text(
                                                                  "No data found");
                                                            })),
                                              ],
                                            )
                                          ])),
                                ],
                              ))
                            ]),
                      Divider(
                        thickness: 2.0,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          Description_.toString(),
                          style: TextStyle(
                              fontSize: Description,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          description_.toString(),
                          style: TextStyle(
                              fontSize: shortdescription, color: Colors.grey),
                          //overflow: TextOverflow.ellipsis, maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          addDescription_.toString(),
                          style: TextStyle(
                              fontSize: Description,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          addinformation.toString(),
                          style: TextStyle(
                              fontSize: shortdescription, color: Colors.grey),
                          //overflow: TextOverflow.ellipsis, maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'Related Products',
                          style: TextStyle(
                              fontSize: Description,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      SizedBox(height: 10),
                      Container(
                        height: 175,
                        //child: Related_products(id:widget.todo.itemgroupid),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          )),
        ],
      ),


    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: Colors.blue,
    ));
  }

  void _calculate() {
    int val1 = int.parse(quantityController.text);
    if (val1 >= 0 && val1 <= 3) {
      fixedController.text = '0';
    } else if (val1 > 3 && val1 <= 6) {
      fixedController.text = '1';
    } else if (val1 > 6 && val1 <= 12) {
      fixedController.text = '2';
    } else if (val1 > 12 && val1 <= 25) {
      fixedController.text = '5';
    } else if (val1 > 25 && val1 <= 50) {
      fixedController.text = '12';
    } else if (val1 > 50 && val1 <= 100) {
      fixedController.text = '30';
    } else if (val1 > 100 && val1 <= 250) {
      fixedController.text = '72';
    } else if (val1 > 500 && val1 <= 1000) {
      fixedController.text = '300';
    }
  }

  void _compare() {
    int val1 = int.parse(fixedController.text);
    int val2 = int.parse(alocController.text);

    if (val2 <= val1) {
      setState(() {
        alocController.text = alocController.text;
      });
    } else {
      setState(() {
        alocController.text = fixedController.text;
      });
    }
  }
}

getprice(max, min) {
  if (max == min) {
    return Row(children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Text(
          "\QR ${max}",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    ]);
  } else {
    return Row(children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 15),
        child: Text("\QR ${max}",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
      ),
      Text(" - "),
      Text("\QR ${min}",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    ]);
  }
}
