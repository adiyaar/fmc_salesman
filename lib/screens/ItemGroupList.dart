import 'dart:convert';
//import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:responsify/responsify.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/Common/Shimmer.dart';
import 'package:testing/screens/DetailPageScreen.dart';
import 'package:webview_flutter/webview_flutter.dart';

bool isGridView = false;

class ListItems extends StatefulWidget {
  List userInfo;
  final itemnull;

  ListItems({Key key, @required this.itemnull, @required this.userInfo})
      : super(key: key);
  @override
  _ListItemsState createState() => _ListItemsState();
}

class ItemGrpData {
  final String itemid;
  final String img;
  final String itemname_en;
  final String labelname;
  final String itempack;
  final String itemstrength;
  final String itemmaingrouptitle;
  final String itemgrouptitle;
  final String itemproductgrouptitle;
  final String itemproductgroupimage;
  final String type;
  final String itemdosageid;
  final String itemclassid;
  final String manufactureshortname;
  final String seq;
  final String maxretailprice;
  final String minretailprice;
  final String rs;
  final String origin;
  final String whichcompany;
  final String allowsonapp;
  final String status;
  final String shortdescription;
  final String description;
  final String additionalinformation;
  final String itemproductgroupid;
  final String url;
  final String itemgroupid;
  ItemGrpData(
      {this.itemid,
      this.img,
      this.itemname_en,
      this.labelname,
      this.itempack,
      this.itemstrength,
      this.itemmaingrouptitle,
      this.itemgrouptitle,
      this.itemproductgrouptitle,
      this.itemproductgroupimage,
      this.type,
      this.itemdosageid,
      this.itemclassid,
      this.manufactureshortname,
      this.seq,
      this.maxretailprice,
      this.minretailprice,
      this.rs,
      this.origin,
      this.whichcompany,
      this.allowsonapp,
      this.status,
      this.shortdescription,
      this.description,
      this.additionalinformation,
      this.itemproductgroupid,
      this.url,
      this.itemgroupid});

  factory ItemGrpData.fromJson(Map<String, dynamic> json) {
    return ItemGrpData(
        itemid: json['itemid'],
        img: json['img'],
        itemname_en: json['itemname_en'],
        labelname: json['labelname'],
        itempack: json['itempack'],
        itemstrength: json['itemstrength'],
        itemmaingrouptitle: json['itemmaingrouptitle'],
        itemgrouptitle: json['itemgrouptitle'],
        itemproductgrouptitle: json['itemproductgrouptitle'],
        itemproductgroupimage: json['itemproductgroupimage'],
        type: json['type'],
        itemdosageid: json['itemdosageid'],
        itemclassid: json['itemclassid'],
        manufactureshortname: json['manufactureshortname'],
        seq: json['seq'],
        maxretailprice: json['maxretailprice'],
        minretailprice: json['minretailprice'],
        rs: json['rs'],
        origin: json['origin'],
        whichcompany: json['whichcompany'],
        allowsonapp: json['allowsonapp'],
        status: json['status'],
        shortdescription: json['shortdescription'],
        description: json['description'],
        additionalinformation: json['additionalinformation'],
        itemproductgroupid: json['itemproductgroupid'],
        url: json['image'],
        itemgroupid: json['itemgroupid']);
  }
}

