import 'package:flutter/material.dart';
import 'package:testing/models/LeadModel.dart';
import 'package:testing/models/OrderView.dart';
import 'package:testing/models/QutationView.dart';
import 'package:testing/models/pickListModel.dart';
import 'package:testing/models/salesInvoiceModel.dart';

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

// QUOTATION VIEW EMAIL LIST TILE

class QuotationList extends StatelessWidget {
  const QuotationList({
    Key key,
    @required this.item,
  }) : super(key: key);

  final QuotationViewModel item;

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
                    item?.orderDate ?? "",
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
                            item.leadid +
                            "/" +
                            item.custid ??
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
                    "Reference No - ${item?.leadid ?? ""}",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                  ),
                  Text(
                    "Type of Lead - ${item?.orderId ?? ""}",
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
                        Container(
                            // margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(8.0),

                            // height: 40,
                            // width: 100,

                            decoration: BoxDecoration(
                                color: (item.status == '-11' ||
                                            item.status == '4') ||
                                        (item.status == '-1')
                                    ? Colors.amber
                                    : (item.status == '1' ||
                                            item.status == '11')
                                        ? Colors.green
                                        : (item.status == '0')
                                            ? Colors.red
                                            : (item.status == '2')
                                                ? Colors.blue
                                                : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(12.0)),
                            child: item.status == '-11'
                                ? Text(
                                    'Draft',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black),
                                  )
                                : (item.status == '-1')
                                    ? Text(
                                        'Draft',
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.black),
                                      )
                                    : (item.status == '4')
                                        ? Text(
                                            'PO Attached',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black),
                                          )
                                        : item.status == '11'
                                            ? Text(
                                                'Approved',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              )
                                            : item.status == '1'
                                                ? Text(
                                                    'Approved & Sent',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  )
                                                : item.status == '2'
                                                    ? Text(
                                                        "SO Generated",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : item.status == '0'
                                                        ? Text(
                                                            'Not Approved',
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        : Text(
                                                            'QN Cancelled',
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white),
                                                          )),
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

// ORDER VIEW LIST TILE

class OrderList extends StatelessWidget {
  const OrderList({
    Key key,
    @required this.item,
  }) : super(key: key);

  final OrderViewModel item;

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
                    item.whichbranch ?? "",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item?.orderDate ?? "",
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
                            item.leadid +
                            "/" +
                            item.custid ??
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
                    "Reference No - ${item?.leadid ?? ""}",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                  ),
                  Text(
                    "Type of Lead - ${item?.orderId ?? ""}",
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
                        Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color:
                                    (item.status == '-1' || item.status == '5')
                                        ? Colors.amber
                                        : (item.status == '0' ||
                                                    item.status == '2') ||
                                                (item.status == '3')
                                            ? Colors.red
                                            : (item.status == '11' ||
                                                    item.status == '1')
                                                ? Colors.green
                                                : Colors.blue,
                                borderRadius: BorderRadius.circular(16.0)),
                            child: item.status == '-1'
                                ? Text(
                                    'Draft',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  )
                                : (item.status == '5')
                                    ? Text(
                                        'Partial Picklist Generated',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      )
                                    : (item.status == '0')
                                        ? Text(
                                            'Not Approved',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          )
                                        : item.status == '3'
                                            ? Text(
                                                'Cancelled',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              )
                                            : item.status == '2'
                                                ? Text(
                                                    'Rejected',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  )
                                                : item.status == '11'
                                                    ? Text(
                                                        "Approved",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : item.status == '1'
                                                        ? Text(
                                                            'Approved & Sent',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        : Text(
                                                            'Picklist Generated',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
                                                          )),
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

// PICK LIST

class PickListTile extends StatelessWidget {
  const PickListTile({
    Key key,
    @required this.item,
  }) : super(key: key);

  final PickListModel item;

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
                    item.whichbranch ?? "",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item?.orderDate ?? "",
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
                            item.leadid +
                            "/" +
                            item.custid ??
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
                    "Reference No - ${item?.leadid ?? ""}",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                  ),
                  Text(
                    "Type of Lead - ${item?.orderId ?? ""}",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        // width: 100,
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: (item.status == '100' || item.status == '3')
                                ? Colors.grey
                                : (item.status == '1' || item.status == '4')
                                    ? Colors.green
                                    : (item.status == '0' || item.status == '6')
                                        ? Colors.red
                                        : (item.status == '5')
                                            ? Colors.blue
                                            : Colors.amber,
                            borderRadius: BorderRadius.circular(16.0)),
                        child: item.status == '100'
                            ? Text(
                                'Cancelled Picklist',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )
                            : (item.status == '3')
                                ? Text(
                                    'Cartonization',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  )
                                : (item.status == '1')
                                    ? Text(
                                        'Approved',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )
                                    : item.status == '4'
                                        ? Text(
                                            'Approved By Manager',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          )
                                        : item.status == '0'
                                            ? Text(
                                                'Picklist Generated',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              )
                                            : item.status == '6'
                                                ? Text(
                                                    "Delivery Note Generated",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  )
                                                : item.status == '5'
                                                    ? Text(
                                                        'Sales Invoice Generated',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : Text(
                                                        'Draft',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black),
                                                      ),
                      ),
                    ],
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

// INVOICE

class InvoiceTile extends StatelessWidget {
  const InvoiceTile({
    Key key,
    @required this.item,
  }) : super(key: key);

  final SalesInvoice item;

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
                    item.whichbranch ?? "",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item?.orderDate ?? "",
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
                            item.leadid +
                            "/" +
                            item.custid ??
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
                    "Reference No - ${item?.leadid ?? ""}",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                  ),
                  Text(
                    "Type of Lead - ${item?.orderId ?? ""}",
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
                            visible: item.status == "-1",
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  "Draft",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ))),
                        Visibility(
                            visible: item.status == "1",
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text("Goods Delivered",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)))),
                        Visibility(
                            visible: item.status == "0",
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text("Goods Not Delivered",
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
