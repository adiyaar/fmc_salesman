/// id : "1001"
/// oldcode : "1103210911"
/// code : "1103210911"
/// customername : "AARVEE INTERNATIONAL"
/// customername_ar : ""
/// chqprintname : ""
/// accounthead : ""
/// address : ""
/// location : ""
/// type : ""
/// status : "1"
/// statusreason : null
/// ctelephone : ""
/// cmobile : ""
/// fax : ""
/// cemail : ""
/// customergroup : "QTN"
/// billingon : "CASH"
/// area : ""
/// sector : "Others"
/// category : "Trading Company"
/// invoicetype : "Wholesale"
/// invoiceprice : "Retail"
/// creditlimits : "0"
/// creditdays : "0"
/// gracelimit : "0"
/// gracedays : "0"
/// companyid : ""
/// branchaccess : ""
/// quotationvalidity : ""
/// xaxis : ""
/// yaxis : ""
/// allowbranchvisit : "1"
/// allowfoc : "0"

class CustomerList {
  String id;
  String oldcode;
  String code;
  String customername;
  String customernameAr;
  String chqprintname;
  String accounthead;
  String address;
  String location;
  String type;
  String status;
  dynamic statusreason;
  String ctelephone;
  String cmobile;
  String fax;
  String cemail;
  String customergroup;
  String billingon;
  String area;
  String sector;
  String category;
  String invoicetype;
  String invoiceprice;
  String creditlimits;
  String creditdays;
  String gracelimit;
  String gracedays;
  String companyid;
  String branchaccess;
  String quotationvalidity;
  String xaxis;
  String yaxis;
  String allowbranchvisit;
  String allowfoc;

  CustomerList(
      {this.id,
      this.oldcode,
      this.code,
      this.customername,
      this.customernameAr,
      this.chqprintname,
      this.accounthead,
      this.address,
      this.location,
      this.type,
      this.status,
      this.statusreason,
      this.ctelephone,
      this.cmobile,
      this.fax,
      this.cemail,
      this.customergroup,
      this.billingon,
      this.area,
      this.sector,
      this.category,
      this.invoicetype,
      this.invoiceprice,
      this.creditlimits,
      this.creditdays,
      this.gracelimit,
      this.gracedays,
      this.companyid,
      this.branchaccess,
      this.quotationvalidity,
      this.xaxis,
      this.yaxis,
      this.allowbranchvisit,
      this.allowfoc});

  CustomerList.fromJson(dynamic json) {
    id = json['id'];
    oldcode = json['oldcode'];
    code = json['code'];
    customername = json['customername'];
    customernameAr = json['customername_ar'];
    chqprintname = json['chqprintname'];
    accounthead = json['accounthead'];
    address = json['address'];
    location = json['location'];
    type = json['type'];
    status = json['status'];
    statusreason = json['statusreason'];
    ctelephone = json['ctelephone'];
    cmobile = json['cmobile'];
    fax = json['fax'];
    cemail = json['cemail'];
    customergroup = json['customergroup'];
    billingon = json['billingon'];
    area = json['area'];
    sector = json['sector'];
    category = json['category'];
    invoicetype = json['invoicetype'];
    invoiceprice = json['invoiceprice'];
    creditlimits = json['creditlimits'];
    creditdays = json['creditdays'];
    gracelimit = json['gracelimit'];
    gracedays = json['gracedays'];
    companyid = json['companyid'];
    branchaccess = json['branchaccess'];
    quotationvalidity = json['quotationvalidity'];
    xaxis = json['xaxis'];
    yaxis = json['yaxis'];
    allowbranchvisit = json['allowbranchvisit'];
    allowfoc = json['allowfoc'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['oldcode'] = oldcode;
    map['code'] = code;
    map['customername'] = customername;
    map['customername_ar'] = customernameAr;
    map['chqprintname'] = chqprintname;
    map['accounthead'] = accounthead;
    map['address'] = address;
    map['location'] = location;
    map['type'] = type;
    map['status'] = status;
    map['statusreason'] = statusreason;
    map['ctelephone'] = ctelephone;
    map['cmobile'] = cmobile;
    map['fax'] = fax;
    map['cemail'] = cemail;
    map['customergroup'] = customergroup;
    map['billingon'] = billingon;
    map['area'] = area;
    map['sector'] = sector;
    map['category'] = category;
    map['invoicetype'] = invoicetype;
    map['invoiceprice'] = invoiceprice;
    map['creditlimits'] = creditlimits;
    map['creditdays'] = creditdays;
    map['gracelimit'] = gracelimit;
    map['gracedays'] = gracedays;
    map['companyid'] = companyid;
    map['branchaccess'] = branchaccess;
    map['quotationvalidity'] = quotationvalidity;
    map['xaxis'] = xaxis;
    map['yaxis'] = yaxis;
    map['allowbranchvisit'] = allowbranchvisit;
    map['allowfoc'] = allowfoc;
    return map;
  }

  static List<CustomerList> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => CustomerList.fromJson(item)).toList();
  }

  @override
  String toString() => customername;
}
