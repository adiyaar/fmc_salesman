import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/models/SearchScreenModel.dart';

import 'DetailPageScreen.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({Key key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool selected = false;
  List selectedItemMainGroup = [];
  List manf = [];
  List imgid = [];
  List mnfid = [];
  List<ItemMainGroup> mainGroupOptions = [];
  List<Manufactures> manufactureOptions = [];
  Future<List<ItemMainGroup>> fetchItemMainGroupList() async {
    final String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/categories/itemmaingroup.php?action=itemmaingroup';
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      mainGroupOptions.addAll(jsonResponse
          .map((itemmaingroup) => new ItemMainGroup.fromJson(itemmaingroup)));
      print(mainGroupOptions.length);
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
      manufactureOptions
          .addAll(jsonResponse.map((e) => new Manufactures.fromJson(e)));
      return jsonResponse.map((e) => new Manufactures.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  // @override
  // void dispose() {
  //   selectedItemMainGroup = [];
  //   manf = [];
  //   imgid = [];
  //   mnfid = [];
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {
            mnfid.isNotEmpty
                ? Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => FilteredScreen(
                              manufacture: true,
                              id: mnfid.first,
                            )))
                : Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => FilteredScreen(
                              manufacture: false,
                              id: imgid.first,
                            )));
          },
          label: Text('Apply')),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Filter Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Item main Group',
              style: TextStyle(color: Colors.black, fontSize: 17.0),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.2,
              // width: MediaQuery.of(context).size.width / 2.2,
              child: FutureBuilder<List<ItemMainGroup>>(
                future: fetchItemMainGroupList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ItemMainGroup> data = snapshot.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            value: selectedItemMainGroup
                                .contains(data[index].etitle.trim()),
                            onChanged: (value) {
                              setState(() {
                                // selected = !selected;
                                if (value == true) {
                                  selectedItemMainGroup
                                      .add(data[index].etitle.trim());
                                  imgid.add(data[index].id.trim());
                                } else {
                                  selectedItemMainGroup
                                      .remove(data[index].etitle.trim());
                                  imgid.remove(data[index].id.trim());
                                }
                              });
                              print(imgid);
                            },
                            title: Text(data[index].etitle),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ));
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Manufactures',
              style: TextStyle(color: Colors.black, fontSize: 17.0),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.2,
              child: FutureBuilder<List<Manufactures>>(
                future: fetchManufactures(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Manufactures> data = snapshot.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            value: manf.contains(data[index].etitle.trim()),
                            onChanged: (value) {
                              setState(() {
                                // selected = !selected;
                                if (value == true) {
                                  manf.add(data[index].etitle.trim());
                                  mnfid.add(data[index + 1].id.trim());
                                } else {
                                  manf.remove(data[index].etitle.trim());
                                  mnfid.remove(data[index + 1].id.trim());
                                }
                              });
                              print(mnfid);
                            },
                            title: Text(data[index].title),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilteredScreen extends StatefulWidget {
  final String id;
  bool manufacture;
  FilteredScreen({Key key, @required this.id, @required this.manufacture})
      : super(key: key);

  @override
  _FilteredScreenState createState() => _FilteredScreenState();
}

class _FilteredScreenState extends State<FilteredScreen> {
  List<SearchList> a;
  Future<List<SearchList>> fetchAllItem(String id, bool mf) async {
    final baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmansearchallproducts.php';
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      a = mf == true
          ? jsonResponse
              .map((e) => new SearchList.fromJson(e))
              .where((element) => element.manufactureid == id)
              .toList()
          : jsonResponse
              .map((e) => new SearchList.fromJson(e))
              .where((element) => element.itemmaingroupid == id)
              .toList();
      return a;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('All Your Filtered Products'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.1,
              child: FutureBuilder(
                  future: fetchAllItem(widget.id, widget.manufacture),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<SearchList> data = snapshot.data;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => DetailPageScreen(
                                              itemDetails: data[index],
                                              customerType: 'Wholesale',
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
                                              height: 100,
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
                                  title:
                                      Text(data[index].itemproductgrouptitle),
                                  subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          "\QR ${data[index].minwholesaleprice}" +
                                              " - " +
                                              "\QR ${data[index].maxwholesaleprice}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ])),
                            );
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
