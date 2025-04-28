//For data-level exceptions (thrown in remote/local data sources)
class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  String toString() => message;
}
