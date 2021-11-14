class TransferMethod {
  String? id;
  String? name;
  String? accontIdentifierMechanism;
  String? howToDeposit;
  String? howToWithdraw;
  String? daysToProcessTransfer;
  String? isActive;
  String? thumbnail;
  String? depositPercentageFee;
  String? depositFixedFee;
  String? withdrawPercentageFee;
  String? withdrawFixedFee;

  TransferMethod(
    String? id,
    String? name,
    String? thumbnail,
    String? accontIdentifierMechanism, [
    String? howToDeposit,
    String? howToWithdraw,
    String? daysToProcessTransfer,
    String? isActive,
    String? depositPercentageFee,
    String? depositFixedFee,
    String? withdrawPercentageFee,
    String? withdrawFixedFee,
  ]) {
    this.id = id;
    this.name = name;
    this.thumbnail = thumbnail;
    this.accontIdentifierMechanism = accontIdentifierMechanism;
    this.howToDeposit = howToDeposit;
    this.howToWithdraw = howToWithdraw;
    this.daysToProcessTransfer = daysToProcessTransfer;
    this.isActive = isActive;
    this.depositPercentageFee = depositPercentageFee;
    this.depositFixedFee = depositFixedFee;
    this.withdrawPercentageFee = withdrawPercentageFee;
    this.withdrawFixedFee = withdrawFixedFee;
  }
}
