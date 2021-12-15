class CartItem {
  final String itemName;
  final String image;
  final String itemCode;
  final String finalprice; // ws || rs
  String quantity;
   String foc;
   String exFoc;
  final String discount;
  CartItem({
    this.itemName,
    this.image,
    this.itemCode,
    this.foc,
    this.exFoc,
    this.discount,
    this.finalprice,
    this.quantity,
  });
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
        discount: json['disc']);
  }
}
