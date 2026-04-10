import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object?> get props => [];
}

final class ProductListInitial extends ProductListState {
  const ProductListInitial();
}

final class ProductListLoading extends ProductListState {
  const ProductListLoading();
}

final class ProductListSuccess extends ProductListState {
  final List<Product> products;

  const ProductListSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

final class ProductListError extends ProductListState {
  final String message;

  const ProductListError(this.message);

  @override
  List<Object?> get props => [message];
}
