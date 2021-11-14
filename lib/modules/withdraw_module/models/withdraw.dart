import '../../../exports.dart';

class Withdraw {
  String id;
  String userId;
  Currency currency;
  Wallet wallet;
  TransactionStatus transactionStatus;
  String sendToPlatformName;
  String platformId;
  String gross;
  String fee;
  String net;
  String createdAt;
  Withdraw(
      this.id,
      this.userId,
      this.currency,
      this.wallet,
      this.transactionStatus,
      this.sendToPlatformName,
      this.platformId,
      this.fee,
      this.gross,
      this.net,
      this.createdAt);
}
