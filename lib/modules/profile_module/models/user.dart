import 'identityVerification.dart';

class User {
  String? id;
  String? email;
  String? name;
  String? firstName;
  String? lastName;
  String? avatar;
  String? verified;
  String? identityVerified;
  // String? accountStatus;
  // String? whatsApp;
  String? phonenumber;
  IdentityVerification? identityVerification;
  User(
    id,
    email,
    name,
    firstName,
    lastName,
    avatar,
    verified,
    identityVerified, [
    phonenumber,
    identityVerification,
  ]) {
    this.id = id;
    this.email = email;
    this.name = name;
    this.firstName = firstName;
    this.lastName = lastName;
    this.avatar = avatar;
    this.verified = verified;
    this.identityVerified = identityVerified;
    this.phonenumber = phonenumber;
  }
  // "id": 2,
  //   "role_id": "1",
  //   "current_team_id": null,
  //   "profile_photo_path": null,
  //   "email": "celso.r.paunde@gmail.com",
  //   "name": "Celso",
  //   "first_name": "Celso",
  //   "last_name": "Sudo",
  //   "avatar": "https://devv2.bitmetical.com//storage/users/Celso/ffe7728501572e5ac885e2ad64d7a5100140076d.jpg",
  //   "two_factor_secret": null,
  //   "two_factor_recovery_codes": null,
  //   "verified": "1",
  //   "merchant": "0",
  //   "social": "0",
  //   "balance": "0.00",
  //   "json_data": null,
  //   "account_status": "1",
  //   "currency_id": "11",
  //   "is_ticket_admin": "1",
  //   "verification_token": null,
  //   "whatsapp": null,
  //   "phonenumber": null,
  //   "email_verified_at": null,
  //   "created_at": "2020-10-12T02:28:06.000000Z",
  //   "updated_at": "2020-12-02T14:42:15.000000Z",
  //   "settings": null,
  //   "profile": null
}
