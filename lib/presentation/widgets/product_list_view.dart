import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import 'product_card.dart';

class ProductListView extends StatelessWidget {
  final List<Product> products;
  final Future<void> Function() onRefresh;
  final void Function(Product) onProductTap;

  const ProductListView({
    super.key,
    required this.products,
    required this.onRefresh,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            onTap: () => onProductTap(product),
          );
        },
      ),
    );
  }
}
