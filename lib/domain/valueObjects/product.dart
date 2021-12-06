class Product {
  final String id;
  final String title;

  Product(this.id, this.title);

  Product.fromMap(this.id, Map<String, dynamic> data) : title = data["title"];
}
