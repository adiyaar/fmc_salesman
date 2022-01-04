class Salesmandetailpage {
  String itemid;
  String img;
  String itemnameEn;
  String labelname;
  String itempack;
  String itemstrength;
  String itemmaingroupid;
  String itemmaingrouptitle;
  String itemgroupid;
  String itemgrouptitle;
  String itemsubgroupid;
  String itemproductgroupid;
  String id;
  String itemproductgrouptitle;
  String itemproductgroupimage;
  String shortdescription;
  String description;
  String additionalinformation;
  String type;
  String itemdosageid;
  String itemclassid;
  String manufactureid;
  String manufactureshortname;
  String seq;
  String maxretailprice;
  String minretailprice;
  String rs;
  String origin;
  String whichcompany;
  String allowsonapp;
  String status;

  Salesmandetailpage(
      {this.itemid,
      this.img,
      this.itemnameEn,
      this.labelname,
      this.itempack,
      this.itemstrength,
      this.itemmaingroupid,
      this.itemmaingrouptitle,
      this.itemgroupid,
      this.itemgrouptitle,
      this.itemsubgroupid,
      this.itemproductgroupid,
      this.id,
      this.itemproductgrouptitle,
      this.itemproductgroupimage,
      this.shortdescription,
      this.description,
      this.additionalinformation,
      this.type,
      this.itemdosageid,
      this.itemclassid,
      this.manufactureid,
      this.manufactureshortname,
      this.seq,
      this.maxretailprice,
      this.minretailprice,
      this.rs,
      this.origin,
      this.whichcompany,
      this.allowsonapp,
      this.status});

  Salesmandetailpage.fromJson(Map<String, dynamic> json) {
    itemid = json['itemid'];
    img = json['img'];
    itemnameEn = json['itemname_en'];
    labelname = json['labelname'];
    itempack = json['itempack'];
    itemstrength = json['itemstrength'];
    itemmaingroupid = json['itemmaingroupid'];
    itemmaingrouptitle = json['itemmaingrouptitle'];
    itemgroupid = json['itemgroupid'];
    itemgrouptitle = json['itemgrouptitle'];
    itemsubgroupid = json['itemsubgroupid'];
    itemproductgroupid = json['itemproductgroupid'];
    id = json['id'];
    itemproductgrouptitle = json['itemproductgrouptitle'];
    itemproductgroupimage = json['itemproductgroupimage'];
    shortdescription = json['shortdescription'];
    description = json['description'];
    additionalinformation = json['additionalinformation'];
    type = json['type'];
    itemdosageid = json['itemdosageid'];
    itemclassid = json['itemclassid'];
    manufactureid = json['manufactureid'];
    manufactureshortname = json['manufactureshortname'];
    seq = json['seq'];
    maxretailprice = json['maxretailprice'];
    minretailprice = json['minretailprice'];
    rs = json['rs'];
    origin = json['origin'];
    whichcompany = json['whichcompany'];
    allowsonapp = json['allowsonapp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemid'] = this.itemid;
    data['img'] = this.img;
    data['itemname_en'] = this.itemnameEn;
    data['labelname'] = this.labelname;
    data['itempack'] = this.itempack;
    data['itemstrength'] = this.itemstrength;
    data['itemmaingroupid'] = this.itemmaingroupid;
    data['itemmaingrouptitle'] = this.itemmaingrouptitle;
    data['itemgroupid'] = this.itemgroupid;
    data['itemgrouptitle'] = this.itemgrouptitle;
    data['itemsubgroupid'] = this.itemsubgroupid;
    data['itemproductgroupid'] = this.itemproductgroupid;
    data['id'] = this.id;
    data['itemproductgrouptitle'] = this.itemproductgrouptitle;
    data['itemproductgroupimage'] = this.itemproductgroupimage;
    data['shortdescription'] = this.shortdescription;
    data['description'] = this.description;
    data['additionalinformation'] = this.additionalinformation;
    data['type'] = this.type;
    data['itemdosageid'] = this.itemdosageid;
    data['itemclassid'] = this.itemclassid;
    data['manufactureid'] = this.manufactureid;
    data['manufactureshortname'] = this.manufactureshortname;
    data['seq'] = this.seq;
    data['maxretailprice'] = this.maxretailprice;
    data['minretailprice'] = this.minretailprice;
    data['rs'] = this.rs;
    data['origin'] = this.origin;
    data['whichcompany'] = this.whichcompany;
    data['allowsonapp'] = this.allowsonapp;
    data['status'] = this.status;
    return data;
  }
}

