import 'package:flutter/material.dart';

//import 'package:testing/detail_page.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
//import 'package:robustremedy/screen/Item_group_screen/item_group.dart';
//import 'package:robustremedy/themes/light_color.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

import 'package:testing/widget/NavigationDrawer.dart';

class Brand {
  final String url;
  final String title;
  final String id;
  Brand({this.url, this.title, this.id});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      url: json['image'],
      title: json['title'],
      id: json['id'],
    );
  }
}

class RangeSliderData {
  double min;
  double max;
  double lowerValue;
  double upperValue;
  int divisions;
  bool showValueIndicator;
  int valueIndicatorMaxDecimals;
  bool forceValueIndicator;
  Color overlayColor;
  Color activeTrackColor;
  Color inactiveTrackColor;
  Color thumbColor;
  Color valueIndicatorColor;
  Color activeTickMarkColor;

  static const Color defaultActiveTrackColor = Colors.black;
  static const Color defaultInactiveTrackColor = const Color(0x3d0175c2);
  static const Color defaultActiveTickMarkColor = const Color(0x8a0175c2);
  static const Color defaultThumbColor = const Color(0xFF0175c2);
  static const Color defaultValueIndicatorColor = const Color(0xFF0175c2);
  static const Color defaultOverlayColor = const Color(0x290175c2);

  RangeSliderData({
    this.min,
    this.max,
    this.lowerValue,
    this.upperValue,
    this.divisions,
    this.showValueIndicator: true,
    this.valueIndicatorMaxDecimals: 1,
    this.forceValueIndicator: false,
    this.overlayColor: defaultOverlayColor,
    this.activeTrackColor: defaultActiveTrackColor,
    this.inactiveTrackColor: defaultInactiveTrackColor,
    this.thumbColor: defaultThumbColor,
    this.valueIndicatorColor: defaultValueIndicatorColor,
    this.activeTickMarkColor: defaultActiveTickMarkColor,
  });

  // Returns the values in text format, with the number
  // of decimals, limited to the valueIndicatedMaxDecimals
  //
  String get lowerValueText =>
      lowerValue.toStringAsFixed(valueIndicatorMaxDecimals);
  String get upperValueText =>
      upperValue.toStringAsFixed(valueIndicatorMaxDecimals);

  // Builds a RangeSlider and customizes the theme
  // based on parameters
  //
  Widget build(BuildContext context, frs.RangeSliderCallback callback) {
    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              minWidth: 40.0,
              maxWidth: 40.0,
            ),
            child: Text(lowerValueText),
          ),
          Expanded(
            child: SliderTheme(
              // Customization of the SliderTheme
              // based on individual definitions
              // (see rangeSliders in _RangeSliderSampleState)
              data: SliderTheme.of(context).copyWith(
                overlayColor: overlayColor,
                activeTickMarkColor: activeTickMarkColor,
                activeTrackColor: activeTrackColor,
                inactiveTrackColor: inactiveTrackColor,
                //trackHeight: 8.0,
                thumbColor: thumbColor,
                valueIndicatorColor: valueIndicatorColor,
                showValueIndicator: showValueIndicator
                    ? ShowValueIndicator.always
                    : ShowValueIndicator.onlyForDiscrete,
              ),
              child: frs.RangeSlider(
                min: min,
                max: max,
                lowerValue: lowerValue,
                upperValue: upperValue,
                divisions: divisions,
                showValueIndicator: showValueIndicator,
                valueIndicatorMaxDecimals: valueIndicatorMaxDecimals,
                onChanged: (double lower, double upper) {
                  // call
                  callback(lower, upper);
                },
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minWidth: 40.0,
              maxWidth: 40.0,
            ),
            child: Text(upperValueText),
          ),
        ],
      ),
    );
  }
}

class ItemData {
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
  final String itemgroupid;
  ItemData(
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
      this.itemgroupid});

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
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
        itemgroupid: json['itemgroupid']);
  }
}

class ItemMainData {
  final String url;
  final String title;
  final String id;
  ItemMainData({this.url, this.title, this.id});

  factory ItemMainData.fromJson(Map<String, dynamic> json) {
    return ItemMainData(
      id: json['id'],
      url: json['image'],
      title: json['etitle'],
    );
  }
}

class Itemmaster extends StatefulWidget {
  Itemmaster() : super();

  final String title = "Filter List Demo";

