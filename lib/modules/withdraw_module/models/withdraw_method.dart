import '../../../exports.dart';

class WithdrawMethod {
  String? id;
  String? name;
  String? methodIdentifierFieldName;
  Currency? currency;
  WithdrawMethod(String? id, String? name, String? methodIdentifierFieldName,
      Currency? ncy) {
    this.id = id;
    this.name = name;
    this.methodIdentifierFieldName = methodIdentifierFieldName;
    this.currency = ncy;
  }
}
