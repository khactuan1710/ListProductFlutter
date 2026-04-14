import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../pages/login_page.dart';
import '../pages/product_list_page.dart';
import '../pages/product_detail_page.dart';
import 'guards/auth_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  final AuthGuard authGuard;

  AppRouter({required this.authGuard});

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: ProductListRoute.page, initial: true, guards: [authGuard]),
    AutoRoute(
      page: ProductDetailRoute.page,
      path: '/products/:productId',
      guards: [authGuard],
    ),
  ];
}

//thêm injectable + getIt tự sinh file cấu hình
//thêm AutoRoute, AutoRouteGuard lúc chạy thì có sinh file router tự động
//ở chỗ login em dùng tạm shared_preferences làm DB local, và AuthGuard làm midleware trong auto_route để check đăng nhập chưa để điều hướng ạ.
