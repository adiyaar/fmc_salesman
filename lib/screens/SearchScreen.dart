import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:testing/models/SearchScreenModel.dart';
import 'package:testing/models/SearchScreenModel.dart';
import 'package:testing/screens/DetailPageScreen.dart';
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
  bool man = false;

  Future<List<ItemMainGroup>> fetchItemMainGroupList() async {
    final String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/categories/itemmaingroup.php?action=itemmaingroup';
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((itemmaingroup) => new ItemMainGroup.fromJson(itemmaingroup))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<List<Manufactures>> fetchManufactures() async {
    final jobsListAPIUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=manufacture';
    final response = await http.get(Uri.parse(jobsListAPIUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((e) => new Manufactures.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<List<SearchList>> fetchAllItem() async {
    final baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmansearchallproducts.php';
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((e) => new SearchList.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  List<SearchList> data;

  String pharmacyname = "";
  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: TheSearch(data: data),
      query: pharmacyname,
    );
  }

  void _fetchdata() async {
    data = await fetchAllItem();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchdata();
    fetchAllItem();
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
                  // showModalBottomSheet(context: context, builder: builder)
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return DraggableScrollableSheet(
                            expand: false,
                            builder: (BuildContext context,
                                ScrollController scrollcontroler) {
                              return SingleChildScrollView(
                                child: Container(

                                    // width: width,
                                    child: Column(children: <Widget>[
                                  Container(
                                    decoration:
                                        new BoxDecoration(color: Colors.black),
                                    child: ListTile(
                                      title: Text(
                                        'Filter',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Text(
                                                " Item Main Group",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: height / 2.2,
                                            width: width / 2.2,
                                            child: FutureBuilder<
                                                List<ItemMainGroup>>(
                                              future: fetchItemMainGroupList(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  List<ItemMainGroup> data =
                                                      snapshot.data;
                                                  return ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: data.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return ListTile(
                                                          title: Text(
                                                              data[index]
                                                                  .title),
                                                          leading: Checkbox(
                                                            value: man,
                                                            onChanged: (val) {
                                                              print(val);
                                                              setState(() {
                                                                man = val;
                                                              });
                                                            },
                                                          ),
                                                        );
                                                      });
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      "${snapshot.error}");
                                                }
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.black),
                                                ));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 5),
                                              child: Text(
                                                "Manufacture",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: height / 2.2,
                                            width: width / 2.2,
                                            child: FutureBuilder<
                                                List<Manufactures>>(
                                              future: fetchManufactures(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  List<Manufactures> data =
                                                      snapshot.data;
                                                  return ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: data.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return ListTile(
                                                          title: Text(
                                                              data[index]
                                                                  .title),
                                                          leading: Checkbox(
                                                            value: man,
                                                            onChanged: (val) {
                                                              print(val);
                                                              setState(() {
                                                                man = val;
                                                              });
                                                            },
                                                          ),
                                                        );
                                                      });
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      "${snapshot.error}");
                                                }
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.black),
                                                ));
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ])),
                              );
                            });
                      });
                  // do something
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

                      return ListView.builder(
                        primary: true,
                        itemExtent: 100.0,
                        cacheExtent:
                            5.00 * double.parse(data.length.toString()),
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              print(data[index].itemid);
                              print(data[index].itemproductgroupid);
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
                                      ? Image.network(
                                          'https://onlinefamilypharmacy.com/images/noimage.jpg',
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.network(
                                          'https://onlinefamilypharmacy.com/images/item/${data[index].img}',
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.fill,
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
                              // isThreeLine: true,
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return Center(
                      child: CircularPercentIndicator(
                        radius: 100.0,
                        lineWidth: 10.0,
                        percent: 1.0,
                        animationDuration: 8000,
                        restartAnimation: true,
                        animation: true,
                        footer: Text("Fetching Data Securely!"),
                        center: new Icon(
                          Icons.lock,
                          size: 50.0,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.white,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.black,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
    // body: SingleChildScrollView(
    //     child: Column(
    //       children: <Widget>[
    //         Container(
    //           height: 60,
    //           decoration: BoxDecoration(color: Colors.black87),
    //           child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Padding(
    //                   padding:
    //                   const EdgeInsets.only(left: 0, top: 0, bottom: 0),
    //                   child: Container(
    //                     decoration: BoxDecoration(color: Colors.white),
    //                     width: width / 1,
    //                     child: TextField(
    //                       autofocus: true,
    //                       textInputAction: TextInputAction.go,
    //                       decoration: InputDecoration(
    //                         contentPadding: EdgeInsets.all(15.0),
    //                         hintText: "Search Medicines / Healthcare Products",
    //                       ),
    //                       onChanged: (string) {
    //                         setState(() {
    //                           itemname = string;
    //                           search = true;
    //
    //                         });
    //                       },
    //                     ),
    //                   ),
    //                 ),
    //
    //               ]),
    //         ),
    //         if ((search == true) & (filter == false))
    //           (Container(
    //             height: height / 1.22,
    //             child: FutureBuilder<List<ItemData>>(
    //               future: _fetchItemData(),
    //               builder: (context, snapshot) {
    //                 if (snapshot.hasData) {
    //                   List<ItemData> data = snapshot.data;
    //                   //filterdata(data);
    //                   return Grid(context, data);
    //                 } else if (snapshot.hasError) {
    //                   return Text("${snapshot.error}");
    //                 }
    //                 return Center(
    //                     child: CircularProgressIndicator(
    //                       valueColor: AlwaysStoppedAnimation<Color>(
    //                           Colors.black),
    //                     ));
    //               },
    //             ),
    //           ))
    //         else if ((search == true) & (filter == true))
    //           (Container(
    //             height: height / 1.3,
    //             child: FutureBuilder<List<ItemData>>(
    //               future: _fetchItemData(),
    //               builder: (context, snapshot) {
    //                 if (snapshot.hasData) {
    //                   List<ItemData> data = snapshot.data;
    //                   filterdata(data);
    //                   return Grid(context, data);
    //                 } else if (snapshot.hasError) {
    //                   return Text("${snapshot.error}");
    //                 }
    //                 return Center(
    //                     child: CircularProgressIndicator(
    //                       valueColor: AlwaysStoppedAnimation<Color>(
    //                           Colors.black),
    //                     ));
    //               },
    //             ),
    //           ))
    //         else
    //           (Container()),
    //       ],
    //     )),
    // floatingActionButton: Container(
    //   height: 35.0,
    //
    //   //child: FittedBox(
    //   child: Center(
    //     child: FloatingActionButton.extended(
    //       icon: Icon(Icons.format_align_center, color: Colors.white),
    //       //  label: Text("Add to Cart"),
    //       backgroundColor: Colors.black,
    //       onPressed: () {
    //         showMaterialModalBottomSheet(
    //             expand: false,
    //             context: context,
    //             builder: (context) {
    //               final width = MediaQuery.of(context).size.width;
    //               return Container(
    //                   height: 360.0,
    //                   width: width,
    //                   child: ListView(children: <Widget>[
    //                     //   ..add(
    //                     //
    //                     // Simple example
    //                     //
    //                     Center(child: Text('Price range from 0 to 500')),
    //                     Padding(
    //                       padding: const EdgeInsets.only(left: 15),
    //                       child: Row(children: <Widget>[
    //                         Text(_lowerValueFormatter.toString()),
    //                         Container(
    //                           width: width/1.3,
    //                           child: frs.RangeSlider(
    //                             min: 0.0,
    //                             max: 500.0,
    //                             lowerValue: _lowerValueFormatter,
    //                             upperValue: _upperValueFormatter,
    //                             divisions: 10,
    //                             showValueIndicator: true,
    //                             valueIndicatorMaxDecimals: 1,
    //                             onChanged: (double newLowerValue,
    //                                 double newUpperValue) {
    //                               setState(() {
    //                                 _lowerValue = newLowerValue;
    //                                 _upperValue = newUpperValue;
    //
    //                                 _fetchItemData();
    //                               });
    //                             },
    //                             onChangeStart: (double startLowerValue,
    //                                 double startUpperValue) {},
    //                             onChangeEnd: (double newLowerValue,
    //                                 double newUpperValue) {},
    //                           ),
    //                         ),
    //                         Text(_upperValueFormatter.toString()),
    //                       ]),
    //                     ),
    //                     //   ),
    //                     SizedBox(height: 20),
    //                     Divider(
    //                       color: Colors.grey[200],
    //                       height: 20,
    //                       thickness: 10,
    //                     ),
    //
    //                     ListTile(
    //                       leading: Image.asset('assets/az.png',
    //                           color: Colors.black, height: 24),
    //                       title: Text('Name A To Z'),
    //                       onTap: () {
    //                         setState(() {
    //                           filter = true;
    //                           sort = 'asc';
    //                           Navigator.of(context).pop();
    //                         });
    //                       },
    //                     ),
    //                     ListTile(
    //                       leading: Image.asset('assets/za.png',
    //                           color: Colors.black, height: 24),
    //                       title: Text('Name Z To A'),
    //                       onTap: () {
    //                         setState(() {
    //                           filter = true;
    //                           sort = 'desc';
    //                           Navigator.of(context).pop();
    //                         });
    //                       },
    //                     ),
    //                     ListTile(
    //                       leading: Icon(Icons.arrow_upward,
    //                           color: Colors.black, size: 30),
    //                       title: Text('Price low to high'),
    //                       onTap: () {
    //                         setState(() {
    //                           filter = true;
    //                           sort = 'ltoh';
    //                           Navigator.of(context).pop();
    //                         });
    //                       },
    //                     ),
    //                     ListTile(
    //                       leading: Icon(Icons.arrow_downward,
    //                           color: Colors.black, size: 30),
    //                       title: Text('Price high to low'),
    //                       onTap: () {
    //                         setState(() {
    //                           filter = true;
    //                           sort = 'htol';
    //                           Navigator.of(context).pop();
    //                         });
    //                       },
    //                     ),
    //                   ]));
    //             });
    //       },
    //       // icon: Icon(Icons.save),
    //       label: Center(
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Text(
    //               "Sort",
    //               style: TextStyle(
    //                   fontSize: 15,
    //                   color: Colors.white,
    //                   fontWeight: FontWeight.bold),
    //             ),
    //           )),
    //     ),
    //   ),
    // ));
  }
}

SearchListD(context, data) {
  return ListView.builder(
    primary: true,
    itemExtent: 100.0,
    cacheExtent: 5.00 * double.parse(data.length.toString()),
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
                  ? Image.network(
                      'https://onlinefamilypharmacy.com/images/noimage.jpg',
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      'https://onlinefamilypharmacy.com/images/item/${data[index].img}',
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
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
