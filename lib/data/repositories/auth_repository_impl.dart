import 'package:injectable/injectable.dart';

import '../../domain/repositories/auth_repository_interface.dart';
import '../datasources/auth_local_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({required AuthLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<bool> isLoggedIn() => _localDataSource.isLoggedIn();

  @override
  Future<bool> login(String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      await _localDataSource.saveLogin(username);
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() => _localDataSource.clearLogin();
}
