class SalesQuotationModel {
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
  String checkpartial;

  SalesQuotationModel(
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
      this.status,
      this.checkpartial});

  SalesQuotationModel.fromJson(Map<String, dynamic> json) {
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
    checkpartial = json['checkpartial'];
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
    data['checkpartial'] = this.checkpartial;
    return data;
  }
}
