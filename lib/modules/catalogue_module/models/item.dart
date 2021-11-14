import '../../../exports.dart';

class Item {
  String? id;
  String? userId;
  String? price;
  String? description;
  String? thumbnail;
  String? name;
  String? code;
  String? createdAt;
  Currency? currency;
  User? user;
  Item(
    this.id,
    this.userId,
    this.name,
    this.code,
    this.price,
    this.description,
    this.thumbnail,
    this.createdAt, [
    this.currency,
    this.user,
  ]);
}
