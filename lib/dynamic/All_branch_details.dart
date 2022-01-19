import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/dynamic/All_branch.dart';

// ignore: must_be_immutable
class BranchDetails extends StatefulWidget {
  allbranch todo;

  BranchDetails({Key key, @required this.todo}) : super(key: key);

  @override
  _BranchDetailsState createState() => _BranchDetailsState();
}

class _BranchDetailsState extends State<BranchDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool visible = false;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String emailValue = prefs.getString('email');
    return emailValue;
  }

  int itemid;
  int counter = 1;
  //final productprice;
  double finalprice;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //List<int> sizeList = [7, 8, 9, 10];
    
    //List<Color> colorsList = [Colors.black, Colors.blue, Colors.red];

  
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: LightColor.yellowColor,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.todo.branchecommercename,
            style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
        // backgroundColor: LightColor.midnightBlue,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  //padding: EdgeInsets.only(left: 15, right: 15),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Container(
                        // padding: EdgeInsets.only(left: 15, right: 15),
                        height: 300.0,
                        width: 500.0,
                        child: Swiper(
                          autoplay: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return new Image.network(
                              'http://sharegiants.in/ruchi/images/branch/' +
                                  widget.todo.img,
                              //fit: BoxFit.fitWidth,
                              height: 500, width: 500,
                            );
                          },
                          viewportFraction: 0.7,
                          scale: 0.1,
                        ),
                      ),
                      // SizedBox(),

                      /*  Positioned.fill(
                        child: Image.network(
                          widget.todo.url,
                        ),
                      ),*/
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          widget.todo.branchecommercename,
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      SizedBox(height: 10),

                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          widget.todo.email,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 10),

                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          widget.todo.shortdescription,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Text(
                      //  finalprice.toString(),
                      // ),
                      Card(
                        // height: 150.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(top: 10.0, left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Address",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(children: <Widget>[
                                    Text(
                                      "\Bldg No - ${widget.todo.buildingno},",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "\  Street No - ${widget.todo.street},",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(children: <Widget>[
                                    Text(
                                      "${widget.todo.streetname} ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      widget.todo.city,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " ${widget.todo.country},",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        // height: 150.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(top: 10.0, left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.call,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        child: Text(
                                          " Contact",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Tel.: 4130156",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Whatsapp: 70481608",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Email: pharmacy01@fmc.qa",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),

                      SizedBox(height: 10),
                      Card(
                        // height: 150.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(top: 10.0, left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.watch_later,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        child: Text(
                                          " Opening Hours",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Sat - Fri 8.00 AM to 10.00 PM",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ))
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: Colors.black,
    ));
  }
}
