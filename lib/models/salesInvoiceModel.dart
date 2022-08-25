class SalesInvoice {
  String custid;
  String orderDatetime;
  String orderTotalAfterTax;
  String salesorderid;
  String picklistid;
  String deliveryid;
  String orderId;
  String leadid;
  String localrfqid;
  String whichcompany;
  String whichbranch;
  String sireferenceno;
  String siorderprifix;
  String customername;
  String customeremail;
  String employeeid;
  String employeename;
  String emailid;
  String orderDate;
  String status;
  String wholediscount;

  SalesInvoice(
      {this.custid,
      this.orderDatetime,
      this.orderTotalAfterTax,
      this.salesorderid,
      this.picklistid,
      this.deliveryid,
      this.orderId,
      this.leadid,
      this.localrfqid,
      this.whichcompany,
      this.whichbranch,
      this.sireferenceno,
      this.siorderprifix,
      this.customername,
      this.customeremail,
      this.employeeid,
      this.employeename,
      this.emailid,
      this.orderDate,
      this.status,
      this.wholediscount});

  SalesInvoice.fromJson(Map<String, dynamic> json) {
    custid = json['custid'];
    orderDatetime = json['order_datetime'];
    orderTotalAfterTax = json['order_total_after_tax'];
    salesorderid = json['salesorderid'];
    picklistid = json['picklistid'];
    deliveryid = json['deliveryid'];
    orderId = json['order_id'];
    leadid = json['leadid'];
    localrfqid = json['localrfqid'];
    whichcompany = json['whichcompany'];
    whichbranch = json['whichbranch'];
    sireferenceno = json['sireferenceno'];
    siorderprifix = json['siorderprifix'];
    customername = json['customername'];
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
    data['custid'] = this.custid;
    data['order_datetime'] = this.orderDatetime;
    data['order_total_after_tax'] = this.orderTotalAfterTax;
    data['salesorderid'] = this.salesorderid;
    data['picklistid'] = this.picklistid;
    data['deliveryid'] = this.deliveryid;
    data['order_id'] = this.orderId;
    data['leadid'] = this.leadid;
    data['localrfqid'] = this.localrfqid;
    data['whichcompany'] = this.whichcompany;
    data['whichbranch'] = this.whichbranch;
    data['sireferenceno'] = this.sireferenceno;
    data['siorderprifix'] = this.siorderprifix;
    data['customername'] = this.customername;
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


class SalesInvoiceDetail {
  String orderItemId;
  String orderId;
  String itemcode;
  String itemName;
  String batch;
  String manufacturedate;
  String units;
  String packing;
  String orderItemQuantity;
  String foc;
  String extrabonus;
  String disprice;
  String percentageDiscountprice;
  String orderItemPrice;
  String orderItemActualAmount;
  String orderItemFinalAmount;
  String expirydate;
  String whichcompany;
  String whichbranch;
  String itemWhichcompany;
  String itemWac;
  String itemMgmtcost;
  String itemCutoffcost;
  String discountallotment;
  String calculationtotal;

  SalesInvoiceDetail(
      {this.orderItemId,
      this.orderId,
      this.itemcode,
      this.itemName,
      this.batch,
      this.manufacturedate,
      this.units,
      this.packing,
      this.orderItemQuantity,
      this.foc,
      this.extrabonus,
      this.disprice,
      this.percentageDiscountprice,
      this.orderItemPrice,
      this.orderItemActualAmount,
      this.orderItemFinalAmount,
      this.expirydate,
      this.whichcompany,
      this.whichbranch,
      this.itemWhichcompany,
      this.itemWac,
      this.itemMgmtcost,
      this.itemCutoffcost,
      this.discountallotment,
      this.calculationtotal});

  SalesInvoiceDetail.fromJson(Map<String, dynamic> json) {
    orderItemId = json['order_item_id'];
    orderId = json['order_id'];
    itemcode = json['itemcode'];
    itemName = json['item_name'];
    batch = json['batch'];
    manufacturedate = json['manufacturedate'];
    units = json['units'];
    packing = json['packing'];
    orderItemQuantity = json['order_item_quantity'];
    foc = json['foc'];
    extrabonus = json['extrabonus'];
    disprice = json['disprice'];
    percentageDiscountprice = json['percentage_discountprice'];
    orderItemPrice = json['order_item_price'];
    orderItemActualAmount = json['order_item_actual_amount'];
    orderItemFinalAmount = json['order_item_final_amount'];
    expirydate = json['expirydate'];
    whichcompany = json['whichcompany'];
    whichbranch = json['whichbranch'];
    itemWhichcompany = json['item_whichcompany'];
    itemWac = json['item_wac'];
    itemMgmtcost = json['item_mgmtcost'];
    itemCutoffcost = json['item_cutoffcost'];
    discountallotment = json['discountallotment'];
    calculationtotal = json['calculationtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_item_id'] = this.orderItemId;
    data['order_id'] = this.orderId;
    data['itemcode'] = this.itemcode;
    data['item_name'] = this.itemName;
    data['batch'] = this.batch;
    data['manufacturedate'] = this.manufacturedate;
    data['units'] = this.units;
    data['packing'] = this.packing;
    data['order_item_quantity'] = this.orderItemQuantity;
    data['foc'] = this.foc;
    data['extrabonus'] = this.extrabonus;
    data['disprice'] = this.disprice;
    data['percentage_discountprice'] = this.percentageDiscountprice;
    data['order_item_price'] = this.orderItemPrice;
    data['order_item_actual_amount'] = this.orderItemActualAmount;
    data['order_item_final_amount'] = this.orderItemFinalAmount;
    data['expirydate'] = this.expirydate;
    data['whichcompany'] = this.whichcompany;
    data['whichbranch'] = this.whichbranch;
    data['item_whichcompany'] = this.itemWhichcompany;
    data['item_wac'] = this.itemWac;
    data['item_mgmtcost'] = this.itemMgmtcost;
    data['item_cutoffcost'] = this.itemCutoffcost;
    data['discountallotment'] = this.discountallotment;
    data['calculationtotal'] = this.calculationtotal;
    return data;
  }
}
