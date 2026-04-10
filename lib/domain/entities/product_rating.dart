import 'package:equatable/equatable.dart';

class ProductRating extends Equatable {
  final double rate;
  final int count;

  const ProductRating({
    required this.rate,
    required this.count,
  });

  @override
  List<Object?> get props => [rate, count];
}
