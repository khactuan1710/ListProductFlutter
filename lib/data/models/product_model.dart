import '../../domain/entities/product.dart';
import '../../domain/entities/product_rating.dart';

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;
  final double ratingRate;
  final int ratingCount;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.ratingRate,
    required this.ratingCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    _requireField(json, 'id');
    _requireField(json, 'title');
    _requireField(json, 'price');
    _requireField(json, 'description');
    _requireField(json, 'category');

    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      image: _parseImage(json),
      category: json['category'] as String,
      ratingRate: _parseRatingRate(json['rating']),
      ratingCount: _parseRatingCount(json['rating']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'image': image,
    'category': category,
    'rating': {
      'rate': ratingRate,
      'count': ratingCount,
    },
  };

  Product toEntity() => Product(
    id: id,
    title: title,
    price: price,
    description: description,
    image: image,
    category: category,
    rating: ProductRating(rate: ratingRate, count: ratingCount),
  );

  static void _requireField(Map<String, dynamic> json, String field) {
    if (!json.containsKey(field)) {
      throw FormatException("Missing required field: '$field'");
    }
  }

  static String _parseImage(Map<String, dynamic> json) {
    final image = json['image'];
    if (image is String && image.isNotEmpty) {
      return image;
    }

    final thumbnail = json['thumbnail'];
    if (thumbnail is String && thumbnail.isNotEmpty) {
      return thumbnail;
    }

    final images = json['images'];
    if (images is List && images.isNotEmpty && images.first is String) {
      return images.first as String;
    }

    throw const FormatException("Missing image field (image/thumbnail/images)");
  }

  static double _parseRatingRate(dynamic rating) {
    if (rating is num) {
      return rating.toDouble();
    }
    if (rating is Map<String, dynamic> && rating['rate'] is num) {
      return (rating['rate'] as num).toDouble();
    }
    throw const FormatException("Missing or invalid rating field");
  }

  static int _parseRatingCount(dynamic rating) {
    if (rating is Map<String, dynamic> && rating['count'] is int) {
      return rating['count'] as int;
    }
    return 0;
  }
}