  @override
  ItemmasterState createState() => ItemmasterState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class ItemmasterState extends State<Itemmaster> {
  // https://jsonplaceholder.typicode.com/users
  var search = false;
  var filter = false;
  var sort;
  var itemname;
  var itemmaingroup;
  var chipdata = false;
  final _debouncer = Debouncer(milliseconds: 500);
  List<RangeSliderData> rangeSliders;

  double _lowerValue = 0.0;
  double _upperValue = 500.0;
  double _lowerValueFormatter = 0.0;
  double _upperValueFormatter = 500.0;

  @override
  void initState() {
    super.initState();
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
              "Item Master",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.format_align_center,
                    color: Colors.white,
                  ),
                onPressed: () {
                  showMaterialModalBottomSheet(
                      expand: false,
                      context: context,
                      builder: (context) {
                        final width = MediaQuery.of(context).size.width;
                        return Container(
                            height: 360.0,
                            width: width,
                            child: ListView(children: <Widget>[
                              //   ..add(
                              //
                              // Simple example
                              //
                              Center(child: Text('Price range from 0 to 500')),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(children: <Widget>[
                                  Text(_lowerValueFormatter.toString()),
                                  Container(
                                    width: width / 1.3,
                                    child: frs.RangeSlider(
                                      min: 0.0,
                                      max: 500.0,
                                      lowerValue: _lowerValueFormatter,
                                      upperValue: _upperValueFormatter,
                                      divisions: 10,
                                      showValueIndicator: true,
                                      valueIndicatorMaxDecimals: 1,
                                      onChanged: (double newLowerValue,
                                          double newUpperValue) {
                                        setState(() {
                                          _lowerValue = newLowerValue;
                                          _upperValue = newUpperValue;

                                          _fetchItemData();
                                        });
                                      },
                                      onChangeStart: (double startLowerValue,
                                          double startUpperValue) {},
                                      onChangeEnd: (double newLowerValue,
                                          double newUpperValue) {},
                                    ),
                                  ),
                                  Text(_upperValueFormatter.toString()),
                                ]),
                              ),
                              //   ),
                              SizedBox(height: 20),
                              Divider(
                                color: Colors.grey[200],
                                height: 20,
                                thickness: 10,
                              ),

                              ListTile(
                                leading: Image.asset('assets/az.png',
                                    color: Colors.black, height: 24),
                                title: Text('Name A To Z'),
                                onTap: () {
                                  setState(() {
                                    filter = true;
                                    sort = 'asc';
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                              ListTile(
                                leading: Image.asset('assets/za.png',
                                    color: Colors.black, height: 24),
                                title: Text('Name Z To A'),
                                onTap: () {
                                  setState(() {
                                    filter = true;
                                    sort = 'desc';
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.arrow_upward,
                                    color: Colors.black, size: 30),
                                title: Text('Price low to high'),
                                onTap: () {
                                  setState(() {
                                    filter = true;
                                    sort = 'ltoh';
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.arrow_downward,
                                    color: Colors.black, size: 30),
                                title: Text('Price high to low'),
                                onTap: () {
                                  setState(() {
                                    filter = true;
                                    sort = 'htol';
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                            ]));
                      });
                },

                  ),
            ]),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              height: 60,
              decoration: BoxDecoration(color: Colors.black87),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0, top: 0, bottom: 0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        width: width / 1,
                        child: TextField(
                          autofocus: true,
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            hintText: "Search Medicines / Healthcare Products",
                          ),
                          onChanged: (string) {
                            setState(() {
                              itemname = string;
                              search = true;
                            });
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
            if ((search == true) & (filter == false))
              (Container(
                height: height / 1.22,
                child: FutureBuilder<List<ItemData>>(
                  future: _fetchItemData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ItemData> data = snapshot.data;
                      //filterdata(data);
                      return Grid(context, data);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ));
                  },
                ),
              ))
            else if ((search == true) & (filter == true))
              (Container(
                height: height / 1.3,
                child: FutureBuilder<List<ItemData>>(
                  future: _fetchItemData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ItemData> data = snapshot.data;
                      filterdata(data);
                      return Grid(context, data);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ));
                  },
                ),
              ))
            else
              (Container(
                height: height / 1.3,
                child: FutureBuilder<List<ItemData>>(
                  future: _fetchItemData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ItemData> data = snapshot.data;
                      filterdata(data);
                      return Grid(context, data);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ));
                  },
                ),
              )),
          ],
        )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }

  chipview(context, data) {
    return Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              // var finalprice = data[index].price;
              return InkWell(
                onTap: () {
                  itemmaingroup = data[index].id;

                  search = true;
                  chipdata = true;
                  Navigator.of(context).pop();
                  _fetchItemData();
                },
                // var finalprice = data[index].price;

                child: Column(
                  children: <Widget>[
                    Container(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                          spacing: 5.0,
                          runSpacing: 3.0,
                          children: <Widget>[
                            Chip(
                              backgroundColor: Colors.black,
                              label: Text(
                                data[index].title,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ]),
                    ))
                  ],
                ),
              );
            }));
  }

  Future<List<Brand>> _fetchJobs() async {
    final jobsListAPIUrl =
        'http://sharegiants.in/ruchi/manufacture.php?action=fetch_all';
    final response = await http.get(Uri.parse(jobsListAPIUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Brand.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<List<ItemMainData>> _fetchItemMainData() async {
    final jobsListAPIUrl =
        'http://sharegiants.in/ruchi/itemmaingroup.php?action=fetch_all';
    final response = await http.get(Uri.parse(jobsListAPIUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new ItemMainData.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id = prefs.getString('id');
    return user_id;
  }

  Future user_search(itemid, itemproductgroupid) async {
    dynamic token = await getStringValues();
    final jobsListAPIUrl =
        'http://sharegiants.in/ruchi/user_search_history.php';
    var data = {
      'userid': token,
      'itemid': itemid,
      'itemproductgroupid': itemproductgroupid
    };
    var response = await http.post(Uri.parse(jobsListAPIUrl), body: json.encode(data));
  }

  Future<List<ItemData>> _fetchSearchData() async {
    dynamic token = await getStringValues();
    final jobsListAPIUrl =
        'http://sharegiants.in/ruchi/get_user_search_history.php';
    var data = {'userid': token};
    var response = await http.post(Uri.parse(jobsListAPIUrl), body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new ItemData.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<List<ItemData>> _fetchItemData() async {
    final jobsListAPIUrl = 'http://sharegiants.in/ruchi/search_api.php';
    
    var data = {
      'itemname': itemname,
      '_lowerValue': _lowerValue,
      '_upperValue': _upperValue,
      'itemmaingroup': itemmaingroup
    };
    var response = await http.post(Uri.parse(jobsListAPIUrl), body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new ItemData.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  filterdata1(List<ItemData> data) {
    return data;
  }

  filterdata(List<ItemData> data) {
    data = data;
    if (sort == 'asc') {
      data.sort((a, b) {
        return a.itemproductgrouptitle.compareTo(b.itemproductgrouptitle);
      });
    } else if (sort == 'desc') {
      data.sort((b, a) {
        return a.itemproductgrouptitle.compareTo(b.itemproductgrouptitle);
      });
    } else if (sort == 'ltoh') {
      data.sort((a, b) {
        return a.maxretailprice.compareTo(b.maxretailprice);
      });
    } else if (sort == 'htol') {
      data.sort((e, f) {
        return f.maxretailprice.compareTo(e.maxretailprice);
      });
    }
  }

  GridSearch(context, data) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListDetails(todo: data[index])));
                                                       */
          },
          // var finalprice = data[index].price;

          child: Column(
            children: <Widget>[
              Container(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(spacing: 5.0, runSpacing: 3.0, children: <Widget>[
                  Chip(
                    backgroundColor: Colors.white,
                    label: Text(
                      data[index].itemname_en,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ]),
              ))
            ],
          ),
        );
      },
    );
  }

  Grid(context, data) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              user_search(data[index].itemid, data[index].itemproductgroupid);
              /* Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListDetails(todo: data[index]))); */
            },
            // var finalprice = data[index].price;
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white12,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300], width: 1.5),
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
                            BoxShadow(color: Colors.black12, blurRadius: 5.0)
                          ],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'http://sharegiants.in/ruchi/images/item/' +
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
                                    fontSize: 13.0,
                                    color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ]),
                          SizedBox(height: 5),
                          getprice(data[index].maxretailprice,
                              data[index].minretailprice),

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
}

getprice(max, min) {
  if (max == min) {
    return Row(children: <Widget>[
      Expanded(
        child: Text(
          "\QR ${max}",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  } else {
    return Row(children: <Widget>[
      Text(
        "\QR ${max}",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
        overflow: TextOverflow.ellipsis,
      ),
      Text(" - "),
      Text(
        "\QR ${min}",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }
}