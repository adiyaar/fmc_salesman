class CartItem {
  final String itemName;
  final String image;
  final String itemCode;
  final String finalprice; // ws || rs
  String quantity;
  String foc;
  String packing;
  String itemWac;
  String itemMgmt;
  String calcCost;
  String cutoFF;
  String units;
  String itemWhchCOmpany;
  String exFoc;
  final String discount;
  CartItem(
      {this.itemName,
      this.image,
      this.itemCode,
      this.foc,
      this.exFoc,
      this.discount,
      this.finalprice,
      this.quantity,
      this.calcCost,
      this.cutoFF,
      this.itemMgmt,
      this.itemWhchCOmpany,
      this.itemWac,
      this.packing,
      this.units});
//List data;
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        itemName: json['itemname_en'],
        image: json['img'],
        itemCode: json['item_code'],
        finalprice: json['ws'],
        quantity: json['qty'],
        foc: json['foc'],
        exFoc: json['ex_foc'],
        itemWac: json['item_wac'],
        units: json['units'],
        packing: json['packing'],
        itemMgmt: json['item_mgmtcost'],
        itemWhchCOmpany: json['item_whichcompany'],
        calcCost: json['calculationtotal'],
        cutoFF: json['item_cutoffcost'],
        discount: json['disc']);
  }
}

class VariantsD {
  String id;
  String itempack;

  VariantsD({this.id, this.itempack});
//List data;
  factory VariantsD.fromJson(Map<String, dynamic> json) {
    return VariantsD(
      id: json['id'],
      itempack: json['itempack'],
    );
  }
}

class UnitsD {
  String id;
  String itemid;
  String unit;
  String packing;
  String rss;
  String wss;
  String ass;

  UnitsD(
      {this.id,
      this.itemid,
      this.ass,
      this.packing,
      this.rss,
      this.unit,
      this.wss});
//List data;
  factory UnitsD.fromJson(Map<String, dynamic> json) {
    return UnitsD(
        id: json['id'],
        itemid: json['itemid'],
        unit: json['unit'],
        packing: json['packaging'],
        rss: json['rss'],
        wss: json['wss'],
        ass: json['ass']);
  }
}
