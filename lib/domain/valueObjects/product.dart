class Product {
  final String title;

  Product(this.title);

  Product.fromMap(Map<String, dynamic> map) : title = map["title"];
}
