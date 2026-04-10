import 'package:equatable/equatable.dart';
import 'product_rating.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;
  final ProductRating rating;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, title, price, description, image, category, rating];
}
