abstract class Failure {
  String statusCode;
  String? message;

  Failure({
    required this.statusCode,
    this.message,
  });
}

class ServerFailure extends Failure {
  String? error, errorCode;

  ServerFailure({
    required super.statusCode,
    super.message,
    this.error,
    this.errorCode,
  });
}
