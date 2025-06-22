class ItemModel {
  final int? id;
  final String? type;
  final double? price;
  final String? imageUrl;
  int quantity;

  ItemModel({this.id, this.type, this.price, this.imageUrl, this.quantity = 1});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] as int?,

      type: json['type'] as String?,
      price: (json['price'] != null) ? (json['price'] as num).toDouble() : null,
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'type': type, 'price': price, 'image_url': imageUrl};
  }
}
