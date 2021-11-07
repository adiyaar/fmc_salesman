import 'dart:convert';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsify/responsify_files/responsify_enum.dart';
import 'package:responsify/responsify_files/responsify_ui_widget.dart';
import 'package:testing/models/ItemGroupModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'ItemSubScreen.dart';

class ItemGroup extends StatefulWidget {
  final itemid;
  final itemtitle;

  ItemGroup({Key key, @required this.itemid, @required this.itemtitle})
      : super(key: key);
  @override
  _ItemGroupState createState() => _ItemGroupState();
}

class _ItemGroupState extends State<ItemGroup> {
  List<ItemGroupModel> data;
  String pharmacyname = "";

  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: TheSearch(data: data),
      query: pharmacyname,
    );
  }

  void _fetchdata() async {
    data = await _fetchItemGrpData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            widget.itemtitle,
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _showSearch();
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: ResponsiveUiWidget(
          targetOlderComputers: false,
          builder: (context, deviceInfo) {
            if (deviceInfo.deviceTypeInformation ==
                    DeviceTypeInformation.TABLET &&
                deviceInfo.orientation == Orientation.portrait) {
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height - 20,
                  child: FutureBuilder<List<ItemGroupModel>>(
                    future: _fetchItemGrpData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ItemGroupModel> data = snapshot.data;
                        return GridView.builder(
                            itemCount: data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: MediaQuery.of(context)
                                            .size
                                            .width /
                                        (MediaQuery.of(context).size.height /
                                            1.1),
                                    crossAxisCount: 4),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  print(data[index].id);
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => ItemSub(
                                              itemsubid: data[index].id,
                                              itemetitle: data[index].title)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xFFFECEFF1),
                                        ),
                                        borderRadius: BorderRadius.circular(13),
                                        color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Image.network(
                                        //   'https://onlinefamilypharmacy.com/images/itemmaingroupimages/' +
                                        //       data[index].imageurl,
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       5.6,
                                        //   width: MediaQuery.of(context)
                                        //           .size
                                        //           .width /
                                        //       2,
                                        // ),
                                        FadeInImage.assetNetwork(
                                          placeholder:
                                              "https://i.ibb.co/tYGHbNk/Eclipse-1s-200px.gif",
                                          image:
                                              'https://onlinefamilypharmacy.com/images/itemgroupimages/' +
                                                  data[index].imageurl,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5.6,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Text(
                                            data[index].title,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Center(
                        child: CircularPercentIndicator(
                          radius: 100.0,
                          lineWidth: 10.0,
                          percent: 1.0,
                          animationDuration: 5000,
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
                ),
              );
            } else if (deviceInfo.deviceTypeInformation ==
                    DeviceTypeInformation.TABLET &&
                deviceInfo.orientation == Orientation.landscape) {
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height - 20,
                  child: FutureBuilder<List<ItemGroupModel>>(
                    future: _fetchItemGrpData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ItemGroupModel> data = snapshot.data;
                        return GridView.builder(
                            itemCount: data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1.2, crossAxisCount: 5),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => ItemSub(
                                              itemsubid: data[index].id,
                                              itemetitle: data[index].title)));
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFFFECEFF1),
                                      ),
                                      borderRadius: BorderRadius.circular(13),
                                      color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        'https://onlinefamilypharmacy.com/images/itemgroupimages/' +
                                            data[index].imageurl,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                30,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          data[index].title,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Center(
                        child: CircularPercentIndicator(
                          radius: 100.0,
                          lineWidth: 10.0,
                          percent: 1.0,
                          animationDuration: 5000,
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
                ),
              );
            } else if (deviceInfo.deviceTypeInformation ==
                DeviceTypeInformation.MOBILE) {
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height - 20,
                  child: FutureBuilder<List<ItemGroupModel>>(
                    future: _fetchItemGrpData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ItemGroupModel> data = snapshot.data;
                        return GridView.builder(
                            itemCount: data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: MediaQuery.of(context)
                                            .size
                                            .width /
                                        (MediaQuery.of(context).size.height /
                                            1.1),
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  print(data[index].id);
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => ItemSub(
                                              itemsubid: data[index].id,
                                              itemetitle: data[index].title)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    // height: containerh,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xFFFECEFF1),
                                        ),
                                        borderRadius: BorderRadius.circular(13),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            'https://onlinefamilypharmacy.com/images/itemgroupimages/' +
                                                data[index].imageurl,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4.5,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                30,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Text(
                                              data[index].title,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Center(
                        child: CircularPercentIndicator(
                          radius: 100.0,
                          lineWidth: 10.0,
                          percent: 1.0,
                          animationDuration: 5000,
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
                ),
              );
            }
            return Text("Not Compatible");
          },
        ));
  }

  Future<List<ItemGroupModel>> _fetchItemGrpData() async {
    final url =
        'https://onlinefamilypharmacy.com/mobileapplication/categories/itemgroup.php';
    var data = {'itemid': widget.itemid};
    var response = await http.post(Uri.parse(url), body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((job) => new ItemGroupModel.fromJson(job))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Grid(context, data) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  final containerh = height / 2;
  if (height > 450 && width > 450 && width < 835) {
    print('samsung tab vertical |');
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1),
            crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // print(data[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          itemsubid: data[index].id,
                          itemetitle: data[index].title)));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://onlinefamilypharmacy.com/images/itemgroupimages/' +
                          data[index].imageurl,
                      height: containerh / 2.5,
                      width: width / 2,
                    ),
                    Container(
                      height: containerh / 15,
                      width: width / 2,
                      child: Text(
                        data[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                //  ),
              ),
            ),
          );
        });
  } else if (width > 450 && width < 835) {
    print('samsung A51 horizontal _____');
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 0.5),
            crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // print(data[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          itemsubid: data[index].id,
                          itemetitle: data[index].title)));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://onlinefamilypharmacy.com/images/itemgroupimages/' +
                          data[index].imageurl,
                      height: containerh / 1.5,
                      width: width / 2,
                    ),
                    Container(
                      height: containerh / 10,
                      width: width / 2,
                      child: Text(
                        data[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                //  ),
              ),
            ),
          );
        });
  } else if (width < 450) {
    //samsung A51 vertical |
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.7),
            crossAxisCount: 3),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // print(data[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          itemsubid: data[index].id,
                          itemetitle: data[index].title)));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://onlinefamilypharmacy.com/images/itemgroupimages/' +
                          data[index].url,
                      height: containerh / 3.5,
                      width: width / 2,
                    ),
                    Container(
                      height: containerh / 21,
                      width: width / 2,
                      child: Text(
                        data[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                //  ),
              ),
            ),
          );
        });
  } else {
    //samsung tab horizontal ----
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 0.45),
            crossAxisCount: 5),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // print(data[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          itemsubid: data[index].id,
                          itemetitle: data[index].title)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: height / 3,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://onlinefamilypharmacy.com/images/itemgroupimages/' +
                            data[index].url,
                        height: containerh / 1.5,
                        width: width / 2,
                      ),
                      Container(
                        height: containerh / 10,
                        width: width / 2,
                        child: Text(
                          data[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class TheSearch extends SearchDelegate<String> {
  TheSearch({this.contextPage, this.controller, @required this.data});

  List<ItemGroupModel> data;
  BuildContext contextPage;
  WebViewController controller;
  final suggestions1 = [];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.black,
    );
  }

  @override
  String get searchFieldLabel => "Search Item Group";

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
            .where((element) =>
                element.imageurl.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Grid(
        context,
        data
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }
}
