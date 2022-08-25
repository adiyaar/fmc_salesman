class PickListModel {
  String orderDatetime;
  String whichcompany;
  String whichbranch;
  String orderId;
  String pkreferenceno;
  String pkorderprifix;
  String salesorderid;
  String leadid;
  String localrfqid;
  String customername;
  String custid;
  String customeremail;
  String employeeid;
  String employeename;
  String emailid;
  String orderDate;
  String status;
  String wholediscount;

  PickListModel(
      {this.orderDatetime,
      this.whichcompany,
      this.whichbranch,
      this.orderId,
      this.pkreferenceno,
      this.pkorderprifix,
      this.salesorderid,
      this.leadid,
      this.localrfqid,
      this.customername,
      this.custid,
      this.customeremail,
      this.employeeid,
      this.employeename,
      this.emailid,
      this.orderDate,
      this.status,
      this.wholediscount});

  PickListModel.fromJson(Map<String, dynamic> json) {
    orderDatetime = json['order_datetime'];
    whichcompany = json['whichcompany'];
    whichbranch = json['whichbranch'];
    orderId = json['order_id'];
    pkreferenceno = json['pkreferenceno'];
    pkorderprifix = json['pkorderprifix'];
    salesorderid = json['salesorderid'];
    leadid = json['leadid'];
    localrfqid = json['localrfqid'];
    customername = json['customername'];
    custid = json['custid'];
    customeremail = json['customeremail'];
    employeeid = json['employeeid'];
    employeename = json['employeename'];
    emailid = json['emailid'];
    orderDate = json['order_date'];
    status = json['status'];
    wholediscount = json['wholediscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_datetime'] = this.orderDatetime;
    data['whichcompany'] = this.whichcompany;
    data['whichbranch'] = this.whichbranch;
    data['order_id'] = this.orderId;
    data['pkreferenceno'] = this.pkreferenceno;
    data['pkorderprifix'] = this.pkorderprifix;
    data['salesorderid'] = this.salesorderid;
    data['leadid'] = this.leadid;
    data['localrfqid'] = this.localrfqid;
    data['customername'] = this.customername;
    data['custid'] = this.custid;
    data['customeremail'] = this.customeremail;
    data['employeeid'] = this.employeeid;
    data['employeename'] = this.employeename;
    data['emailid'] = this.emailid;
    data['order_date'] = this.orderDate;
    data['status'] = this.status;
    data['wholediscount'] = this.wholediscount;
    return data;
  }
}


class PickListDetails {
  String orderItemId;
  String salesorderid;
  String orderId;
  String itemreplacedwith;
  String itemcollected;
  String itemreplacement;
  String itemdeletednostock;
  String itemcode;
  String itemName;
  String units;
  String packing;
  String orderItemQuantity;
  String foc;
  String extrabonus;
  String disprice;
  String orderItemPrice;
  String orderItemActualAmount;
  String percentageDiscountprice;
  String orderItemFinalAmount;
  String expirydate;
  String batch;
  String stockbatchwise;
  String manufacturedate;
  String whichcompany;
  String whichbranch;
  String itemWhichcompany;
  String itemWac;
  String itemMgmtcost;
  String itemCutoffcost;
  String discountallotment;
  String calculationtotal;
  String cartonization;

  PickListDetails(
      {this.orderItemId,
      this.salesorderid,
      this.orderId,
      this.itemreplacedwith,
      this.itemcollected,
      this.itemreplacement,
      this.itemdeletednostock,
      this.itemcode,
      this.itemName,
      this.units,
      this.packing,
      this.orderItemQuantity,
      this.foc,
      this.extrabonus,
      this.disprice,
      this.orderItemPrice,
      this.orderItemActualAmount,
      this.percentageDiscountprice,
      this.orderItemFinalAmount,
      this.expirydate,
      this.batch,
      this.stockbatchwise,
      this.manufacturedate,
      this.whichcompany,
      this.whichbranch,
      this.itemWhichcompany,
      this.itemWac,
      this.itemMgmtcost,
      this.itemCutoffcost,
      this.discountallotment,
      this.calculationtotal,
      this.cartonization});

  PickListDetails.fromJson(Map<String, dynamic> json) {
    orderItemId = json['order_item_id'];
    salesorderid = json['salesorderid'];
    orderId = json['order_id'];
    itemreplacedwith = json['itemreplacedwith'];
    itemcollected = json['itemcollected'];
    itemreplacement = json['itemreplacement'];
    itemdeletednostock = json['itemdeletednostock'];
    itemcode = json['itemcode'];
    itemName = json['item_name'];
    units = json['units'];
    packing = json['packing'];
    orderItemQuantity = json['order_item_quantity'];
    foc = json['foc'];
    extrabonus = json['extrabonus'];
    disprice = json['disprice'];
    orderItemPrice = json['order_item_price'];
    orderItemActualAmount = json['order_item_actual_amount'];
    percentageDiscountprice = json['percentage_discountprice'];
    orderItemFinalAmount = json['order_item_final_amount'];
    expirydate = json['expirydate'];
    batch = json['batch'];
    stockbatchwise = json['stockbatchwise'];
    manufacturedate = json['manufacturedate'];
    whichcompany = json['whichcompany'];
    whichbranch = json['whichbranch'];
    itemWhichcompany = json['item_whichcompany'];
    itemWac = json['item_wac'];
    itemMgmtcost = json['item_mgmtcost'];
    itemCutoffcost = json['item_cutoffcost'];
    discountallotment = json['discountallotment'];
    calculationtotal = json['calculationtotal'];
    cartonization = json['cartonization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_item_id'] = this.orderItemId;
    data['salesorderid'] = this.salesorderid;
    data['order_id'] = this.orderId;
    data['itemreplacedwith'] = this.itemreplacedwith;
    data['itemcollected'] = this.itemcollected;
    data['itemreplacement'] = this.itemreplacement;
    data['itemdeletednostock'] = this.itemdeletednostock;
    data['itemcode'] = this.itemcode;
    data['item_name'] = this.itemName;
    data['units'] = this.units;
    data['packing'] = this.packing;
    data['order_item_quantity'] = this.orderItemQuantity;
    data['foc'] = this.foc;
    data['extrabonus'] = this.extrabonus;
    data['disprice'] = this.disprice;
    data['order_item_price'] = this.orderItemPrice;
    data['order_item_actual_amount'] = this.orderItemActualAmount;
    data['percentage_discountprice'] = this.percentageDiscountprice;
    data['order_item_final_amount'] = this.orderItemFinalAmount;
    data['expirydate'] = this.expirydate;
    data['batch'] = this.batch;
    data['stockbatchwise'] = this.stockbatchwise;
    data['manufacturedate'] = this.manufacturedate;
    data['whichcompany'] = this.whichcompany;
    data['whichbranch'] = this.whichbranch;
    data['item_whichcompany'] = this.itemWhichcompany;
    data['item_wac'] = this.itemWac;
    data['item_mgmtcost'] = this.itemMgmtcost;
    data['item_cutoffcost'] = this.itemCutoffcost;
    data['discountallotment'] = this.discountallotment;
    data['calculationtotal'] = this.calculationtotal;
    data['cartonization'] = this.cartonization;
    return data;
  }
}
