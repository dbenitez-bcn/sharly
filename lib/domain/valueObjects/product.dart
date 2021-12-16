class Product {
  final String id;
  String title;
  int quantity;

  //Product(this.id, this.title);

  Product.fromMap(this.id, Map<String, dynamic> data)
      : title = data["title"],
        quantity = data["quantity"] ?? 1;
}
