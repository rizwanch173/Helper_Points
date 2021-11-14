import '../../../exports.dart';

class DepositMethod {
  String? id, name, thumb, methodIdentifierFieldName, howToApi;
  Currency? currency;
  DepositMethod(
    String? id,
    String? name, [
    String? thumb,
    String? methodIdentifierFieldName,
    String? howToApi,
    Currency? currency,
  ]) {
    this.id = id;
    this.name = name;
    this.thumb = thumb;
    this.methodIdentifierFieldName = methodIdentifierFieldName;
    this.howToApi = howToApi;
    this.currency = currency;
  }
}
