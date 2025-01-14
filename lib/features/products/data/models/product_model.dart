class ProductModel {
  String id;
  String name;
  String description;
  num price;
  List<String> images;
  bool isBestSeller;
  String productCode;
  String categoryId;
  List<Map<String, dynamic>> imageColors; // New property

  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.id,
    required this.images,
    required this.isBestSeller,
    required this.productCode,
    required this.categoryId,
    required this.imageColors,
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
      categoryId: json['categoryId'],
      imageColors: (json['imageColors'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
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
      'categoryId': categoryId,
      'imageColors': imageColors,
    };
  }
}
