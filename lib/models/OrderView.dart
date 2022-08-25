class OrderViewModel {
  String custid;
  String customerstatus;
  String whichcompany;
  String whichbranch;
  String typeoflead;
  String location;
  String orderplacedby;
  String supplyto;
  String salesLocalrfqid;
  String leadid;
  String orderId;
  String soreferenceno;
  String soorderprifix;
  String customername;
  String customeremail;
  String employeeid;
  String employeename;
  String orderDate;
  String orderTotalBeforeTax;
  String wholediscount;
  String orderTotalAfterTax;
  String orderDatetime;
  String status;

  OrderViewModel(
      {this.custid,
      this.customerstatus,
      this.whichcompany,
      this.whichbranch,
      this.typeoflead,
      this.location,
      this.orderplacedby,
      this.supplyto,
      this.salesLocalrfqid,
      this.leadid,
      this.orderId,
      this.soreferenceno,
      this.soorderprifix,
      this.customername,
      this.customeremail,
      this.employeeid,
      this.employeename,
      this.orderDate,
      this.orderTotalBeforeTax,
      this.wholediscount,
      this.orderTotalAfterTax,
      this.orderDatetime,
      this.status});

  OrderViewModel.fromJson(Map<String, dynamic> json) {
    custid = json['custid'];
    customerstatus = json['customerstatus'];
    whichcompany = json['whichcompany'];
    whichbranch = json['whichbranch'];
    typeoflead = json['typeoflead'];
    location = json['location'];
    orderplacedby = json['orderplacedby'];
    supplyto = json['supplyto'];
    salesLocalrfqid = json['sales_localrfqid'];
    leadid = json['leadid'];
    orderId = json['order_id'];
    soreferenceno = json['soreferenceno'];
    soorderprifix = json['soorderprifix'];
    customername = json['customername'];
    customeremail = json['customeremail'];
    employeeid = json['employeeid'];
    employeename = json['employeename'];
    orderDate = json['order_date'];
    orderTotalBeforeTax = json['order_total_before_tax'];
    wholediscount = json['wholediscount'];
    orderTotalAfterTax = json['order_total_after_tax'];
    orderDatetime = json['order_datetime'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custid'] = this.custid;
    data['customerstatus'] = this.customerstatus;
    data['whichcompany'] = this.whichcompany;
    data['whichbranch'] = this.whichbranch;
    data['typeoflead'] = this.typeoflead;
    data['location'] = this.location;
    data['orderplacedby'] = this.orderplacedby;
    data['supplyto'] = this.supplyto;
    data['sales_localrfqid'] = this.salesLocalrfqid;
    data['leadid'] = this.leadid;
    data['order_id'] = this.orderId;
    data['soreferenceno'] = this.soreferenceno;
    data['soorderprifix'] = this.soorderprifix;
    data['customername'] = this.customername;
    data['customeremail'] = this.customeremail;
    data['employeeid'] = this.employeeid;
    data['employeename'] = this.employeename;
    data['order_date'] = this.orderDate;
    data['order_total_before_tax'] = this.orderTotalBeforeTax;
    data['wholediscount'] = this.wholediscount;
    data['order_total_after_tax'] = this.orderTotalAfterTax;
    data['order_datetime'] = this.orderDatetime;
    data['status'] = this.status;
    return data;
  }
}


class OrderDetailView {
  String orderItemId;
  String orderId;
  String itemcode;
  String itemName;
  String batch;
  String expirydate;
  String units;
  String packing;
  String orderItemQuantity;
  String foc;
  String extrabonus;
  String suppliedQty;
  String disprice;
  String orderItemPrice;
  String percentageDiscountprice;
  String orderItemActualAmount;
  String orderItemFinalAmount;
  String whichcompany;
  String whichbranch;
  String orderItemBranches;
  String itemWhichcompany;
  String itemWac;
  String itemMgmtcost;
  String itemCutoffcost;
  String discountallotment;
  String calculationtotal;
  String itemsequence;
  String stockreserved;
  String checkstatus;

  OrderDetailView(
      {this.orderItemId,
      this.orderId,
      this.itemcode,
      this.itemName,
      this.batch,
      this.expirydate,
      this.units,
      this.packing,
      this.orderItemQuantity,
      this.foc,
      this.extrabonus,
      this.suppliedQty,
      this.disprice,
      this.orderItemPrice,
      this.percentageDiscountprice,
      this.orderItemActualAmount,
      this.orderItemFinalAmount,
      this.whichcompany,
      this.whichbranch,
      this.orderItemBranches,
      this.itemWhichcompany,
      this.itemWac,
      this.itemMgmtcost,
      this.itemCutoffcost,
      this.discountallotment,
      this.calculationtotal,
      this.itemsequence,
      this.stockreserved,
      this.checkstatus});

  OrderDetailView.fromJson(Map<String, dynamic> json) {
    orderItemId = json['order_item_id'];
    orderId = json['order_id'];
    itemcode = json['itemcode'];
    itemName = json['item_name'];
    batch = json['batch'];
    expirydate = json['expirydate'];
    units = json['units'];
    packing = json['packing'];
    orderItemQuantity = json['order_item_quantity'];
    foc = json['foc'];
    extrabonus = json['extrabonus'];
    suppliedQty = json['supplied_qty'];
    disprice = json['disprice'];
    orderItemPrice = json['order_item_price'];
    percentageDiscountprice = json['percentage_discountprice'];
    orderItemActualAmount = json['order_item_actual_amount'];
    orderItemFinalAmount = json['order_item_final_amount'];
    whichcompany = json['whichcompany'];
    whichbranch = json['whichbranch'];
    orderItemBranches = json['order_item_branches'];
    itemWhichcompany = json['item_whichcompany'];
    itemWac = json['item_wac'];
    itemMgmtcost = json['item_mgmtcost'];
    itemCutoffcost = json['item_cutoffcost'];
    discountallotment = json['discountallotment'];
    calculationtotal = json['calculationtotal'];
    itemsequence = json['itemsequence'];
    stockreserved = json['stockreserved'];
    checkstatus = json['checkstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_item_id'] = this.orderItemId;
    data['order_id'] = this.orderId;
    data['itemcode'] = this.itemcode;
    data['item_name'] = this.itemName;
    data['batch'] = this.batch;
    data['expirydate'] = this.expirydate;
    data['units'] = this.units;
    data['packing'] = this.packing;
    data['order_item_quantity'] = this.orderItemQuantity;
    data['foc'] = this.foc;
    data['extrabonus'] = this.extrabonus;
    data['supplied_qty'] = this.suppliedQty;
    data['disprice'] = this.disprice;
    data['order_item_price'] = this.orderItemPrice;
    data['percentage_discountprice'] = this.percentageDiscountprice;
    data['order_item_actual_amount'] = this.orderItemActualAmount;
    data['order_item_final_amount'] = this.orderItemFinalAmount;
    data['whichcompany'] = this.whichcompany;
    data['whichbranch'] = this.whichbranch;
    data['order_item_branches'] = this.orderItemBranches;
    data['item_whichcompany'] = this.itemWhichcompany;
    data['item_wac'] = this.itemWac;
    data['item_mgmtcost'] = this.itemMgmtcost;
    data['item_cutoffcost'] = this.itemCutoffcost;
    data['discountallotment'] = this.discountallotment;
    data['calculationtotal'] = this.calculationtotal;
    data['itemsequence'] = this.itemsequence;
    data['stockreserved'] = this.stockreserved;
    data['checkstatus'] = this.checkstatus;
    return data;
  }
}
