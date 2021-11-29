import 'dart:convert';
//import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsify/responsify_files/responsify_enum.dart';
import 'package:responsify/responsify_files/responsify_ui_widget.dart';
import 'package:testing/models/ItemSubGroupModel.dart';

import 'ItemGroupList.dart';
import 'ItemSubGroupList.dart';

class ItemSub extends StatefulWidget {
  final itemsubid;
  final itemetitle;

  ItemSub({Key key, @required this.itemsubid, @required this.itemetitle})
      : super(key: key);
  @override
  _ItemSubState createState() => _ItemSubState();
}

class _ItemSubState extends State<ItemSub> {
  @override
  void initState() {
    super.initState();
    _fetchItemSubData();
  }

  Future<List<ItemSubGroupModel>> _fetchItemSubData() async {
    final url =
        'https://onlinefamilypharmacy.com/mobileapplication/categories/itemsubgroup.php';
    var data = {'itemsubid': widget.itemsubid};
    var response = await http.post(Uri.parse(url), body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((job) => new ItemSubGroupModel.fromJson(job))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemetitle),
        backgroundColor: Colors.black,
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
                child: FutureBuilder<List<ItemSubGroupModel>>(
                  future: _fetchItemSubData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ItemSubGroupModel> data = snapshot.data;
                      if (snapshot.data.length == 0) {
                        return ListItems(
                          itemnull: widget.itemsubid,
                        );
                      }

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
                                        builder: (context) => SubList_Items(
                                            sublist: data[index].id,
                                            title: data[index].title)));
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
                                            'https://onlinefamilypharmacy.com/images/itemsubgroupimages/' +
                                                data[index].imageurl,
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
                child: FutureBuilder<List<ItemSubGroupModel>>(
                  future: _fetchItemSubData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ItemSubGroupModel> data = snapshot.data;
                      if (snapshot.data.length == 0) {
                        return ListItems(
                          itemnull: widget.itemsubid,
                        );
                      }
                      return GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1.1, crossAxisCount: 6),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                print('going to sublist');
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => SubList_Items(
                                            sublist: data[index].id,
                                            title: data[index].title)));
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
                                          'https://onlinefamilypharmacy.com/images/itemsubgroupimages/' +
                                              data[index].imageurl,
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
                child: FutureBuilder<List<ItemSubGroupModel>>(
                  future: _fetchItemSubData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length == 0) {
                        return ListItems(
                          itemnull: widget.itemsubid,
                        );
                      }
                      List<ItemSubGroupModel> data = snapshot.data;
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
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => SubList_Items(
                                            sublist: data[index].id,
                                            title: data[index].title)));
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
                                              'https://onlinefamilypharmacy.com/images/itemsubgroupimages/' +
                                                  data[index].imageurl,
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

Grid(context, data) {
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
              // Navigator.push(context,
              //     new MaterialPageRoute(builder: (context) =>
              //         SubList_Items(
              //           sublist: data[index].id, title: data[index].title,))
              // );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: 160,
                width: 120,
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
                      'https://onlinefamilypharmacy.com/images/itemsubgroupimages/' +
                          data[index].url,
                      height: containerh / 2.5,
                      width: width / 2,
                    ),
                    // Image.network(data[index].url, height: 150, width: 200,),
                    Container(
                      height: containerh / 15,
                      width: width / 2,
                      child: Text(
                        data[index].title,
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
              // Navigator.push(context,
              //     new MaterialPageRoute(builder: (context) =>
              //         SubList_Items(
              //           sublist: data[index].id, title: data[index].title,))
              // );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                //height: 160,
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
                        'https://onlinefamilypharmacy.com/images/itemsubgroupimages/' +
                            data[index].url,
                        height: containerh / 1.5,
                        width: width / 2,
                      ),
                      // Image.network(data[index].url, height: 150, width: 200,),
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
              // Navigator.push(context,
              //     new MaterialPageRoute(builder: (context) =>
              //         SubList_Items(
              //           sublist: data[index].id, title: data[index].title,))
              // );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                //  height: 160,
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
                        'https://onlinefamilypharmacy.com/images/itemsubgroupimages/' +
                            data[index].url,
                        height: containerh / 3.5,
                        width: width / 2,
                      ),
                      // Image.network(data[index].url, height: 150, width: 200,),
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
              // Navigator.push(context,
              //     new MaterialPageRoute(builder: (context) =>
              //         SubList_Items(
              //           sublist: data[index].id, title: data[index].title,))
              // );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: 160,
                width: 120,
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
                        'https://onlinefamilypharmacy.com/images/itemsubgroupimages/' +
                            data[index].url,
                        height: containerh / 1.5,
                        width: width / 2,
                      ),
                      // Image.network(data[index].url, height: 150, width: 200,),
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
