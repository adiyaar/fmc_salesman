import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/Common/Shimmer.dart';
import 'package:testing/models/SearchScreenModel.dart';
import 'package:testing/screens/DetailPageScreen.dart';
import 'package:testing/screens/FilterScreen.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:api_cache_manager/api_cache_manager.dart';


class SearchScreen extends StatefulWidget {
  final List userInfo;
  const SearchScreen({Key key, this.userInfo}) : super(key: key);

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

  List<SearchList> allList = [];

  List hiveList = [];

  Box searchBox;

  // ofline data caching using Hive
// create a local storage
//   Future openBox() async {
//     var directory = await getApplicationDocumentsDirectory();
//     Hive.init(directory.path);
//     searchBox = await Hive.openBox('SearchBox');
//     return;
//   }

  // Future<bool> getAllData() async {
  //   await openBox();
  //   final baseUrl =
  //       'https://onlinefamilypharmacy.com/mobileapplication/salesmansearchallproducts.php';
  //
  //   try {
  //     var response = await http.get(Uri.parse(baseUrl));
  //     if (response.statusCode == 200) {
  //       List jsonResponse = json.decode(response.body);
  //
  //       await putData(jsonResponse);
  //       // allList.addAll(
  //       //     jsonResponse.map((e) => new SearchList.fromJson(e)).toList());
  //     }
  //   } catch (SocketException) {
  //     print('No Internet');
  //   }
  //
  //   var myList = searchBox.toMap().values.toList();
  //   if (myList.isEmpty) {
  //     hiveList.add('empty');
  //   } else {
  //     print('addeding');
  //     hiveList = myList;
  //   }
  //
  //   return Future.value(true);
  // }

  // Future putData(data) async {
  //   await searchBox.clear();
  //
  //   for (var d in data) {
  //     print('Add');
  //     searchBox.add(d);
  //   }
  // }

  Future getAllData() async {

      final baseUrl =
          'https://onlinefamilypharmacy.com/mobileapplication/salesmansearchallproducts.php';



      var cacheExists = await APICacheManager().isAPICacheKeyExist('SearchFinal');

      if(!cacheExists){

        print('Api hit');
        var response = await http.get(Uri.parse(baseUrl));
        if (response.statusCode == 200) {


          List jsonResponse = json.decode(response.body);

          APICacheDBModel cacheDBModel = new APICacheDBModel(key: 'SearchFinal', syncData: response.body);

          await APICacheManager().addCacheData(cacheDBModel);
          return
              jsonResponse.map((e) => new SearchList.fromJson(e)).toList();
        }


      }
      else{
        print('CACHE HIT');
        var cacheData = await APICacheManager().getCacheData('SearchFinal');

        List jsoncached = json.decode(cacheData.syncData);

        return
            jsoncached.map((e) => new SearchList.fromJson(e)).toList();
      }

    }

  String pharmacyname = "";
  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: TheSearch(data: allList, userInfo: widget.userInfo),
      query: pharmacyname,
    );
  }

  void _fetchdata() async {
    allList = await getAllData();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCustomerInfo();
    _fetchdata();

    getAllData();
    // fetchItemMainGroupList();
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        // drawer: NavigationDrawer(),
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
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => FilterScreen(
                                userInfo: widget.userInfo,
                              )));
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
                  future: getAllData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<SearchList> data = snapshot.data;
                      print('Data Length');
                      print(data.length);
                        return ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          scrollDirection: Axis.vertical,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {


                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => DetailPageScreen(
                                              userInfo: widget.userInfo,
                                              itemDetails: data[index],
                                              customerType: customerType,
                                            )));
                              },
                              child: ListTile(
                                leading:
                                    'https://onlinefamilypharmacy.com/images/item/${data[index].img}' ==
                                            'https://onlinefamilypharmacy.com/images/item/null'
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                'https://onlinefamilypharmacy.com/images/noimage.jpg',
                                            height: 130,
                                            width: 100,
                                            fit: BoxFit.fill,
                                            progressIndicatorBuilder:
                                                (_, url, download) {
                                              if (download.progress != null) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: download.progress,
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
                                                'https://onlinefamilypharmacy.com/images/item/${data[index].img}',
                                            height: 130,
                                            width: 100,
                                            fit: BoxFit.fill,
                                            progressIndicatorBuilder:
                                                (_, url, download) {
                                              if (download.progress != null) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: download.progress,
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

                                title: Text(
                                  data[index].itemid +
                                      ' - ' +
                                      data[index].itemproductgrouptitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
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
                  },
                ),
              )
            ],
          ),
        ));
  }
}

// ignore: non_constant_identifier_names
SearchListD(context, data, userInfo) {
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
                        userInfo: userInfo,
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
            data[index].itemid + ' - ' + data[index].itemproductgrouptitle,
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
  TheSearch(
      {this.contextPage,
      this.controller,
      @required this.data,
      @required this.userInfo});
  List userInfo;
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
            .toList(),
        userInfo);
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
            .toList(),
        userInfo);
  }
}
