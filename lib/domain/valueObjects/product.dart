class Product {
  final String id;
  final String title;
  final int quantity;

  //Product(this.id, this.title);

  Product.fromMap(this.id, Map<String, dynamic> data)
      : title = data["title"],
        quantity = data["quantity"] ?? 1;
}
