class ProductModel {
  final String id;
  final String name;
  final String avatar;
  final String price;
  final String color;

  ProductModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.price,
    required this.color,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      price: json['price'],
      color: json['color'],
    );
  }
}
