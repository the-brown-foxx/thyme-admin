abstract interface class AdminAuthenticator {
  Stream<bool> get loading;

  Stream<bool> get loggedIn;

  Future<bool> get passwordSet;

  Future<void> login(final String password);

  Future<void> changePassword({
    final String? oldPassword,
    required final String newPassword,
  });

  Future<void> logout();
}