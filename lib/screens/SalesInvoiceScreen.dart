import 'package:flutter/material.dart';
import 'package:responsify/responsify_files/responsify_enum.dart';
import 'package:responsify/responsify_files/responsify_ui_widget.dart';
import 'package:testing/Apis/LeadsScreenApi.dart';
import 'package:testing/Common/email_tile.dart';
import 'package:testing/models/LogsModel.dart';
import 'package:testing/models/salesInvoiceModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:testing/screens/webViewCostInvoice.dart';

import 'TimelineCustom.dart';

class InvoiceMobile extends StatefulWidget {
  final SalesInvoice customerInfo;
  final bool isTablet;
  InvoiceMobile({Key key, @required this.customerInfo, @required this.isTablet})
      : super(key: key);

  @override
  State<InvoiceMobile> createState() => _InvoiceMobileState();
}

class _InvoiceMobileState extends State<InvoiceMobile> {
  List<CustomerContact> customerRowInfo = []; // contact details
  List<SalesInvoiceDetail> listItems = [];

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
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesinvoice_itemview.php';
    var leadDataId = {
      'id': leadId,
    };
    var response =
        await http.post(Uri.parse(baseUrl), body: json.encode(leadDataId));

    if (response.statusCode == 200) {
      List jsonDecoded = json.decode(response.body);

      listItems =
          jsonDecoded.map((e) => SalesInvoiceDetail.fromJson(e)).toList();

      return listItems;
    } else {
      return listItems = [];
    }
  }

  List<LogsModel> logs = [];
  Future getLogs(String leadId) async {
    final String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/logs.php';
    var leadDataId = {'id': leadId, 'pagename': 'SALESINVOICE'};
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
                    color: (widget.customerInfo.status == '-1')
                        ? Colors.amber
                        : (widget.customerInfo.status == '1')
                            ? Colors.green
                            : Colors.red,
                    borderRadius: BorderRadius.circular(16.0)),
                child: widget.customerInfo.status == '1'
                    ? Text(
                        'Goods Delivered',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    : (widget.customerInfo.status == '-1')
                        ? Text(
                            'Draft',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )
                        : Text(
                            'Goods Not Delivered',
                            style: TextStyle(fontSize: 14, color: Colors.white),
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
                                  'Document No - ${widget.customerInfo.whichcompany}/${widget.customerInfo.whichbranch}/${widget.customerInfo.custid}/${widget.customerInfo.orderId} '),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text('Lead Source - '),
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
                              child: Text('Credit Limit - '),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text('Credit Days '),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text('Customer Allow Foc- }'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text('Customer Status - '),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text('Print Template - '),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text('Request Date '),
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
                                    'Lead Id - ${widget.customerInfo.leadid}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Local PO Number - '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Local PO Date - '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Delivery Before - '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Attachment of Local PO'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                    'Document No - ${widget.customerInfo.whichcompany}/${widget.customerInfo.whichbranch}/${widget.customerInfo.picklistid}/${widget.customerInfo.orderId} '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Lead Source - '),
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
                                child: Text('Credit Limit - '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Credit Days '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Customer Allow Foc- }'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Customer Status - '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Print Template - '),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Request Date '),
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
                            'Salesman - ${widget.customerInfo.employeeid}  ${widget.customerInfo.employeename}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Salesman Email Id - '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Customer - ${widget.customerInfo.customername}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Sent By - '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Contact Details - '),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Lead Id - ${widget.customerInfo.leadid}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Local PO Number - '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Local PO Date - '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Delivery Before - '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Attachment of Local PO'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Document No - ${widget.customerInfo.whichcompany}/${widget.customerInfo.whichbranch}/${widget.customerInfo.picklistid}/${widget.customerInfo.orderId} '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Lead Source - '),
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
                        child: Text('Credit Limit - '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Credit Days '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Customer Allow Foc- }'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Customer Status - '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Print Template - '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Request Date '),
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
                          DataColumn(label: Text('Code')),
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
                                  DataCell(data.batch == '1'
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
                pagename: 'SALESINVOICE',
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
          ],
        ),
      ),
    );
  }
}

class InvoiceScreen extends StatefulWidget {
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  List<SalesInvoice> leadList = [];
  List<SalesInvoice> searchResultList = [];
  bool isSearching = false;
  String searchText = '';
  bool isLoading = true;

  final TextEditingController searchController = new TextEditingController();

  Future getListofLeads() async {
    String url =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesinvoiceview.php';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      setState(() {
        isLoading = false;
        leadList =
            jsonResponse.map((job) => new SalesInvoice.fromJson(job)).toList();
      });
      return leadList;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  bool isLeadClicked = false;
  SalesInvoice selectedLead;

  _InvoiceScreenState() {
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
        SalesInvoice data = leadList[i];
        if (data.leadid.toLowerCase().contains(searchText.toLowerCase())) {
          searchResultList.add(data);
        }
      }
    }
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
                    title: Text('Sales Invoice'),
                    backgroundColor: Colors.black,
                    elevation: 0.0,
                  ),
                  body: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            height: double.maxFinite,
                            width: MediaQuery.of(context).size.width / 3,
                            alignment: Alignment.topCenter,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
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
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Sales Id',
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
                                              child: InvoiceTile(
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
                                              child: InvoiceTile(
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
                                // ? null
                                ? InvoiceMobile(
                                    customerInfo: selectedLead,
                                    isTablet: true,
                                  )
                                : Center(
                                    child: Text(
                                      'Select a Invoice to View its Details',
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
                    title: Text('Sales Quotation'),
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
                              hintText: 'Enter Qutation Id',
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
                                                builder: (_) => InvoiceMobile(
                                                      customerInfo:
                                                          searchResultList[
                                                              index],
                                                      isTablet: false,
                                                    )));
                                      },
                                      child: InvoiceTile(
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
                                                builder: (_) => InvoiceMobile(
                                                      customerInfo:
                                                          leadList[index],
                                                      isTablet: false,
                                                    )));
                                      },
                                      child:
                                          InvoiceTile(item: leadList[index]));
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
