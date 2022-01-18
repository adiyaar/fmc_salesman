import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/Common/Shimmer.dart';
import 'package:testing/models/SearchScreenModel.dart';
import 'package:testing/screens/DetailPageScreen.dart';
import 'package:testing/screens/FilterScreen.dart';

import 'package:testing/widget/NavigationDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  String customerType; // Wholesale
  getCustomerInfo() async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    customerType = pf.getString('cust_type');
  }

  bool itemGroup = false;
  List<ItemMainGroup> mainGroupOptions = [];
  List<Manufactures> manufactureOptions = [];
  bool manuFacturer = false;
  List<SearchList> medicineList = [];
  List<SearchList> allList = [];

  Future<List<SearchList>> fetchAllItem() async {
    final baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmansearchallproducts.php';
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      allList
          .addAll(jsonResponse.map((e) => new SearchList.fromJson(e)).toList());
      medicineList.addAll(
          allList.where((element) => element.itemmaingroupid == "2").toList());
      return allList;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  String pharmacyname = "";
  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: TheSearch(data: allList),
      query: pharmacyname,
    );
  }

  void _fetchdata() async {
    allList = await fetchAllItem();
    medicineList
        .addAll(allList.where((element) => element.itemid == "2").toList());

    print(allList.length);
    print(medicineList.length);
    setState(() {});
  }

  void categorlIst() async {
    medicineList = await fetchAllItem();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCustomerInfo();
    _fetchdata();
    categorlIst();

    fetchAllItem();
    // fetchItemMainGroupList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
            backgroundColor: Colors.black87,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              "Search",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.sort,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => FilterScreen()));
                },
              ),
            ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  _showSearch();
                },
                child: Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text("Search Your Products")),
              ),
              Container(
                height: height / 1.1,
                child: FutureBuilder(
                  future: fetchAllItem(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<SearchList> data = snapshot.data;

                      return ListView.separated(
                        primary: true,
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        scrollDirection: Axis.vertical,
                        itemCount: medicineList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              print(data[index].itemid);
                              print(data[index].itemmaingrouptitle);

                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => DetailPageScreen(
                                            itemDetails: data[index],
                                            customerType: customerType,
                                          )));
                            },
                            child: ListTile(
                              leading: 'https://onlinefamilypharmacy.com/images/item/${data[index].img}' ==
                                      'https://onlinefamilypharmacy.com/images/item/null'
                                  // ? Image.network(
                                  //     'https://onlinefamilypharmacy.com/images/noimage.jpg',
                                  //     height: 100,
                                  //     width: 100,
                                  //     fit: BoxFit.fill,
                                  //   )
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          'https://onlinefamilypharmacy.com/images/noimage.jpg',
                                      height: 100,
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
                                      height: 100,
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

                              title: Text(
                                data[index].itemproductgrouptitle,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].itemmaingrouptitle,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  customerType == 'Wholesale'
                                      ? Text(
                                          "\QR ${data[index].minwholesaleprice}" +
                                              " - " +
                                              "\QR ${data[index].maxwholesaleprice}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          "\QR ${data[index].minretailprice}" +
                                              " - " +
                                              "\QR ${data[index].maxretailprice}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              ),
                              // isThreeLine: true,
                            ),
                          );
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return SearchShimmer();
                    }
                    return SearchShimmer();
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
                ),
              )
            ],
          ),
        ));
  }
}

SearchListD(context, data) {
  return ListView.separated(
    separatorBuilder: (context, index) {
      return Divider();
    },
    primary: true,
    scrollDirection: Axis.vertical,
    itemCount: data.length,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => DetailPageScreen(
                        itemDetails: data[index],
                      )));
        },
        child: ListTile(
          leading:
              'https://onlinefamilypharmacy.com/images/item/${data[index].img}' ==
                      'https://onlinefamilypharmacy.com/images/item/null'
                  ? CachedNetworkImage(
                      imageUrl:
                          'https://onlinefamilypharmacy.com/images/noimage.jpg',
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder: (_, url, download) {
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
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder: (_, url, download) {
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
          title: Text(
            data[index].itemproductgrouptitle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data[index].itemmaingrouptitle,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "\QR ${data[index].minretailprice}" +
                    " - " +
                    "\QR ${data[index].maxretailprice}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          isThreeLine: true,
          // trailing: Text(
          //   "\QR ${data[index].minretailprice}" +
          //       " - " +
          //       "\QR ${data[index].maxretailprice}",
          //   style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          // ),
        ),
      );
    },
  );
}

class TheSearch extends SearchDelegate<String> {
  TheSearch({this.contextPage, this.controller, @required this.data});

  List<SearchList> data;
  BuildContext contextPage;
  WebViewController controller;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.white,
    );
  }

  @override
  String get searchFieldLabel => "Begin Searching";

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
    print("Results");
    return SearchListD(
        context,
        data
            .where((element) => element.itemproductgrouptitle
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print("Suggestions");
    return SearchListD(
        context,
        data
            .where((element) => element.itemproductgrouptitle
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList());
  }
}
