import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../../exports.dart';
import 'dart:io';

class UploadDepositRepository {
  Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/deposit/make_request');

  Future<Deposit?> submitDeposit({
    File? file,
    String? filename,
    String? token,
    String? message,
    String? walletId,
    String? transactionId,
  }) async {
    ///MultiPart request
    try {
      var request = http.MultipartRequest(
        'POST',
        this.endpoint,
      );
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
        "Content-type": "multipart/form-data"
      };
      request.files.add(
        http.MultipartFile(
          'photo',
          file?.readAsBytes().asStream() as Stream<List<int>>,
          file?.lengthSync() as int,
          filename: filename,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      request.headers.addAll(headers);
      request.fields.addAll({
        "message_to_reviewer": message ?? '',
        "wallet_id": walletId ?? '0',
        "unique_transaction_id": transactionId!,
      });
      print(walletId);
      final res = await request.send();
      final respStr = await res.stream.bytesToString();

      if (res.statusCode == 200) {
        final json = jsonDecode(respStr);
        final resp = json['data'];
        print(resp);
        return Deposit(
          resp['id'].toString(),
          resp['user_id'].toString(),
          resp['transaction_state_id'].toString(),
          resp['deposit_method_id'].toString(),
          resp['gross'].toString(),
          resp['fee'].toString(),
          resp['net'].toString(),
          resp['transaction_receipt'].toString(),
          resp['message'].toString(),
          resp['created_at'].toString(),
          resp['updated_at'].toString(),
          Currency(
            resp['currency']['id'].toString(),
            resp['currency']['name'].toString(),
            null,
            resp['currency']['is_crypto'].toString(),
            null,
            resp['currency']['code'].toString(),
          ),
          TransferMethod(
            resp['TransferMethod']['id'].toString(),
            resp['TransferMethod']['name'].toString(),
            resp['TransferMethod']['thumbnail'].toString(),
            resp['TransferMethod']['accont_identifier_mechanism'].toString(),
          ),
          TransactionStatus(
            resp['status']['id'].toString(),
            resp['status']['name'].toString(),
          ),
        );
      }

      print(res.statusCode.toString());
      return null;
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        Get.to(NotConnectedScreen());
      }
      print(e.toString());
    }
    return null;
  }
}
