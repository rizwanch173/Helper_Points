class ReturnNullException implements Exception {
  String cause;
  ReturnNullException(this.cause);

  String errorMessage() {
    return this.cause + ' ' + 'returned null';
  }
}
