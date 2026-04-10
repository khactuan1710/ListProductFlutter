import 'package:go_router/go_router.dart';
import '../pages/product_list_page.dart';
import '../pages/product_detail_page.dart';

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'productList',
        path: '/',
        builder: (context, state) => const ProductListPage(),
      ),
      GoRoute(
        name: 'productDetail',
        path: '/products/:id',
        builder: (context, state) {
          final idString = state.pathParameters['id']!;
          final id = int.parse(idString);
          return ProductDetailPage(productId: id);
        },
      ),
    ],
  );
}
