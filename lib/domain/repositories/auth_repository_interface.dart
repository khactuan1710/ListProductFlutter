abstract class AuthRepository {
  Future<bool> isLoggedIn();
  Future<bool> login(String username, String password);
  Future<void> logout();
}
