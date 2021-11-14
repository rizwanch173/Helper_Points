import 'currency.dart';
import '../../methods_module/models/transfer_method.dart';

class Wallet {
  String? id;
  String? isCrypto;
  String? userId;
  String? amount;
  String? accontIdentifierMechanismValue;
  String? currencyId;
  Currency? currency;
  TransferMethod? transferMethod;

  Wallet(
    String? userId,
    String? isCrypto,
    String? id,
    String? amount,
    String? accontIdentifierMechanismValue,
    Currency currency,
    TransferMethod transfermethod,
  ) {
    this.id = id;
    this.amount = amount;
    this.currencyId = currencyId;
    this.userId = userId;
    this.isCrypto = isCrypto;
    this.accontIdentifierMechanismValue = accontIdentifierMechanismValue;
    this.currency = currency;
    this.transferMethod = transfermethod;
  }
}
