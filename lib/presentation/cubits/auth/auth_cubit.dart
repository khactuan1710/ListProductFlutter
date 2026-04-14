import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repositories/auth_repository_interface.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthInitial());

  Future<void> login(String username, String password) async {
    emit(const AuthLoading());
    try {
      final success = await _authRepository.login(username, password);
      if (success) {
        emit(const AuthSuccess());
      } else {
        emit(const AuthFailure('Invalid username or password'));
      }
    } catch (e) {
      emit(AuthFailure('Login failed: $e'));
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(const AuthInitial());
  }
}