class _ListItemsState extends State<ListItems> {
  int a;

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
    print(jsonResponse.length);
    a = jsonResponse.length;
    setState(() {});
    return a;
  }

  String pharmacyname = '';
  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: TheSearch(data: data, userInfo: widget.userInfo),
      query: pharmacyname,
    );
  }

  List<ItemGrpData> data = [];

  void _fetchdata() async {
    data = await _fetchItemGrpData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCrtCOunt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ResponsiveUiWidget(
          targetOlderComputers: false,
          builder: (context, deviceinfo) {
            return Visibility(
              visible: deviceinfo.deviceTypeInformation ==
                  DeviceTypeInformation.TABLET,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    isGridView = !isGridView;
                  });
                },
                child: isGridView ? Icon(Icons.list) : Icon(Icons.grid_4x4),
                backgroundColor: Colors.black,
              ),
            );
          }),
      body: FutureBuilder<List<ItemGrpData>>(
        future: _fetchItemGrpData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ItemGrpData> data = snapshot.data;
            return Grid(context, data, widget.userInfo);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return SearchShimmer();
          }
          return SearchShimmer();
        },
      ),
    );
  }

  Future<List<ItemGrpData>> _fetchItemGrpData() async {
    final url =
        'https://onlinefamilypharmacy.com/mobileapplication/categories/list_groupitems.php';
    var data = {'itemid': widget.itemnull};
    var response = await http.post(Uri.parse(url), body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new ItemGrpData.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Grid(context, data, userInfo) {
  return isGridView
      ? ResponsiveUiWidget(
          targetOlderComputers: true,
          builder: (context, deviceInfo) {
            return GridView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    crossAxisCount:
                        (deviceInfo.orientation == Orientation.portrait)
                            ? 4
                            : 6),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => DetailPageScreen(
                                    userInfo: userInfo,
                                    itemDetails: data[index],
                                  )));
                    },
                    child: Container(
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: 'https://onlinefamilypharmacy.com/images/item/${data[index].img}' ==
                                    'https://onlinefamilypharmacy.com/images/item/null'
                                ? CachedNetworkImage(
                                    imageUrl:
                                        'https://onlinefamilypharmacy.com/images/noimage.jpg',
                                    height: 110,
                                    width: 100,
                                    fit: BoxFit.fill,
                                    progressIndicatorBuilder:
                                        (_, url, download) {
                                      if (download.progress != null) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: download.progress,
                                            color: Colors.black,
                                          ),
                                        );
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      );
                                    },
                                  )
                                : CachedNetworkImage(
                                    imageUrl:
                                        'https://onlinefamilypharmacy.com/images/item/${data[index].img}',
                                    height: 110,
                                    width: 100,
                                    fit: BoxFit.fill,
                                    progressIndicatorBuilder:
                                        (_, url, download) {
                                      if (download.progress != null) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: download.progress,
                                            color: Colors.black,
                                          ),
                                        );
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              data[index].itemid +
                                  ' - ' +
                                  data[index].itemproductgrouptitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text(
                              data[index].itemmaingrouptitle,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text(
                              "QR ${data[index].minretailprice}" +
                                  ' - ' +
                                  "QR ${data[index].maxretailprice}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          })
      : ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (context, index) {
            print(data[index]);
            return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPageScreen(
                              userInfo: userInfo, itemDetails: data[index])));
                },
                // var finalprice = data[index].price;
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey[300], width: 1.5),
                          top: BorderSide(color: Colors.grey[300], width: 1.5),
                        )),
                    height: 100.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12, blurRadius: 5.0)
                              ],
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://onlinefamilypharmacy.com/images/item/' +
                                          data[index].img),
                                  fit: BoxFit.fill)),
                        ),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children: <Widget>[
                                Expanded(
                                  child: Text(
                                    data[index].itemproductgrouptitle,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                              SizedBox(height: 5),
                              Row(children: <Widget>[
                                Expanded(
                                  child: Text(
                                    data[index].itemmaingrouptitle,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                              SizedBox(height: 5),
                              getprice(data[index].minretailprice,
                                  data[index].maxretailprice),

                              /* Row(
      children: <Widget>[
                            Expanded(
                              child: Text(
                                data[index].minretailprice,
                                style: TextStyle(fontWeight: FontWeight
                                    .w600, fontSize: 15.0),overflow: TextOverflow.ellipsis,),
                            ),]),*/
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ));
          },
        );
}

getprice(max, min) {
  if (max == min) {
    return Row(children: <Widget>[
      Expanded(
        child: Text(
          "\QR ${max}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  } else {
    return Row(children: <Widget>[
      Text(
        "\QR ${max}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      Text(" - "),
      Text(
        "\QR ${min}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }
}

class TheSearch extends SearchDelegate<String> {
  List userInfo;
  TheSearch(
      {this.contextPage,
      
      @required this.data,
      @required this.userInfo});

  List<ItemGrpData> data;
  BuildContext contextPage;
  
  final suggestions1 = [];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.black,
    );
  }

  @override
  String get searchFieldLabel => "Search";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Grid(
        context,
        data
            .where((element) => element.itemproductgrouptitle
                .toLowerCase()
                .trim()
                .contains(query.toLowerCase().trim()))
            .toList(),
        userInfo);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print('h');
    return Grid(
        context,
        data
            .where((element) => element.itemproductgrouptitle
                .toLowerCase()
                .trim()
                .contains(query.toLowerCase().trim()))
            .toList(),
        userInfo);
  }
}
