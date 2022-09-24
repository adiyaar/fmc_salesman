// This Screen is only for mobile

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testing/Apis/LeadsScreenApi.dart';
import 'package:testing/models/LeadModel.dart';
import 'package:http/http.dart' as http;
import 'package:testing/models/LogsModel.dart';

import 'TimelineCustom.dart';

// ignore: must_be_immutable
class LeadDetailViewMobileScreen extends StatefulWidget {
  LeadList customerInfo;
  bool isTablet;
  LeadDetailViewMobileScreen(
      {Key key, @required this.customerInfo, @required this.isTablet})
      : super(key: key);

  @override
  State<LeadDetailViewMobileScreen> createState() =>
      _LeadDetailViewMobileScreenState();
}

class _LeadDetailViewMobileScreenState
    extends State<LeadDetailViewMobileScreen> {
  List<CustomerContact> customerRowInfo = []; // contact details
  List<LeadDetailView> listItems = [];

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      setState(() {
        getCustomerInfo(widget.customerInfo.customername);
      });
    });

    super.initState();
  }

  Future getCustomerInfo(String customerName) async {
    final String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/leadtelephonedetails.php';
    var response = await http.get(
      Uri.parse(baseUrl),
    );

    if (response.statusCode == 200) {
      List jsonDecoded = json.decode(response.body);

      customerRowInfo =
          jsonDecoded.map((e) => CustomerContact.fromJson(e)).toList();

      return customerRowInfo;
    } else {
      setState(() {
        customerRowInfo = [];
      });
      return customerRowInfo;
    }
  }

  Future getLeadsDetails(String leadId) async {
    final String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/leaditemview.php';
    var leadDataId = {
      'id': leadId,
    };
    var response =
        await http.post(Uri.parse(baseUrl), body: json.encode(leadDataId));

    if (response.statusCode == 200) {
      List jsonDecoded = json.decode(response.body);

      listItems = jsonDecoded.map((e) => LeadDetailView.fromJson(e)).toList();

      return listItems;
    } else {
      return listItems = [];
    }
  }

  List<LogsModel> logs = [];
  Future getLogs(String leadId) async {
    final String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/logs.php';
    var leadDataId = {'id': leadId, 'pagename': 'LEADS'};
    var response =
        await http.post(Uri.parse(baseUrl), body: json.encode(leadDataId));

    if (response.statusCode == 200) {
      List jsonDecoded = json.decode(response.body);
      logs = jsonDecoded.map((e) => LogsModel.fromJson(e)).toList();

      return logs;
    } else {
      return logs = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isTablet
          ? AppBar(
              toolbarHeight: 0,
              elevation: 0,
              automaticallyImplyLeading: false,
            )
          : AppBar(
              title: Text(
                widget.customerInfo.id,
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                height: 40,
                width: 160,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: (widget.customerInfo.status == '11' ||
                            widget.customerInfo.status == '3')
                        ? Colors.amber
                        : (widget.customerInfo.status == '1' ||
                                widget.customerInfo.status == '4')
                            ? Colors.green
                            : Colors.red,
                    borderRadius: BorderRadius.circular(16.0)),
                child: widget.customerInfo.status == '11'
                    ? Text(
                        'Lead Generated',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    : (widget.customerInfo.status == '1')
                        ? Text(
                            'Lead Approved',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )
                        : (widget.customerInfo.status == '-1')
                            ? Text(
                                'Draft',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )
                            : widget.customerInfo.status == '2'
                                ? Text(
                                    'QN Cancelled',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  )
                                : widget.customerInfo.status == '3'
                                    ? Text(
                                        'PO Attached',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )
                                    : widget.customerInfo.status == '4'
                                        ? Text(
                                            "SO Generated",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          )
                                        : widget.customerInfo.status == '101'
                                            ? Text(
                                                'Lead Cancelled',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              )
                                            : widget.customerInfo.status ==
                                                    '102'
                                                ? Text(
                                                    'Lead Rejected',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  )
                                                : Text(
                                                    'Lead Deleted',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            widget.isTablet
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width / 3) /
                            2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                  'Document No - ${widget.customerInfo.whichcompany + "/" + widget.customerInfo.whichbranch + "/" + widget.customerInfo.leadprifix + "/" + widget.customerInfo.id}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                  'Customer Name - ${widget.customerInfo.customername}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                  'Sent By - ${widget.customerInfo.typeoflead}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text('Contact Details - Not There'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                  'Employee - ${widget.customerInfo.employeecode}'),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                  'QN Prefix - ${widget.customerInfo.quotationprifix}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                  'Local PO Number - ${widget.customerInfo.customerlocalpo}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                  'Local PO Date - ${widget.customerInfo.customerlocalpodate}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text('Attachment of Local PO'),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: widget.isTablet,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                    'Customer Type - ${widget.customerInfo.customertype}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                    'Billing On - ${widget.customerInfo.billingon}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                    'Invoice Price - ${widget.customerInfo.invoiceprice}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                    'Invoice Type ${widget.customerInfo.invoicetype}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                    'Credit Limit - ${widget.customerInfo.creditlimits}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                    'Credit Days ${widget.customerInfo.creditdays}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Qtn Validity - }'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                    'Customer Status - ${widget.customerInfo.customerstatus}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                    'Lead Source - ${widget.customerInfo.typeoflead}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                    'Created On - ${widget.customerInfo.createdon}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('RFQ Date - '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                    'Last Bid Date - ${widget.customerInfo.lastbiddate}'),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Document No - ${widget.customerInfo.whichcompany + "/" + widget.customerInfo.whichbranch + "/" + widget.customerInfo.leadprifix + "/" + widget.customerInfo.id}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Customer Name - ${widget.customerInfo.customername}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child:
                            Text('Sent By - ${widget.customerInfo.typeoflead}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Contact Details - Not There'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Employee - ${widget.customerInfo.employeecode}'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Customer Type - ${widget.customerInfo.customertype}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Billing On - ${widget.customerInfo.billingon}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Invoice Price - ${widget.customerInfo.invoiceprice}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Invoice Type ${widget.customerInfo.invoicetype}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Credit Limit - ${widget.customerInfo.creditlimits}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Credit Days ${widget.customerInfo.creditdays}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Qtn Validity - }'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Customer Status - ${widget.customerInfo.customerstatus}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Lead Source - ${widget.customerInfo.typeoflead}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Created On - ${widget.customerInfo.createdon}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('RFQ Date - '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Last Bid Date - ${widget.customerInfo.lastbiddate}'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'QN Prefix - ${widget.customerInfo.quotationprifix}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Local PO Number - ${widget.customerInfo.customerlocalpo}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Local PO Date - ${widget.customerInfo.customerlocalpodate}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Attachment of Local PO'),
                      ),
                    ],
                  ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Contact Details',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                initialData: [],
                future: getCustomerInfo(widget.customerInfo.customername),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ));
                  } else if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        showBottomBorder: true,
                        headingRowHeight: 30,
                        dataRowHeight: 30,

                        // columnSpacing: 80,
                        headingRowColor:
                            MaterialStateProperty.all(Colors.grey.shade300),
                        headingTextStyle: TextStyle(color: Colors.black),

                        columns: [
                          DataColumn(
                              label: Text(
                                  'Department')), // image , name of product , itemcode

                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('TelePhone')),
                          DataColumn(label: Text('Mobile')),
                          DataColumn(label: Text('Whatsapp')),
                          DataColumn(label: Text('Email')),
                        ],
                        rows: customerRowInfo
                            .map((data) => DataRow(cells: [
                                  DataCell(Text(
                                    data.department,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.name,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.telephone,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.mobile,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.whatsapp,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.email,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                ]))
                            .toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error.toString()}'),
                    );
                  }
                  return CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  );
                }),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Item Details',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                initialData: [],
                future: getLeadsDetails(widget.customerInfo.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ));
                  } else if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        showBottomBorder: true,
                        headingRowHeight: 30,
                        dataRowHeight: 30,
                        columnSpacing: 120,
                        headingRowColor:
                            MaterialStateProperty.all(Colors.grey.shade300),
                        headingTextStyle: TextStyle(color: Colors.black),
                        columns: [
                          DataColumn(
                              label: Text(
                                  'Seq No')), // image , name of product , itemcode

                          DataColumn(label: Text('Code')),
                          DataColumn(label: Text('Description')),
                          DataColumn(label: Text('Unit')),
                          DataColumn(label: Text('Qty')),
                          DataColumn(label: Text('Note')),
                        ],
                        rows: listItems
                            .map((data) => DataRow(cells: [
                                  DataCell(Text(
                                    data.seq,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.code,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.description,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.unit,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.qty,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.notes,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                ]))
                            .toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error.toString()}'),
                    );
                  }
                  return CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black));
                }),
            SizedBox(
              height: 50,
            ),
            FutureBuilder(
                future: getLogs(widget.customerInfo.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ));
                  } else if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Timeline(
                      children: logs
                          .map((e) => ListTile(
                                title: Text(
                                  '${e.comment} By ${e.nameofuser} ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(e.updateon),
                              ))
                          .toList(),
                      indicators: logs
                          .map((e) => Icon(
                                Icons.circle,
                                color: Colors.blue,
                              ))
                          .toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error.toString()}'),
                    );
                  }
                  return CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black));
                }),

            // status = 1 , then hide all the button
            // status = 11 , then show 4 buttons
            // Center(
            //   child: Text(
            //     'Change status of Lead',
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16),
            //   ),
            // ),

            Visibility(
              visible: widget.customerInfo.status == '11',
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 10,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Lead Approved',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.green,
                        backgroundColor: Colors.green,
                        elevation: 1,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Lead Cancelled',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.grey,
                        backgroundColor: Colors.grey,
                        elevation: 1,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Lead Rejected',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.red,
                        backgroundColor: Colors.red,
                        elevation: 1,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Lead Deleted',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.red,
                        backgroundColor: Colors.red,
                        elevation: 1,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
