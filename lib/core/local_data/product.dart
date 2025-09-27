class Product {
  final String id;
  final String imagePath;
  final String title;
  final String subtitle;
  final double price;
  final String description;
  final String deliveryTime;

  Product({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.description,
    required this.deliveryTime,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      imagePath: map['imagePath'],
      title: map['title'],
      subtitle: map['subtitle'],
      price: (map['price'] as num).toDouble(),
      description: map['description'],
      deliveryTime: map['deliveryTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'title': title,
      'subtitle': subtitle,
      'price': price,
      'description': description,
      'deliveryTime': deliveryTime,
    };
  }
}
