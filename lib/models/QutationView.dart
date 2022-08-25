class QuotationViewModel {
  String whichcompany;
  String whichbranch;
  String orderId;
  String leadid;
  String rfqreferenceno;
  String rfqorderprifix;
  String customerstatus;
  String customername;
  String custid;
  String customeremail;
  String employeeid;
  String employeename;
  String employeecode;
  String orderDate;
  String wholediscount;
  String orderTotalBeforeTax;
  String orderTotalAfterTax;
  String orderDatetime;
  String status;

  QuotationViewModel(
      {this.whichcompany,
      this.whichbranch,
      this.orderId,
      this.leadid,
      this.rfqreferenceno,
      this.rfqorderprifix,
      this.customerstatus,
      this.customername,
      this.custid,
      this.customeremail,
      this.employeeid,
      this.employeename,
      this.employeecode,
      this.orderDate,
      this.wholediscount,
      this.orderTotalBeforeTax,
      this.orderTotalAfterTax,
      this.orderDatetime,
      this.status});

  QuotationViewModel.fromJson(Map<String, dynamic> json) {
    whichcompany = json['whichcompany'];
    whichbranch = json['whichbranch'];
    orderId = json['order_id'];
    leadid = json['leadid'];
    rfqreferenceno = json['rfqreferenceno'];
    rfqorderprifix = json['rfqorderprifix'];
    customerstatus = json['customerstatus'];
    customername = json['customername'];
    custid = json['custid'];
    customeremail = json['customeremail'];
    employeeid = json['employeeid'];
    employeename = json['employeename'];
    employeecode = json['employeecode'];
    orderDate = json['order_date'];
    wholediscount = json['wholediscount'];
    orderTotalBeforeTax = json['order_total_before_tax'];
    orderTotalAfterTax = json['order_total_after_tax'];
    orderDatetime = json['order_datetime'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['whichcompany'] = this.whichcompany;
    data['whichbranch'] = this.whichbranch;
    data['order_id'] = this.orderId;
    data['leadid'] = this.leadid;
    data['rfqreferenceno'] = this.rfqreferenceno;
    data['rfqorderprifix'] = this.rfqorderprifix;
    data['customerstatus'] = this.customerstatus;
    data['customername'] = this.customername;
    data['custid'] = this.custid;
    data['customeremail'] = this.customeremail;
    data['employeeid'] = this.employeeid;
    data['employeename'] = this.employeename;
    data['employeecode'] = this.employeecode;
    data['order_date'] = this.orderDate;
    data['wholediscount'] = this.wholediscount;
    data['order_total_before_tax'] = this.orderTotalBeforeTax;
    data['order_total_after_tax'] = this.orderTotalAfterTax;
    data['order_datetime'] = this.orderDatetime;
    data['status'] = this.status;
    return data;
  }
}


// DETAIL QUTATION VIEW

class QuotationDetailView {
  String orderItemId;
  String orderId;
  String itemcode;
  String itemName;
  String units;
  String packing;
  String orderItemQuantity;
  String foc;
  String extrabonus;
  String orderItemPrice;
  String orderItemActualAmount;
  String disprice;
  String percentageDiscountprice;
  String orderItemFinalAmount;
  String discountallotment;
  String calculationtotal;
  String remarks;
  String whichcompany;
  String whichbranch;
  String itemsequence;
  String excelseq;
  String excelcode;
  String exceldescription;
  String excelunit;
  String excelqty;
  String excelnotes;
  String itemWhichcompany;
  String itemWac;
  String itemMgmtcost;
  String itemCutoffcost;
  String stockreserved;

  QuotationDetailView(
      {this.orderItemId,
      this.orderId,
      this.itemcode,
      this.itemName,
      this.units,
      this.packing,
      this.orderItemQuantity,
      this.foc,
      this.extrabonus,
      this.orderItemPrice,
      this.orderItemActualAmount,
      this.disprice,
      this.percentageDiscountprice,
      this.orderItemFinalAmount,
      this.discountallotment,
      this.calculationtotal,
      this.remarks,
      this.whichcompany,
      this.whichbranch,
      this.itemsequence,
      this.excelseq,
      this.excelcode,
      this.exceldescription,
      this.excelunit,
      this.excelqty,
      this.excelnotes,
      this.itemWhichcompany,
      this.itemWac,
      this.itemMgmtcost,
      this.itemCutoffcost,
      this.stockreserved});

  QuotationDetailView.fromJson(Map<String, dynamic> json) {
    orderItemId = json['order_item_id'];
    orderId = json['order_id'];
    itemcode = json['itemcode'];
    itemName = json['item_name'];
    units = json['units'];
    packing = json['packing'];
    orderItemQuantity = json['order_item_quantity'];
    foc = json['foc'];
    extrabonus = json['extrabonus'];
    orderItemPrice = json['order_item_price'];
    orderItemActualAmount = json['order_item_actual_amount'];
    disprice = json['disprice'];
    percentageDiscountprice = json['percentage_discountprice'];
    orderItemFinalAmount = json['order_item_final_amount'];
    discountallotment = json['discountallotment'];
    calculationtotal = json['calculationtotal'];
    remarks = json['remarks'];
    whichcompany = json['whichcompany'];
    whichbranch = json['whichbranch'];
    itemsequence = json['itemsequence'];
    excelseq = json['excelseq'];
    excelcode = json['excelcode'];
    exceldescription = json['exceldescription'];
    excelunit = json['excelunit'];
    excelqty = json['excelqty'];
    excelnotes = json['excelnotes'];
    itemWhichcompany = json['item_whichcompany'];
    itemWac = json['item_wac'];
    itemMgmtcost = json['item_mgmtcost'];
    itemCutoffcost = json['item_cutoffcost'];
    stockreserved = json['stockreserved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_item_id'] = this.orderItemId;
    data['order_id'] = this.orderId;
    data['itemcode'] = this.itemcode;
    data['item_name'] = this.itemName;
    data['units'] = this.units;
    data['packing'] = this.packing;
    data['order_item_quantity'] = this.orderItemQuantity;
    data['foc'] = this.foc;
    data['extrabonus'] = this.extrabonus;
    data['order_item_price'] = this.orderItemPrice;
    data['order_item_actual_amount'] = this.orderItemActualAmount;
    data['disprice'] = this.disprice;
    data['percentage_discountprice'] = this.percentageDiscountprice;
    data['order_item_final_amount'] = this.orderItemFinalAmount;
    data['discountallotment'] = this.discountallotment;
    data['calculationtotal'] = this.calculationtotal;
    data['remarks'] = this.remarks;
    data['whichcompany'] = this.whichcompany;
    data['whichbranch'] = this.whichbranch;
    data['itemsequence'] = this.itemsequence;
    data['excelseq'] = this.excelseq;
    data['excelcode'] = this.excelcode;
    data['exceldescription'] = this.exceldescription;
    data['excelunit'] = this.excelunit;
    data['excelqty'] = this.excelqty;
    data['excelnotes'] = this.excelnotes;
    data['item_whichcompany'] = this.itemWhichcompany;
    data['item_wac'] = this.itemWac;
    data['item_mgmtcost'] = this.itemMgmtcost;
    data['item_cutoffcost'] = this.itemCutoffcost;
    data['stockreserved'] = this.stockreserved;
    return data;
  }
}
