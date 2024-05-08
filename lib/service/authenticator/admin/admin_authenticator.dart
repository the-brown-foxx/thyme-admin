abstract interface class AdminAuthenticator {
  Future<bool> get passwordSet;

  Future<void> login(final String password);

  Future<void> changePassword(
    final String? oldPassword,
    final String newPassword,
  );
}