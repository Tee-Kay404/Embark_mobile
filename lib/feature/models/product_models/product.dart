class Product {
  final int id;
  final String imagePath;
  final String color;
  final String code;
  final String description;
  final double price;
  final String? volume;
  final String? size;
  final String? model;
  final String category;
  Product({
    required this.id,
    required this.imagePath,
    required this.color,
    required this.code,
    required this.description,
    required this.price,
    this.volume,
    this.size,
    this.model,
    required this.category,
  });
  factory Product.fromMap(Map<String, dynamic> e) {
    return Product(
        id: e['id'] is int ? e['id'] : int.parse(e['id']),
        imagePath: e['imagePath'],
        code: e['code'],
        color: e['color'],
        description: e['description'],
        price: e['price'] is int
            ? (e['price'] as int).toDouble()
            : double.parse(e['price'].toString()),
        category: e['category'],
        size: e['size'],
        volume: e['volume'],
        model: e['model']);
  }
}
