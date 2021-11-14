class Currency {
  String? id;
  String? name;
  String? symbol;
  String? code;
  String? isCrypto;
  String? thumb;

  Currency(id, name, [symbol, isCrypto, thumb, code]) {
    this.id = id;
    this.name = name;
    this.symbol = symbol;
    this.code = code;
    this.isCrypto = isCrypto;
    this.thumb = thumb;
  }
}
