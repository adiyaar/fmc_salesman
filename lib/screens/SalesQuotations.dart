import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:testing/models/SalesQuotationModel.dart';
import 'package:testing/screens/ViewDetailSalesQuotation.dart';

List<SalesQuotationModel> quotationList = [];
bool isLoading = true;

class SalesQuotation extends StatefulWidget {
  final List user;
  SalesQuotation({Key key, @required this.user}) : super(key: key);

  @override
  State<SalesQuotation> createState() => _SalesQuotationState();
}

class _SalesQuotationState extends State<SalesQuotation> {
  final DataTableSource tableList = MyDataTable();

  Future getAllData() async {
    final baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/salesorderview.php';

    var cacheExists =
        await APICacheManager().isAPICacheKeyExist('SalesQuotation');
    var response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      // APICacheDBModel cacheDBModel =
      //     new APICacheDBModel(key: 'SalesQuotation', syncData: response.body);

      // await APICacheManager().addCacheData(cacheDBModel);

      setState(() {
        quotationList = jsonResponse
            .map((e) => new SalesQuotationModel.fromJson(e))
            .toList();

        isLoading = false;
      });

      return quotationList;

      // if (!cacheExists) {
      //   var response = await http.get(Uri.parse(baseUrl));
      //   if (response.statusCode == 200) {
      //     List jsonResponse = json.decode(response.body);

      //     APICacheDBModel cacheDBModel =
      //         new APICacheDBModel(key: 'SalesQuotation', syncData: response.body);

      //     await APICacheManager().addCacheData(cacheDBModel);

      //     setState(() {
      //       quotationList = jsonResponse
      //           .map((e) => new SalesQuotationModel.fromJson(e))
      //           .toList();

      //       isLoading = false;
      //     });

      //     return quotationList;
      //   }
      // } else {
      //   print('CACHE HIT');
      //   var cacheData = await APICacheManager().getCacheData('SalesQuotation');

      //   List jsoncached = json.decode(cacheData.syncData);

      //   setState(() {
      //     quotationList =
      //         jsoncached.map((e) => new SalesQuotationModel.fromJson(e)).toList();
      //     isLoading = false;
      //   });

      //   return quotationList;
      // }
    }
  }

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text('Sales Order'), backgroundColor: Colors.black),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : RefreshIndicator(
                onRefresh: () => getAllData(),
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ViewSaleQuotation()));
                        },
                        child: PaginatedDataTable(
                            rowsPerPage: 10,
                            showCheckboxColumn: false,
                            showFirstLastButtons: true,
                            columns: [
                              DataColumn(label: Text('S.No')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Document No')),
                              DataColumn(label: Text('Customer Name')),
                              DataColumn(label: Text('Salesman')),
                              DataColumn(label: Text('Customer Email')),
                              DataColumn(label: Text('Amount')),
                              DataColumn(label: Text('Lead/QnId')),
                              DataColumn(label: Text('Stage')),
                            ],
                            source: tableList),
                      )
                    ],
                  ),
                ),
              ));
  }
}

class MyDataTable extends DataTableSource {
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Text(
          '${index + 1}',
          style: TextStyle(fontSize: 13),
        ),
      ),
      DataCell(Text(
        quotationList[index].orderDatetime,
        style: TextStyle(fontSize: 13),
      )),
      DataCell(Text(
        '${quotationList[index].whichcompany}/${quotationList[index].whichbranch}/${quotationList[index].soorderprifix}/${quotationList[index].orderId}',
        style: TextStyle(fontSize: 13),
      )),
      DataCell(Text(
        quotationList[index].customername,
        style: TextStyle(fontSize: 13),
      )),
      DataCell(Text(
        quotationList[index].employeename,
        style: TextStyle(fontSize: 13),
      )),
      DataCell(Text(
        quotationList[index].customeremail == null ||
                quotationList[index].customeremail == ''
            ? 'No Email'
            : quotationList[index].customeremail,
        style: TextStyle(fontSize: 13),
      )),
      DataCell(Text(
        quotationList[index].orderTotalAfterTax,
        style: TextStyle(fontSize: 13),
      )),
      DataCell(Text(
        quotationList[index].leadid,
        style: TextStyle(fontSize: 13),
      )),
      DataCell(Text(
        quotationList[index].status,
        style: TextStyle(fontSize: 13),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => quotationList.length;

  @override
  int get selectedRowCount => 0;
}
