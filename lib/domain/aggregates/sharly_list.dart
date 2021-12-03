import 'package:sharlyapp/domain/valueObjects/product.dart';

class SharlyList {
  final String title;
  final List<Product> products;

  SharlyList(this.title, this.products);

  static SharlyList fromMap(Map<String, dynamic> map){
    String title = map["title"];
    List<dynamic> products = map["products"];
    return SharlyList(title, products.map((e) =>  Product.fromMap(e)).toList());
  }

}
