class UnauthorizedException implements Exception {
  String cause;

  UnauthorizedException(this.cause);

  String errorMessage() {
    return 'Loged out from ' + this.cause;
  }
}
