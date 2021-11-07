class PastOrder {
  String orderDate;
  String customername;
  String orderId;
  String itemcode;
  String itemName;
  String orderItemQuantity;
  String foc;
  String extrabonus;
  String orderItemPrice;
  String orderItemActualAmount;
  String disprice;
  String percentageDiscountprice;
  String orderItemFinalAmount;

  PastOrder(
      {this.orderDate,
      this.customername,
      this.orderId,
      this.itemcode,
      this.itemName,
      this.orderItemQuantity,
      this.foc,
      this.extrabonus,
      this.orderItemPrice,
      this.orderItemActualAmount,
      this.disprice,
      this.percentageDiscountprice,
      this.orderItemFinalAmount});

  PastOrder.fromJson(Map<String, dynamic> json) {
    orderDate = json['order_date'];
    customername = json['customername'];
    orderId = json['order_id'];
    itemcode = json['itemcode'];
    itemName = json['item_name'];
    orderItemQuantity = json['order_item_quantity'];
    foc = json['foc'];
    extrabonus = json['extrabonus'];
    orderItemPrice = json['order_item_price'];
    orderItemActualAmount = json['order_item_actual_amount'];
    disprice = json['disprice'];
    percentageDiscountprice = json['percentage_discountprice'];
    orderItemFinalAmount = json['order_item_final_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_date'] = this.orderDate;
    data['customername'] = this.customername;
    data['order_id'] = this.orderId;
    data['itemcode'] = this.itemcode;
    data['item_name'] = this.itemName;
    data['order_item_quantity'] = this.orderItemQuantity;
    data['foc'] = this.foc;
    data['extrabonus'] = this.extrabonus;
    data['order_item_price'] = this.orderItemPrice;
    data['order_item_actual_amount'] = this.orderItemActualAmount;
    data['disprice'] = this.disprice;
    data['percentage_discountprice'] = this.percentageDiscountprice;
    data['order_item_final_amount'] = this.orderItemFinalAmount;
    return data;
  }
}
