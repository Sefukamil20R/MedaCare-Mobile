/// A base class for handling failures in the application.
abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

/// A specific failure for network-related issues.
class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}

/// A specific failure for server-related issues.
class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

/// A specific failure for cache-related issues.
class CacheFailure extends Failure {
  CacheFailure(String message) : super(message);
}