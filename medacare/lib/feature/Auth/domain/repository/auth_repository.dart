abstract class AuthRepository {
  /// Signs in a user with email and password.
  /// Returns a user ID if successful.
  Future<String> signInWithEmailAndPassword(String email, String password);

  /// Registers a new user with email and password.
  /// Returns a user ID if successful.
  Future<String> registerWithEmailAndPassword(String email, String password);

  /// Signs out the currently signed-in user.
  Future<void> signOut();

  /// Checks if a user is currently signed in.
  /// Returns true if a user is signed in, otherwise false.
  Future<bool> isUserSignedIn();
}