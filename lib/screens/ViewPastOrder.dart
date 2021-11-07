import 'package:flutter/material.dart';
import 'package:responsify/responsify.dart';
import 'package:testing/Apis/CartPage.dart';
import 'package:testing/models/PastOrders.dart';

class ViewPastOrder extends StatefulWidget {
  ViewPastOrder({Key key}) : super(key: key);

  @override
  _ViewPastOrderState createState() => _ViewPastOrderState();
}

class _ViewPastOrderState extends State<ViewPastOrder> {
  @override
  void initState() {
    super.initState();
    fetchPastOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Text(
          "Past Order History",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ResponsiveUiWidget(
        targetOlderComputers: true,
        builder: (context, deviceInfo) {
          if (deviceInfo.deviceTypeInformation ==
                  DeviceTypeInformation.TABLET &&
              deviceInfo.orientation == Orientation.landscape) {
            return FutureBuilder<List<PastOrder>>(
                future: fetchPastOrder(),
                builder: (context, snapshot) {
                  List<PastOrder> pastOrder = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data.length == 0) {
                      return Center(
                        child: Text("No Previous Orders were placed"),
                      );
                    } else if (snapshot.data.length > 0) {
                      return SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                          width: double.infinity,
                          child: DataTable(
                            showBottomBorder: true,
                            headingRowHeight: 50,
                            columnSpacing: 120,
                            headingRowColor:
                                MaterialStateProperty.all(Colors.black),
                            headingTextStyle: TextStyle(color: Colors.white),
                            // dataRowColor:
                            //     MaterialStateProperty.all(Colors.grey),
                            columns: [
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Quantity')),
                              DataColumn(label: Text('FOC')),
                              DataColumn(label: Text('Extra FOC')),
                              DataColumn(label: Text('Discount')),
                            ],
                            rows: pastOrder
                                .map((data) => DataRow(cells: [
                                      DataCell(Container(
                                          width: 70,
                                          child: Text(
                                            data.orderDate,
                                            style: TextStyle(fontSize: 13),
                                          ))),
                                      DataCell(Container(
                                          width: 20,
                                          child: Text(
                                            data.orderItemQuantity,
                                            style: TextStyle(fontSize: 13),
                                          ))),
                                      DataCell(Container(
                                          width: 40,
                                          child: Text(
                                            data.foc,
                                            style: TextStyle(fontSize: 13),
                                          ))),
                                      DataCell(Container(
                                          width: 50,
                                          child: Text(
                                            data.extrabonus,
                                            style: TextStyle(fontSize: 13),
                                          ))),
                                      DataCell(Container(
                                          width: 40,
                                          child: Text(
                                            data.disprice,
                                            style: TextStyle(fontSize: 13),
                                          ))),
                                    ]))
                                .toList(),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Some Error Occured"),
                      );
                    }
                  }
                  return Center(
                    child: LinearProgressIndicator(),
                  );
                });
          }
          return Center(
            child: Text("Unsupported Device Type"),
          );
        },
      ),
    );
  }
}
