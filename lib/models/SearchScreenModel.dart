//Manufactures List
class Manufactures {
  String id;
  String title;
  String shortname;
  String etitle;
  String image;
  String allowonecommerce;

  Manufactures(
      {this.id,
      this.title,
      this.shortname,
      this.etitle,
      this.image,
      this.allowonecommerce});

  Manufactures.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    shortname = json['shortname'];
    etitle = json['etitle'];
    image = json['image'];
    allowonecommerce = json['allowonecommerce'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['shortname'] = shortname;
    map['etitle'] = etitle;
    map['image'] = image;
    map['allowonecommerce'] = allowonecommerce;
    return map;
  }
}

/// id : "11"
/// title : "Medicine"
/// etitle : "Medicine\t"
/// icon : "\tmi-first-aid-kit\t"
/// image : "628925981.png"
/// seq : "1"

class ItemMainGroup {
  String id;
  String title;
  String etitle;
  String icon;
  String image;
  String seq;

  ItemMainGroup(
      {this.id, this.title, this.etitle, this.icon, this.image, this.seq});

  ItemMainGroup.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    etitle = json['etitle'];
    icon = json['icon'];
    image = json['image'];
    seq = json['seq'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['etitle'] = etitle;
    map['icon'] = icon;
    map['image'] = image;
    map['seq'] = seq;
    return map;
  }
}

/// itemid : "100001"
/// img : "644352.jpg"
/// itemname_en : "Acicone-S Chewable Tablet 20.s"
/// labelname : "Acicone-S Chewable\nTablet\n20s"
/// itempack : ""
/// itemstrength : ""
/// itemmaingroupid : "11"
/// itemmaingrouptitle : "Medicine"
/// itemgroupid : "142"
/// itemgrouptitle : "Alimentary\nSystem"
/// itemsubgroupid : "40"
/// itemproductgroupid : "1520"
/// id : "1520"
/// itemproductgrouptitle : "Acicone-S Chewable Tablet\n20'S"
/// itemproductgroupimage : ""
/// shortdescription : ""
/// description : ""
/// additionalinformation : ""
/// type : "1"
/// itemdosageid : "3"
/// itemclassid : "2"
/// manufactureid : "89"
/// manufactureshortname : ""
/// seq : "1"
/// maxretailprice : "5.250"
/// minretailprice : "5.250"
/// rs : "5.250"
/// ws : "3.40"
/// origin : ""
/// whichcompany : "FPG"
/// allowsonapp : "0"
/// status : "1"

class SearchList {
  String itemid;
  String img;
  String itemnameEn;
  // String labelname;
  // String itempack;
  // String itemstrength;
  String itemmaingroupid;
  String itemmaingrouptitle;
  // String itemgroupid;
  // String itemgrouptitle;
  // String itemsubgroupid;
  String itemproductgroupid;
  // String id;
  String itemproductgrouptitle;
  // String itemproductgroupimage;
  // String shortdescription;
  // String description;
  // String additionalinformation;
  // String type;
  // String itemdosageid;
  // String itemclassid;
  // String manufactureid;
  // String manufactureshortname;
  // String seq;
  String maxretailprice;
  String minretailprice;
  String maxwholesaleprice;
  String minwholesaleprice;
  String rs;
  // String ws;

  // String origin;
  // String whichcompany;
  // String allowsonapp;
  // String status;

  SearchList(
      {this.itemid,
      this.img,
      this.itemnameEn,
      // this.labelname,
      // this.itempack,
      // this.itemstrength,
      this.itemmaingroupid,
      this.itemmaingrouptitle,
      // this.itemgroupid,
      // this.itemgrouptitle,
      // this.itemsubgroupid,
      this.itemproductgroupid,
      // this.id,
      this.itemproductgrouptitle,
      // this.itemproductgroupimage,
      // this.shortdescription,
      // this.description,
      // this.additionalinformation,
      // this.type,
      // this.itemdosageid,
      // this.itemclassid,
      // this.manufactureid,
      // this.manufactureshortname,
      // this.seq,
      this.maxretailprice,
      this.minretailprice,
      this.maxwholesaleprice,
      this.minwholesaleprice
      // this.rs,
      // this.ws,
      // this.origin,
      // this.whichcompany,
      // this.allowsonapp,
      // this.status
      });

  SearchList.fromJson(dynamic json) {
    itemid = json['itemid'];
    img = json['img'];
    itemnameEn = json['itemname_en'];
    // labelname = json['labelname'];
    // itempack = json['itempack'];
    // itemstrength = json['itemstrength'];
    itemmaingroupid = json['itemmaingroupid'];
    itemmaingrouptitle = json['itemmaingrouptitle'];
    // itemgroupid = json['itemgroupid'];
    // itemgrouptitle = json['itemgrouptitle'];
    // itemsubgroupid = json['itemsubgroupid'];
    itemproductgroupid = json['itemproductgroupid'];
    // id = json['id'];
    itemproductgrouptitle = json['itemproductgrouptitle'];
    // itemproductgroupimage = json['itemproductgroupimage'];
    // shortdescription = json['shortdescription'];
    // description = json['description'];
    // additionalinformation = json['additionalinformation'];
    // type = json['type'];
    // itemdosageid = json['itemdosageid'];
    // itemclassid = json['itemclassid'];
    // manufactureid = json['manufactureid'];
    // manufactureshortname = json['manufactureshortname'];
    // seq = json['seq'];
    maxretailprice = json['maxretailprice'];
    minretailprice = json['minretailprice'];
    maxwholesaleprice = json['maxwholesaleprice'];
    minwholesaleprice = json['minwholesaleprice'];
    // rs = json['rs'];
    // ws = json['ws'];

    // origin = json['origin'];
    // whichcompany = json['whichcompany'];
    // allowsonapp = json['allowsonapp'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['itemid'] = itemid;
    map['img'] = img;
    map['itemname_en'] = itemnameEn;
    // map['labelname'] = labelname;
    // map['itempack'] = itempack;
    // map['itemstrength'] = itemstrength;
    map['itemmaingroupid'] = itemmaingroupid;
    map['itemmaingrouptitle'] = itemmaingrouptitle;
    // map['itemgroupid'] = itemgroupid;
    // map['itemgrouptitle'] = itemgrouptitle;
    // map['itemsubgroupid'] = itemsubgroupid;
    map['itemproductgroupid'] = itemproductgroupid;
    // map['id'] = id;
    map['itemproductgrouptitle'] = itemproductgrouptitle;
    // map['itemproductgroupimage'] = itemproductgroupimage;
    // map['shortdescription'] = shortdescription;
    // map['description'] = description;
    // map['additionalinformation'] = additionalinformation;
    // map['type'] = type;
    // map['itemdosageid'] = itemdosageid;
    // map['itemclassid'] = itemclassid;
    // map['manufactureid'] = manufactureid;
    // map['manufactureshortname'] = manufactureshortname;
    // map['seq'] = seq;
    map['maxretailprice'] = maxretailprice;
    map['minretailprice'] = minretailprice;
    map['maxwholesaleprice'] = maxwholesaleprice;
    map['minwholesaleprice'] = minwholesaleprice;
    // map['rs'] = rs;

    // map['origin'] = origin;
    // map['whichcompany'] = whichcompany;
    // map['allowsonapp'] = allowsonapp;
    // map['status'] = status;
    return map;
  }
}
