import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasources/product_api_service.dart';
import 'data/repositories/product_repository_impl.dart';
import 'presentation/cubits/product_list/product_list_cubit.dart';
import 'presentation/cubits/product_detail/product_detail_cubit.dart';
import 'presentation/router/app_router.dart';

void main() {
  final apiService = ProductApiService();
  final repository = ProductRepositoryImpl(apiService: apiService);

  runApp(ProductListApp(repository: repository));
}

class ProductListApp extends StatelessWidget {
  final ProductRepositoryImpl repository;

  const ProductListApp({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    final router = createAppRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductListCubit>(
          create: (_) => ProductListCubit(repository: repository),
        ),
        BlocProvider<ProductDetailCubit>(
          create: (_) => ProductDetailCubit(repository: repository),
        ),
      ],
      child: MaterialApp.router(
        title: 'Product List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
