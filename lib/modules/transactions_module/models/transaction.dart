import '../../../exports.dart';

class Transaction {
  String? id;
  String? userId;
  String? requestId;
  String? transactionableId;
  String? transactionableType;
  String? entityId;
  String? entityName;
  String? transactionStateId;
  String? activityTitle;
  String? moneyFlow;
  String? gross;
  String? fee;
  String? net;
  String? balance;
  String? jsonData;
  String? currencySymbol;
  String? thumb;
  String? currencyId;
  String? createdAt;
  String? updatedAt;
  Currency? currency;

  Transaction(
      this.id,
      this.userId,
      this.requestId,
      this.transactionableId,
      this.transactionableType,
      this.entityId,
      this.entityName,
      this.transactionStateId,
      this.activityTitle,
      this.moneyFlow,
      this.gross,
      this.fee,
      this.net,
      this.balance,
      this.jsonData,
      this.currencySymbol,
      this.thumb,
      this.currencyId,
      this.createdAt,
      this.updatedAt,
      [this.currency]);
}
