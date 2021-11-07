class CartItem {
  final String img;
  final String title;

  final String price;
  final String id;
  final String finalprice;
  final String quantity;
  CartItem({
    this.img,
    this.title,
    this.price,
    this.id,
    this.finalprice,
    this.quantity,
  });
//List data;
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      img: json['img'],
      title: json['itemname_en'],
      price: json['price'],
      finalprice: json['finalprice'],
      quantity: json['quantity'],
    );
  }
}
