import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/service_locator.dart';
import 'presentation/cubits/product_list/product_list_cubit.dart';
import 'presentation/cubits/product_detail/product_detail_cubit.dart';
import 'presentation/router/app_router.dart';
import 'presentation/router/guards/auth_guard.dart';

void main() {
  setupDependencies();
  runApp(const ProductListApp());
}

class ProductListApp extends StatelessWidget {
  const ProductListApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(authGuard: getIt<AuthGuard>());

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductListCubit>(
          create: (_) => getIt<ProductListCubit>(),
        ),
        BlocProvider<ProductDetailCubit>(
          create: (_) => getIt<ProductDetailCubit>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Product List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router.config(),
      ),
    );
  }
}
