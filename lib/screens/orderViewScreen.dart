// This Screen is only for mobile

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testing/Apis/LeadsScreenApi.dart';
import 'package:http/http.dart' as http;
import 'package:responsify/responsify.dart';
import 'package:testing/Common/common.dart';
import 'package:testing/models/LogsModel.dart';
import 'package:testing/models/OrderView.dart';
import 'package:testing/screens/webViewCostInvoice.dart';

import 'TimelineCustom.dart';

// ignore: must_be_immutable
class OrderView extends StatefulWidget {
  OrderViewModel customerInfo;
  bool isTablet;
  OrderView({Key key, @required this.customerInfo, @required this.isTablet})
      : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  List<CustomerContact> customerRowInfo = []; // contact details
  List<OrderDetailView> listItems = [];

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
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesorderview.php';
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
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesorder_itemview.php';
    var leadDataId = {
      'id': leadId,
    };
    var response =
        await http.post(Uri.parse(baseUrl), body: json.encode(leadDataId));

    if (response.statusCode == 200) {
      List jsonDecoded = json.decode(response.body);

      listItems = jsonDecoded.map((e) => OrderDetailView.fromJson(e)).toList();

      return listItems;
    } else {
      return listItems = [];
    }
  }

  List<LogsModel> logs = [];
  Future getLogs(String leadId) async {
    final String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/logs.php';
    var leadDataId = {'id': leadId, 'pagename': 'SALESORDER'};
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
                widget.customerInfo.orderId,
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
                      color: (widget.customerInfo.status == '-1' ||
                              widget.customerInfo.status == '5')
                          ? Colors.amber
                          : (widget.customerInfo.status == '0' ||
                                      widget.customerInfo.status == '2') ||
                                  (widget.customerInfo.status == '3')
                              ? Colors.red
                              : (widget.customerInfo.status == '11' ||
                                      widget.customerInfo.status == '1')
                                  ? Colors.green
                                  : Colors.blue,
                      borderRadius: BorderRadius.circular(16.0)),
                  child: widget.customerInfo.status == '-1'
                      ? Text(
                          'Draft',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        )
                      : (widget.customerInfo.status == '5')
                          ? Text(
                              'Partial Picklist Generated',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            )
                          : (widget.customerInfo.status == '0')
                              ? Text(
                                  'Not Approved',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                )
                              : widget.customerInfo.status == '3'
                                  ? Text(
                                      'Cancelled',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    )
                                  : widget.customerInfo.status == '2'
                                      ? Text(
                                          'Rejected',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        )
                                      : widget.customerInfo.status == '11'
                                          ? Text(
                                              "Approved",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            )
                                          : widget.customerInfo.status == '1'
                                              ? Text(
                                                  'Approved & Sent',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                )
                                              : Text(
                                                  'Picklist Generated',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                )),
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
                                  'Document No - ${widget.customerInfo.whichcompany + "/" + widget.customerInfo.whichbranch + "/" + widget.customerInfo.soorderprifix + "/" + widget.customerInfo.orderId}'),
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
                                  'Employee - ${widget.customerInfo.employeeid}'),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                  'QN Prefix - ${widget.customerInfo.soorderprifix}'),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10.0),
                            //   child: Text(
                            //       'Local PO Number - ${widget.customerInfo.customerlocalpo}'),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10.0),
                            //   child: Text(
                            //       'Local PO Date - ${widget.customerInfo.customerlocalpodate}'),
                            // ),
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
                                child: Text('Customer Type - '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Billing On - '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Invoice Price - '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Invoice Type '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Credit Limit - '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Credit Days '),
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
                                    'Created On - ${widget.customerInfo.orderDate}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('RFQ Date - '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                    'Last Bid Date - ${widget.customerInfo.orderDatetime}'),
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
                            'Document No - ${widget.customerInfo.whichcompany + "/" + widget.customerInfo.whichbranch + "/" + widget.customerInfo.soorderprifix + "/" + widget.customerInfo.orderId}'),
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
                            'Employee - ${widget.customerInfo.employeeid}'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Customer Type - '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Billing On - '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Invoice Price - '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Invoice Type '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Credit Limit - '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Credit Days '),
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
                            'Created On - ${widget.customerInfo.orderDate}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('RFQ Date - '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Last Bid Date - ${widget.customerInfo.orderDatetime}'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'QN Prefix - ${widget.customerInfo.soorderprifix}'),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Text(
                      //       'Local PO Number - ${widget.customerInfo.customerlocalpo}'),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Text(
                      //       'Local PO Date - ${widget.customerInfo.customerlocalpodate}'),
                      // ),
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
                future: getLeadsDetails(widget.customerInfo.orderId),
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
                        columnSpacing: 30,
                        headingRowColor:
                            MaterialStateProperty.all(Colors.grey.shade300),
                        headingTextStyle: TextStyle(color: Colors.black),
                        columns: [
                          DataColumn(label: Text('Sr No')),
                          DataColumn(
                              label: Text(
                                  'Code')), // image , name of product , itemcode

                          DataColumn(label: Text('Units')),
                          DataColumn(label: Text('Price')),
                          DataColumn(label: Text('Qty')),
                          DataColumn(label: Text('FOC')),
                          DataColumn(label: Text('Ex Foc')),
                          DataColumn(label: Text('Disc Price')),
                          DataColumn(label: Text('Disc %')),
                          DataColumn(label: Text('')),
                          DataColumn(label: Text('Total')),
                          DataColumn(label: Text('Remarks')),
                          DataColumn(label: Text('S')),
                        ],
                        rows: listItems
                            .map((data) => DataRow(cells: [
                                  DataCell(Text(
                                    '',
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.itemcode + " - " + data.itemName,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.units + " - " + data.packing,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.orderItemPrice,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.orderItemQuantity,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.foc,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.extrabonus,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.disprice,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    data.percentageDiscountprice,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(data.discountallotment == '1'
                                      ? Icon(Icons.check_box)
                                      : Icon(Icons.crop_square)),
                                  DataCell(Text(
                                    data.orderItemFinalAmount,
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(Text(
                                    '',
                                    style: TextStyle(fontSize: 13),
                                  )),
                                  DataCell(data.stockreserved == '1'
                                      ? Icon(Icons.check_box)
                                      : Icon(Icons.crop_square)),
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
            Center(
              child: Text(
                'Cost Invoice',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Container(
              height: 400,
              child: CostInvoice(
                pagename: 'SALESORDER',
                id: widget.customerInfo.orderId,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            FutureBuilder(
                future: getLogs(widget.customerInfo.orderId),
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
          ],
        ),
      ),
    );
  }
}

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<OrderViewModel> leadList = [];
  List<OrderViewModel> searchResultList = [];
  bool isSearching = false;
  String searchText = '';
  bool isLoading = true;

  final TextEditingController searchController = new TextEditingController();

  Future getListofLeads() async {
    String url =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesorderview.php';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      setState(() {
        isLoading = false;
        leadList = jsonResponse
            .map((job) => new OrderViewModel.fromJson(job))
            .toList();
      });
      return leadList;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  bool isLeadClicked = false;
  OrderViewModel selectedLead;

  _OrderScreenState() {
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        setState(() {
          isSearching = false;
          searchText = "";
        });
      } else {
        setState(() {
          isSearching = true;
          searchText = searchController.text;
        });
      }
    });
  }

  @override
  void initState() {
    getListofLeads();
    super.initState();
  }

  void searchOperation(String searchText) {
    searchResultList.clear();
    if (isSearching != null) {
      for (int i = 0; i < leadList.length; i++) {
        OrderViewModel data = leadList[i];
        if (data.leadid.toLowerCase().contains(searchText.toLowerCase())) {
          searchResultList.add(data);
        }
      }
    }
  }

  //  void searchOperation(String searchText) {
  //   searchResultList.clear();
  //   if (isSearching != null) {
  //     for (int i = 0; i < leadList.length; i++) {
  //       LeadList data = leadList[i];
  //       if (data.id.toLowerCase().contains(searchText.toLowerCase())) {
  //         searchResultList.add(data);
  //       }
  //     }
  //   }

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
                    title: Text('Sales Order'),
                    backgroundColor: Colors.black,
                    elevation: 0.0,
                  ),
                  body: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            alignment: Alignment.topCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextField(
                                    textAlign: TextAlign.left,
                                    controller: searchController,
                                    onChanged: (value) {
                                      setState(() {
                                        searchOperation(searchController.text);
                                      });
                                      // isSearching
                                      //     ? _handleSearchEnd()
                                      //     : _handleSearchStart();
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Order Id',
                                      hintStyle: TextStyle(fontSize: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      fillColor: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                searchResultList.length != 0 ||
                                        searchController.text.isNotEmpty
                                    ? ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                              color: Colors.grey,
                                            ),
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: searchResultList.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isLeadClicked = true;
                                                  selectedLead =
                                                      searchResultList[index];
                                                });
                                              },
                                              child: OrderList(
                                                  item:
                                                      searchResultList[index]));
                                        })
                                    : ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                              color: Colors.grey,
                                            ),
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: leadList.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isLeadClicked = true;
                                                  selectedLead =
                                                      leadList[index];
                                                });
                                              },
                                              child: OrderList(
                                                  item: leadList[index]));
                                        }),
                              ],
                            ),
                          ),
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
                                ? OrderView(
                                    customerInfo: selectedLead,
                                    isTablet: true,
                                  )
                                : Center(
                                    child: Text(
                                      'Select a Order to View its Details',
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
                    title: Text('Sales Order'),
                    backgroundColor: Colors.black,
                    elevation: 0.0,
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            textAlign: TextAlign.left,
                            controller: searchController,
                            onChanged: (value) {
                              setState(() {
                                searchOperation(searchController.text);
                              });
                              // isSearching
                              //     ? _handleSearchEnd()
                              //     : _handleSearchStart();
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Enter Order Id',
                              hintStyle: TextStyle(fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              fillColor: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        searchResultList.length != 0 ||
                                searchController.text.isNotEmpty
                            ? ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                      color: Colors.grey,
                                    ),
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: searchResultList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => OrderView(
                                                      customerInfo:
                                                          searchResultList[
                                                              index],
                                                      isTablet: false,
                                                    )));
                                      },
                                      child: OrderList(
                                          item: searchResultList[index]));
                                })
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                itemCount: leadList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => OrderView(
                                                      customerInfo:
                                                          leadList[index],
                                                      isTablet: false,
                                                    )));
                                      },
                                      child: OrderList(item: leadList[index]));
                                }),
                      ],
                    ),
                  ),
                );
              }
            },
          );
  }
}
