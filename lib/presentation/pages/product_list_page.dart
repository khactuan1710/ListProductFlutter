import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubits/product_list/product_list_cubit.dart';
import '../cubits/product_list/product_list_state.dart';
import '../widgets/product_list_view.dart';
import '../widgets/error_view.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductListCubit>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products'), centerTitle: true),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          return switch (state) {
            ProductListInitial() => const SizedBox.shrink(),
            ProductListLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            ProductListError(message: final message) => ErrorView(
              message: message,
              onRetry: () => context.read<ProductListCubit>().retry(),
            ),
            ProductListSuccess(products: final products)
                when products.isEmpty =>
              _buildEmptyState(),
            ProductListSuccess(products: final products) => ProductListView(
              products: products,
              onRefresh: () =>
                  context.read<ProductListCubit>().refreshProducts(),
              onProductTap: (product) {
                context.pushNamed(
                  'productDetail',
                  pathParameters: {'id': product.id.toString()},
                );
              },
            ),
          };
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
