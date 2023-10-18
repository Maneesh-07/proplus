class Product {
  final String code;
  final String name;
  final double price;
  final String description;

  Product({
    required this.code,
    required this.name,
    required this.price,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      code: json['code'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
    );
  }

  Map<String, String> toJson() {
    return {
      'code': code,
      'name': name,
      'price': price.toString(),
      'description': description,
    };
  }
}