class Variant {
  String id;
  Null img;
  String itemnameEn;
  Null itemnameAr;
  String labelname;
  String itempack;
  String itemstrength;
  String itemproductgroupid;
  String itemmaingroupid;
  String itemgroupid;
  String itemsubgroupid;
  String itemsubgroupecommerceid;
  String type;
  String itemdosageid;
  String itemclassid;
  String manufactureid;
  String manufactureshortname;
  String seq;
  String rs;
  String ws;
  String avgprice;
  String mohprice;
  String origin;
  String companyid;
  String whichcompany;
  String allowsonapp;
  String allowsonweb;
  String allowsonecommerce;
  String status;
  Null statusreason;
  String contentlist;
  Null defaultunit;

  Variant(
      {this.id,
      this.img,
      this.itemnameEn,
      this.itemnameAr,
      this.labelname,
      this.itempack,
      this.itemstrength,
      this.itemproductgroupid,
      this.itemmaingroupid,
      this.itemgroupid,
      this.itemsubgroupid,
      this.itemsubgroupecommerceid,
      this.type,
      this.itemdosageid,
      this.itemclassid,
      this.manufactureid,
      this.manufactureshortname,
      this.seq,
      this.rs,
      this.ws,
      this.avgprice,
      this.mohprice,
      this.origin,
      this.companyid,
      this.whichcompany,
      this.allowsonapp,
      this.allowsonweb,
      this.allowsonecommerce,
      this.status,
      this.statusreason,
      this.contentlist,
      this.defaultunit});

  Variant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    itemnameEn = json['itemname_en'];
    itemnameAr = json['itemname_ar'];
    labelname = json['labelname'];
    itempack = json['itempack'];
    itemstrength = json['itemstrength'];
    itemproductgroupid = json['itemproductgroupid'];
    itemmaingroupid = json['itemmaingroupid'];
    itemgroupid = json['itemgroupid'];
    itemsubgroupid = json['itemsubgroupid'];
    itemsubgroupecommerceid = json['itemsubgroupecommerceid'];
    type = json['type'];
    itemdosageid = json['itemdosageid'];
    itemclassid = json['itemclassid'];
    manufactureid = json['manufactureid'];
    manufactureshortname = json['manufactureshortname'];
    seq = json['seq'];
    rs = json['rs'];
    ws = json['ws'];
    avgprice = json['avgprice'];
    mohprice = json['mohprice'];
    origin = json['origin'];
    companyid = json['companyid'];
    whichcompany = json['whichcompany'];
    allowsonapp = json['allowsonapp'];
    allowsonweb = json['allowsonweb'];
    allowsonecommerce = json['allowsonecommerce'];
    status = json['status'];
    statusreason = json['statusreason'];
    contentlist = json['contentlist'];
    defaultunit = json['defaultunit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['itemname_en'] = this.itemnameEn;
    data['itemname_ar'] = this.itemnameAr;
    data['labelname'] = this.labelname;
    data['itempack'] = this.itempack;
    data['itemstrength'] = this.itemstrength;
    data['itemproductgroupid'] = this.itemproductgroupid;
    data['itemmaingroupid'] = this.itemmaingroupid;
    data['itemgroupid'] = this.itemgroupid;
    data['itemsubgroupid'] = this.itemsubgroupid;
    data['itemsubgroupecommerceid'] = this.itemsubgroupecommerceid;
    data['type'] = this.type;
    data['itemdosageid'] = this.itemdosageid;
    data['itemclassid'] = this.itemclassid;
    data['manufactureid'] = this.manufactureid;
    data['manufactureshortname'] = this.manufactureshortname;
    data['seq'] = this.seq;
    data['rs'] = this.rs;
    data['ws'] = this.ws;
    data['avgprice'] = this.avgprice;
    data['mohprice'] = this.mohprice;
    data['origin'] = this.origin;
    data['companyid'] = this.companyid;
    data['whichcompany'] = this.whichcompany;
    data['allowsonapp'] = this.allowsonapp;
    data['allowsonweb'] = this.allowsonweb;
    data['allowsonecommerce'] = this.allowsonecommerce;
    data['status'] = this.status;
    data['statusreason'] = this.statusreason;
    data['contentlist'] = this.contentlist;
    data['defaultunit'] = this.defaultunit;
    return data;
  }

  static List<Variant> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => Variant.fromJson(item)).toList();
  }

  @override
  String toString() => itempack;
}
