import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class branch_add extends StatefulWidget {
  @override
  _branch_add_State createState() => _branch_add_State();
}

class _branch_add_State extends State<branch_add> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final msgController = TextEditingController();
  Future usermsg() async {
    String firstname = fnameController.text;
    String lastname = lnameController.text;
    String mobileno = mobileController.text;
    String email = emailController.text;
    String msg = msgController.text;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (mobileno.length != 8) {
      showInSnackBar("Invalid Mobile No");
      //showToast('Invalid Mobile No', gravity: Toast.BOTTOM, duration: 3);
    } else if (firstname.length == 0 ||
        lastname.length == 0 ||
        msg.length == 0) {
      showInSnackBar("Field Should not be empty");
    } else if (!regex.hasMatch(email)) {
      showInSnackBar("Enter Valid Email");
    } else {
      // SERVER API URL
      var url = 'http://sharegiants.in/ruchi/contactform.php';

      // Store all data with Param Name.
      var data = {
        'firstname': firstname,
        'lastname': lastname,
        'mobileno': mobileno,
        'email': email,
        'msg': msg,
      };

      // Starting Web API Call.
      var response = await http.post(Uri.parse(url), body: json.encode(data));



      // Getting Server response into variable.
      var message = jsonDecode(response.body);

      // If Web call Success than Hide the CircularProgressIndicator.

      showInSnackBar(message);
      fnameController.clear();
      lnameController.clear();
      mobileController.clear();
      emailController.clear();
      msgController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  bool _pwenabledisable = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: LightColor.yellowColor,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Add Branch',
          style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
        // backgroundColor: LightColor.midnightBlue,
      ),

      body: new SingleChildScrollView(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),



            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Branch Name ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ])),
            Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width / 1.1,
                        child: TextField(

                          //controller: msgController,//if this will be dynamic then only it wil come
                          decoration: InputDecoration(
                            hintText: "Enter Name of Branch",
                              //labelText: "Name",
                              //labelStyle: TextStyle(
                               // color: Colors.black
                              //),
                              //border:UnderlineInputBorder(),
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true),

                        ),
                      ),
                    ])),



            SizedBox(height: 10),



            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Password ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ])),
            Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width / 1.1,
                        child: TextField(

                          //controller: msgController,//if this will be dynamic then only it wil come
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(_pwenabledisable ? Icons.remove_red_eye : Icons.filter_tilt_shift),
                                onPressed: (){
                                   setState(() {
                                     _pwenabledisable = !_pwenabledisable;

                                   });
                                },
                              ),


                              hintText: "Password",
                              //labelText: "Name",
                              //labelStyle: TextStyle(
                              // color: Colors.black
                              //),
                              //border:UnderlineInputBorder(),
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true),

                          obscureText: _pwenabledisable,

                        ),
                      ),
                    ])),









            SizedBox(height: 10),

            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width / 2.3,
                        child: Text(
                          "Arabic Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        width: width / 38,
                      ),
                      Container(
                        width: width / 2.3,
                        child: Text(
                          "Ecommerce Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ])),
            Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width / 2.3,
                        child: TextField(

                          controller: fnameController,
                          decoration: InputDecoration(
                              hintText: "Enter Name of Branch",
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                        ),
                      ),
                      SizedBox(
                        width: width / 38,
                      ),
                      Container(
                        width: width / 2.3,
                        child: TextField(
                          controller: lnameController,
                          decoration: InputDecoration(
                              hintText: "Enter Name of Branch",
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                        ),
                      )
                    ])),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width / 2.3,
                        child: Text(
                          "Email ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        width: width / 38,
                      ),
                      Container(
                        width: width / 2.3,
                        child: Text(
                          "Phone",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ])),
            Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width / 2.3,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Enter Email Id",
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true,
                            //prefixIcon: Icon(Icons.email),
                            //icon: Icon(Icons.email)
                            // suffixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,  // password jaisa hoga if true
                        ),
                      ),
                      SizedBox(
                        width: width / 38,
                      ),
                      Container(
                        width: width / 2.3,
                        child: TextField(
                          controller: mobileController,
                          decoration: InputDecoration(
                              hintText: "Enter Contact No",
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ])),
            SizedBox(height: 10),
            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Notes",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ])),
            Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width / 1.1,
                        child: TextField(
                          maxLines: 8,
                          maxLength: 1000,
                          controller: msgController,
                          decoration: InputDecoration(
                              hintText: "Enter Notes",
                              enabledBorder: const OutlineInputBorder(
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: const BorderSide(color: Color(0xFFc5c5c9), width: 0.0),
                              ),
                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                        ),
                      ),
                    ])),
            SizedBox(height: 10),



            Center(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black)),
                onPressed: () {
                  usermsg();
                },
                color: Colors.black,
                textColor: Colors.white,
                child: Text("Add", style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 20),

          ],
        ),
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
