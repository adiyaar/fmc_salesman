import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsify/responsify.dart';
import 'package:testing/Apis/LeadsScreenApi.dart';
import 'package:testing/Common/common.dart';
import 'package:http/http.dart' as http;
import 'package:testing/models/LeadModel.dart';
import 'package:testing/screens/LeadDetailScreen.dart';

class LeadScreen extends StatefulWidget {
  @override
  _LeadScreenState createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  List<LeadList> leadList = [];
  bool isLoading = true;

  Future getListofLeads() async {
    String url =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/leadsview.php';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      setState(() {
        isLoading = false;
        leadList =
            jsonResponse.map((job) => new LeadList.fromJson(job)).toList();
      });
      return leadList;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  bool isLeadClicked = false;
  LeadList selectedLead;

  @override
  void initState() {
    getListofLeads();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : ResponsiveUiWidget(
            targetOlderComputers: true,
            builder: (context, deviceinfo) {
              if (deviceinfo.deviceTypeInformation ==
                      DeviceTypeInformation.TABLET &&
                  deviceinfo.orientation == Orientation.landscape) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Leads'),
                    backgroundColor: Colors.black,
                    elevation: 0.0,
                  ),
                  body: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          alignment: Alignment.topCenter,
                          child: ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey,
                                  ),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: leadList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        isLeadClicked = true;
                                        selectedLead = leadList[index];
                                      });
                                    },
                                    child:
                                        EmailListTile(item: leadList[index]));
                              }),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width / 3,
                            padding: EdgeInsets.only(left: 20, top: 20),
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 10))),
                            child: isLeadClicked
                                ? LeadDetailViewMobileScreen(
                                    customerInfo: selectedLead,
                                    isTablet: true,
                                  )
                                : Center(
                                    child: Text(
                                      'Select a Lead to View its Details',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 22),
                                    ),
                                  )),
                      ],
                    ),
                  ),
                );
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Leads'),
                    backgroundColor: Colors.black,
                    elevation: 0.0,
                  ),
                  body: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: leadList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          LeadDetailViewMobileScreen(
                                            customerInfo: leadList[index],
                                            isTablet: false,
                                          )));
                            },
                            child: EmailListTile(item: leadList[index]));
                      }),
                );
              }
            },
          );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(),
    );
  }
}

class AppSideMenu extends StatelessWidget {
  const AppSideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              IconButton(
                icon: Icon(Icons.inbox),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.people_outline),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.star_border),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
