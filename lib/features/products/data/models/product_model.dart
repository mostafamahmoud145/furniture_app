class ProductModel {
  String id;
  String name;
  String description;
  num price;
  List<String> images;
  bool isBestSeller;
  String productCode;
  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.id,
    required this.images,
    required this.isBestSeller,
    required this.productCode,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      id: json['id'],
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      isBestSeller: json['isBestSeller'],
      productCode: json['productCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'id': id,
      'images': images,
      'isBestSeller': isBestSeller,
      'productCode': productCode,
    };
  }
}
