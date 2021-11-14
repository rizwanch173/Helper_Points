import '../../../exports.dart';

class Deposit {
  String? id;
  String? userId;
  String? transactionStateId;
  String? depositMethodId;
  String? gross;
  String? fee;
  String? net;
  String? transactionReceipt;
  String? message;
  String? createdAt;
  String? updatedAt;
  Currency? currency;
  TransferMethod? transferMethod;
  TransactionStatus? transactionStatus;

  Deposit(
    String? id,
    String? userId,
    String? transactionStateId,
    String? depositMethodId,
    String? gross,
    String? fee,
    String? net,
    String? transactionReceipt,
    String? message,
    String? createdAt,
    String? updatedAt,
    Currency? currency,
    TransferMethod? transferMethod,
    TransactionStatus? transactionStatus,
  ) {
    this.id = id;
    this.userId = userId;
    this.transactionStateId = transactionStateId;
    this.depositMethodId = depositMethodId;
    this.gross = gross;
    this.fee = fee;
    this.net = net;
    this.transactionReceipt = transactionReceipt;
    this.message = message;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.currency = currency;
    this.transferMethod = transferMethod;
    this.transactionStatus = transactionStatus;
  }
}
