// class LeadList {
//   String leadprifix;
//   String createdon;
//   String whichcompany;
//   String whichbranch;
//   String quotationprifix;
//   String leadno;
//   String reasonforcancel;
//   String status;
//   String customerstatus;
//   String id;
//   String employeeid;
//   String employeename;
//   String employeecode;
//   String typeoflead;
//   String dateofrfq;
//   String customeremail;
//   String customername;
//   String customerid;

//   LeadList(
//       {this.leadprifix,
//       this.createdon,
//       this.whichcompany,
//       this.whichbranch,
//       this.quotationprifix,
//       this.leadno,
//       this.reasonforcancel,
//       this.status,
//       this.customerstatus,
//       this.id,
//       this.employeeid,
//       this.employeename,
//       this.employeecode,
//       this.typeoflead,
//       this.dateofrfq,
//       this.customeremail,
//       this.customername,
//       this.customerid});

//   LeadList.fromJson(Map<String, dynamic> json) {
//     leadprifix = json['leadprifix'];
//     createdon = json['createdon'];
//     whichcompany = json['whichcompany'];
//     whichbranch = json['whichbranch'];
//     quotationprifix = json['quotationprifix'];
//     leadno = json['leadno'];
//     reasonforcancel = json['reasonforcancel'];
//     status = json['status'];
//     customerstatus = json['customerstatus'];
//     id = json['id'];
//     employeeid = json['employeeid'];
//     employeename = json['employeename'];
//     employeecode = json['employeecode'];
//     typeoflead = json['typeoflead'];
//     dateofrfq = json['dateofrfq'];
//     customeremail = json['customeremail'];
//     customername = json['customername'];
//     customerid = json['customerid'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['leadprifix'] = this.leadprifix;
//     data['createdon'] = this.createdon;
//     data['whichcompany'] = this.whichcompany;
//     data['whichbranch'] = this.whichbranch;
//     data['quotationprifix'] = this.quotationprifix;
//     data['leadno'] = this.leadno;
//     data['reasonforcancel'] = this.reasonforcancel;
//     data['status'] = this.status;
//     data['customerstatus'] = this.customerstatus;
//     data['id'] = this.id;
//     data['employeeid'] = this.employeeid;
//     data['employeename'] = this.employeename;
//     data['employeecode'] = this.employeecode;
//     data['typeoflead'] = this.typeoflead;
//     data['dateofrfq'] = this.dateofrfq;
//     data['customeremail'] = this.customeremail;
//     data['customername'] = this.customername;
//     data['customerid'] = this.customerid;
//     return data;
//   }
// }


class LeadList {
  String id;
  String leadno;
  String whichcompany;
  String whichbranch;
  String leadprifix;
  String customername;
  String shippingaddress;
  String typeofcontact;
  String customeremail;
  String employeeid;
  String customertype;
  String billingon;
  String invoiceprice;
  String invoicetype;
  String creditlimits;
  String creditdays;
  String customerstatus;
  String typeoflead;
  String attach;
  String dateofrfq;
  String lastbiddate;
  String status;
  String customerlocalpo;
  String customerlocalpodate;
  String customerattach;
  String reasonforcancel;
  String message;
  String quotationprifix;
  String createdon;
  String employeename;
  String employeecode;
  String customerid;

  LeadList(
      {this.id,
      this.leadno,
      this.whichcompany,
      this.whichbranch,
      this.leadprifix,
      this.customername,
      this.shippingaddress,
      this.typeofcontact,
      this.customeremail,
      this.employeeid,
      this.customertype,
      this.billingon,
      this.invoiceprice,
      this.invoicetype,
      this.creditlimits,
      this.creditdays,
      this.customerstatus,
      this.typeoflead,
      this.attach,
      this.dateofrfq,
      this.lastbiddate,
      this.status,
      this.customerlocalpo,
      this.customerlocalpodate,
      this.customerattach,
      this.reasonforcancel,
      this.message,
      this.quotationprifix,
      this.createdon,
      this.employeename,
      this.employeecode,
      this.customerid});

  LeadList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadno = json['leadno'];
    whichcompany = json['whichcompany'];
    whichbranch = json['whichbranch'];
    leadprifix = json['leadprifix'];
    customername = json['customername'];
    shippingaddress = json['shippingaddress'];
    typeofcontact = json['typeofcontact'];
    customeremail = json['customeremail'];
    employeeid = json['employeeid'];
    customertype = json['customertype'];
    billingon = json['billingon'];
    invoiceprice = json['invoiceprice'];
    invoicetype = json['invoicetype'];
    creditlimits = json['creditlimits'];
    creditdays = json['creditdays'];
    customerstatus = json['customerstatus'];
    typeoflead = json['typeoflead'];
    attach = json['attach'];
    dateofrfq = json['dateofrfq'];
    lastbiddate = json['lastbiddate'];
    status = json['status'];
    customerlocalpo = json['customerlocalpo'];
    customerlocalpodate = json['customerlocalpodate'];
    customerattach = json['customerattach'];
    reasonforcancel = json['reasonforcancel'];
    message = json['message'];
    quotationprifix = json['quotationprifix'];
    createdon = json['createdon'];
    employeename = json['employeename'];
    employeecode = json['employeecode'];
    customerid = json['customerid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadno'] = this.leadno;
    data['whichcompany'] = this.whichcompany;
    data['whichbranch'] = this.whichbranch;
    data['leadprifix'] = this.leadprifix;
    data['customername'] = this.customername;
    data['shippingaddress'] = this.shippingaddress;
    data['typeofcontact'] = this.typeofcontact;
    data['customeremail'] = this.customeremail;
    data['employeeid'] = this.employeeid;
    data['customertype'] = this.customertype;
    data['billingon'] = this.billingon;
    data['invoiceprice'] = this.invoiceprice;
    data['invoicetype'] = this.invoicetype;
    data['creditlimits'] = this.creditlimits;
    data['creditdays'] = this.creditdays;
    data['customerstatus'] = this.customerstatus;
    data['typeoflead'] = this.typeoflead;
    data['attach'] = this.attach;
    data['dateofrfq'] = this.dateofrfq;
    data['lastbiddate'] = this.lastbiddate;
    data['status'] = this.status;
    data['customerlocalpo'] = this.customerlocalpo;
    data['customerlocalpodate'] = this.customerlocalpodate;
    data['customerattach'] = this.customerattach;
    data['reasonforcancel'] = this.reasonforcancel;
    data['message'] = this.message;
    data['quotationprifix'] = this.quotationprifix;
    data['createdon'] = this.createdon;
    data['employeename'] = this.employeename;
    data['employeecode'] = this.employeecode;
    data['customerid'] = this.customerid;
    return data;
  }
}
