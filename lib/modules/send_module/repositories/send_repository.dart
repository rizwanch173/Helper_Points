import '../../../exports.dart';
import 'package:http/http.dart' as http;

class SendRepository {
  String submitTransferEndpoint =
      Constants.restApiBaseUrl + '/money_transfer/send';

  Future<bool?> submitTransfer(String token, String note, String email,
      String amount, String currencyId) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request =
          http.MultipartRequest('POST', Uri.parse('$submitTransferEndpoint'));
      request.fields.addAll({
        'amount': amount,
        'description': note,
        'receiver_email': email.trim(),
        'currency_id': currencyId
      });

      request.headers.addAll(headers);

      http.StreamedResponse resp = await request.send();
      var body = await resp.stream.bytesToString();
      if (resp.statusCode == 200) {
        //print(await resp.stream.bytesToString());

        var jsonData = jsonDecode(body);
        if (jsonData['error'].toString() == 'true') {
          Get.snackbar(
            'Error',
            jsonData['message'],
            margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
          );
          return null;
        }
        return true;
      } else if (resp.statusCode == 401) {
        LoginController _loginController = Get.find<LoginController>();
        _loginController.logout();
        return null;
      } else {
        return null;
        //print(resp.statusCode);
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        //Make a connected / not connected state true / false ;
        Get.to(NotConnectedScreen());
      }
    }
    return null;
  }
}
