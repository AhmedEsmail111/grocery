class ItemsListModel {
  final List<Order> orders;

  ItemsListModel({
    required this.orders,
  });

  factory ItemsListModel.fromJson(Map<String, dynamic> json) => ItemsListModel(
        orders: List<Order>.from(json["items"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  final String name;
  final int quantity;
  final String price;
  final String currency;

  Order({
    required this.name,
    required this.quantity,
    required this.price,
    required this.currency,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        name: json["name"],
        quantity: json["quantity"],
        price: json["price"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
        "price": price,
        "currency": currency,
      };
}
