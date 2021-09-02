import 'dart:convert';
import 'package:fmc_salesman/Sales_Order/generate_sales_order.dart';
import 'package:fmc_salesman/home/chart.dart';
import 'package:fmc_salesman/home/home.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String cust_id;
String credit_limit;
String credit_days;
String cust_type;
String cust_email, cust_name, invoiceprice, selectedcustbranch;
getStringValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  cust_email = prefs.getString('cust_email');
  print(cust_email);
  cust_type = prefs.getString('cust_type');
  print(cust_type);
  credit_days = prefs.getString('credit_days');
  print(credit_days);
  credit_limit = prefs.getString('credit_limit');
  print(credit_limit);
  cust_id = prefs.getString('cust_id');
  print(cust_id);
  cust_name = prefs.getString('cust_name');
  print(cust_name);
  invoiceprice = prefs.getString('invoiceprice');
  print(invoiceprice);
  selectedcustbranch = prefs.getString('selectedcustbranch');
  print(selectedcustbranch);
}

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  @override
  void initState() {
    super.initState();
    getStringValues();
  }

  clearcust() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("________________________________________________________");
    print(preferences.toString());
    await preferences.clear();
    await preferences.commit();
    final snackBar =
        SnackBar(content: Text('Data Cleared! Lets Generate new Order'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Generate_Sales()));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        //AppDrawer(),
        cust_id == null
            ? Text('')
            : Container(
                constraints: BoxConstraints.expand(height: 50),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    //padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Chip(
                            backgroundColor: LightColor.blueColor,
                            label: Text(
                              cust_id,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Chip(
                            backgroundColor: LightColor.blueColor,
                            label: Text(
                              cust_name,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          if (selectedcustbranch == null)
                            (Chip(
                              backgroundColor: LightColor.blueColor,
                              label: Text(
                                '',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ))
                          else
                            (Chip(
                              backgroundColor: LightColor.blueColor,
                              label: Text(
                                selectedcustbranch,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )),
                          SizedBox(
                            width: 10,
                          ),
                          // Chip(
                          //   backgroundColor: LightColor.blueColor,
                          //   label: Text(
                          //     cust_type,
                          //     style: TextStyle(
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.white),
                          //   ),
                          // ),   SizedBox(width: 10,),
                          Chip(
                            backgroundColor: LightColor.blueColor,
                            label: Text(
                              invoiceprice,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              print("HIIIIIIIIIIIIIII");
                              clearcust();
                            },
                            child: Icon(
                              Icons.clear,
                              size: 20,
                              color: LightColor.black,
                            ),
                          )
                        ]))),
        /* Container(

              constraints: BoxConstraints.expand(
                  height: height/0.2

              ),
             child: Chart(),

            ),
           Container(

              constraints: BoxConstraints.expand(
                  height: 200

              ),
              child: SliderDemo(),

            ),



            Container(
              //  constraints: BoxConstraints.expand(
              //    height: 500

              //   ),
              child: SliderGrid(),
            ),*/
      ]),
    );
  }
}

class Job {
  final String img;

  Job({
    this.img,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      img: json['img'],
    );
  }
}

class SliderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Job> data = snapshot.data;
          return imageSlider(context, data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(LightColor.whiteColor),
        ));
      },
    );
  }

  Future<List<Job>> _fetchJobs() async {
    final jobsListAPIUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=slider';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Swiper imageSlider(context, data) {
  return new Swiper(
    autoplay: true,
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      return new Image.network(
        'https://onlinefamilypharmacy.com/images/sliderimages/' +
            data[index].img,
        fit: BoxFit.fitWidth,
        width: 300,
      );
    },

    //viewportFraction: 0.2,

    scale: 1.0,
  );
}
