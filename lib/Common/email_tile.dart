import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:gmail_clone/data/classes/email.dart';
import 'package:intl/intl.dart';
import 'package:testing/models/LeadModel.dart';

class EmailListTile extends StatelessWidget {
  const EmailListTile({
    Key key,
    @required this.item,
  }) : super(key: key);

  final LeadList item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              radius: 32.0,
              backgroundColor: Colors.grey.shade300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item?.whichbranch ?? "",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item?.dateofrfq ?? "",
                    style: TextStyle(color: Colors.black, fontSize: 9),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.whichcompany +
                            "/" +
                            item.whichbranch +
                            "/" +
                            item.leadprifix +
                            "/" +
                            item.id ??
                        "",
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Customer Name - ${item?.customername ?? ""}",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                  ),
                  Text(
                    "Reference No - ${item?.leadno ?? ""}",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                  ),
                  Text(
                    "Type of Lead - ${item?.typeoflead ?? ""}",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      children: <Widget>[
                        Visibility(
                            visible: item.status == "1",
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  "Lead Approved",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ))),
                        Visibility(
                            visible: item.status == "11",
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text("Lead Generated",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10)))),
                        Visibility(
                            visible: item.status == "-1",
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text("Drafts",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)))),
                        // Visibility(
                        //     visible: item.status == "2" &&
                        //         item.quotationprifix == null,
                        //     child: Container(
                        //         padding: EdgeInsets.all(8.0),
                        //         decoration: BoxDecoration(
                        //             color: Colors.primaries[Random()
                        //                 .nextInt(Colors.primaries.length)],
                        //             borderRadius: BorderRadius.circular(12)),
                        //         child: Text("QN Generated But Not Approved"))),
                        Visibility(
                            visible: item.status == "2",
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text("QN Cancelled",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)))),
                        Visibility(
                            visible: item.status == "3",
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text("PO Attached",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)))),
                        Visibility(
                            visible: item.status == "4",
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text("SO Generated",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)))),
                        // Visibility(
                        //     visible: item.status == "100", child: Text("QN Cancelled")),
                        Visibility(
                            visible: item.status == "101",
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text("Lead Cancelled",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)))),
                        Visibility(
                            visible: item.status == "102",
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text("Lead Rejected",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)))),
                        Visibility(
                            visible: item.status == "1000",
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text("Lead Deleted",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
