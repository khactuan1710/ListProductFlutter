import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repositories/auth_repository_interface.dart';
import '../app_router.dart';

@lazySingleton
class AuthGuard extends AutoRouteGuard {
  final AuthRepository _authRepository;

  AuthGuard({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isLoggedIn = await _authRepository.isLoggedIn();
    if (isLoggedIn) {
      resolver.next();
    } else {
      router.replaceAll([const LoginRoute()]);
    }
  }
}
