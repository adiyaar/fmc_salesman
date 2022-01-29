import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsify/responsify_files/responsify_enum.dart';
import 'package:responsify/responsify_files/responsify_ui_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/Common/ItemGroupLoader.dart';
import 'package:testing/Common/ItemTabletLoader.dart';
import 'package:testing/models/ItemGroupModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'CartPage.dart';
import 'ItemSubScreen.dart';

class ItemGroup extends StatefulWidget {
  List userInfo;
  final itemid;
  final itemtitle;

  ItemGroup(
      {Key key,
      @required this.itemid,
      @required this.itemtitle,
      @required this.userInfo})
      : super(key: key);
  @override
  _ItemGroupState createState() => _ItemGroupState();
}

class _ItemGroupState extends State<ItemGroup> with TickerProviderStateMixin {
  AnimationController animationController;
  List<ItemGroupModel> data;
  String pharmacyname = "";

  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: TheSearch(data: data, userInfo: widget.userInfo),
      query: pharmacyname,
    );
  }

  void _fetchdata() async {
    data = await _fetchItemGrpData();
    setState(() {});
  }

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

  @override
  void initState() {
    super.initState();
    fetchCrtCOunt();
    _fetchdata();
    animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
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
                icon: Icon(Icons.search)),
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  tooltip: 'MainGroup',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartPage(useriNfo: widget.userInfo,)));
                  },
                ),
                CircleAvatar(
                  radius: 9,
                  backgroundColor: Colors.yellow,
                  child: Visibility(
                    visible: a != null,
                    child: Text(
                      '$a',
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
                                  // printdata[index].id);
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => ItemSub(
                                              userInfo: widget.userInfo,
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
                                        CachedNetworkImage(
                                          progressIndicatorBuilder:
                                              (context, url, progress) =>
                                                  Center(
                                            child: CircularProgressIndicator(
                                              value: progress.progress,
                                              color: Colors.black,
                                            ),
                                          ),
                                          imageUrl:
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
                      return Horizonatal();
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
                                    childAspectRatio: 1.1, crossAxisCount: 6),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => ItemSub(
                                              userInfo: widget.userInfo,
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
                                      CachedNetworkImage(
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                            valueColor: animationController
                                                .drive(ColorTween(
                                                    begin: Colors.blueAccent,
                                                    end: Colors.red)),
                                          ),
                                        ),
                                        imageUrl:
                                            'https://onlinefamilypharmacy.com/images/itemgroupimages/' +
                                                data[index].imageurl,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                      ),
                                      SizedBox(height: 10),
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
                      return ItemmTablet();
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
                                  // printdata[index].id);
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => ItemSub(
                                              userInfo: widget.userInfo,
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
                                          CachedNetworkImage(
                                            progressIndicatorBuilder:
                                                (context, url, progress) =>
                                                    Center(
                                              child: CircularProgressIndicator(
                                                value: progress.progress,
                                                color: Colors.black,
                                              ),
                                            ),
                                            imageUrl:
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
                      return ItemGroupLoaderMobile();
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

Grid(context, data, userInfo) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  final containerh = height / 2;
  if (height > 450 && width > 450 && width < 835) {
    // print'samsung tab vertical |');
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.2, crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // // printdata[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          userInfo: userInfo,
                          itemsubid: data[index].id,
                          itemetitle: data[index].title)));
            },
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
                  CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                        color: Colors.black,
                      ),
                    ),
                    imageUrl:
                        'https://onlinefamilypharmacy.com/images/itemgroupimages/' +
                            data[index].imageurl,
                    height: MediaQuery.of(context).size.height / 5.6,
                    width: MediaQuery.of(context).size.width / 2,
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
          );
        });
  } else if (width > 450 && width < 835) {
    // print'samsung A51 horizontal _____');
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 0.5),
            crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // // printdata[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          userInfo: userInfo,
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
              // // printdata[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          userInfo: userInfo,
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
              // // printdata[index].id);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          userInfo: userInfo,
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
                ),
              ),
            ),
          );
        });
  }
}

class TheSearch extends SearchDelegate<String> {
  List userInfo;
  TheSearch(
      {this.contextPage,
      this.controller,
      @required this.data,
      @required this.userInfo});

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
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList(),
        userInfo);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Grid(
        context,
        data
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList(),
        userInfo);
  }
}
