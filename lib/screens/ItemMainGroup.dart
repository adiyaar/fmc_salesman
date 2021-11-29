import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:responsify/responsify.dart';
import 'package:testing/models/ItemMainGroupModel.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'ItemGroup.dart';

class ItemMainGroup extends StatefulWidget {
  ItemMainGroup({Key key}) : super(key: key);

  @override
  _ItemMainGroupState createState() => _ItemMainGroupState();
}

class _ItemMainGroupState extends State<ItemMainGroup> {
  List<ItemMainGroupModel> data;

  String pharmacyname = "";
  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: TheSearch(data: data),
      query: pharmacyname,
    );
  }

  void _fetchdata() async {
    data = await fetchItemData();
    setState(() {});
  }

  Future<List<ItemMainGroupModel>> fetchItemData() async {
    final baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/categories/itemmaingroup.php?action=itemmaingroup';
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((job) => new ItemMainGroupModel.fromJson(job))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchItemData();
    _fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Item Main Group",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
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
                child: FutureBuilder<List<ItemMainGroupModel>>(
                  future: fetchItemData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ItemMainGroupModel> data = snapshot.data;
                      return GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              1.1),
                                  crossAxisCount: 4),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => ItemGroup(
                                            itemid: data[index].id,
                                            itemtitle: data[index].title)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 8,
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
                                      CachedNetworkImage(
                                        imageUrl:
                                            'https://onlinefamilypharmacy.com/images/itemmaingroupimages/' +
                                                data[index].imageUrl,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5.6,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                            color: Colors.black,
                                          ),
                                        ),
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
                child: FutureBuilder<List<ItemMainGroupModel>>(
                  future: fetchItemData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ItemMainGroupModel> data = snapshot.data;
                      return GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1.1, crossAxisCount: 6),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => ItemGroup(
                                            itemid: data[index].id,
                                            itemtitle: data[index].title)));
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFFFECEFF1),
                                    ),
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          'https://onlinefamilypharmacy.com/images/itemmaingroupimages/' +
                                              data[index].imageUrl,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5.5,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      progressIndicatorBuilder:
                                          (context, url, progress) => Center(
                                        child: CircularProgressIndicator(
                                          value: progress.progress,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              30,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
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
                child: FutureBuilder<List<ItemMainGroupModel>>(
                  future: fetchItemData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ItemMainGroupModel> data = snapshot.data;
                      return GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
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
                                        builder: (context) => ItemGroup(
                                            itemid: data[index].id,
                                            itemtitle: data[index].title)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  // height: containerh,
                                  width: MediaQuery.of(context).size.width / 2,
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
                                        CachedNetworkImage(
                                          imageUrl:
                                              'https://onlinefamilypharmacy.com/images/itemmaingroupimages/' +
                                                  data[index].imageUrl,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          progressIndicatorBuilder:
                                              (context, url, progress) =>
                                                  Center(
                                            child: CircularProgressIndicator(
                                              value: progress.progress,
                                              color: Colors.black,
                                            ),
                                          ),
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
                                            overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}

// ignore: non_constant_identifier_names
GridViewer(context, data) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  final containerh = height / 2;
  if (height > 450 && width > 450 && width < 835) {
    //samsung tab vertical |
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1),
            crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemGroup(
                          itemid: data[index].id,
                          itemtitle: data[index].title)));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                //  height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFFECEFF1),
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://onlinefamilypharmacy.com/images/itemmaingroupimages/' +
                          data[index].imageUrl,
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ),
            ),
          );
        });
  } else if (width > 450 && width < 835) {
    //samsung A51 horizontal _____
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 0.5),
            crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemGroup(
                          itemid: data[index].id,
                          itemtitle: data[index].title)));
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://onlinefamilypharmacy.com/images/itemmaingroupimages/' +
                            data[index].imageUrl,
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
              print(data[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemGroup(
                          itemid: data[index].id,
                          itemtitle: data[index].title)));
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://onlinefamilypharmacy.com/images/itemmaingroupimages/' +
                            data[index].imageUrl,
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
  } else {
    //samsung A51 horizontal _____
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 0.45),
            crossAxisCount: 5),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemGroup(
                          itemid: data[index].id,
                          itemtitle: data[index].title)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //  height: containerh,
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
                        'https://onlinefamilypharmacy.com/images/itemmaingroupimages/' +
                            data[index].imageUrl,
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
  }
}

class TheSearch extends SearchDelegate<String> {
  TheSearch({this.contextPage, this.controller, @required this.data});

  List<ItemMainGroupModel> data;
  BuildContext contextPage;
  WebViewController controller;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.black,
    );
  }

  @override
  String get searchFieldLabel => "Search Main Group";

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
    return GridViewer(
        context,
        data
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return GridViewer(
        context,
        data
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }
}
