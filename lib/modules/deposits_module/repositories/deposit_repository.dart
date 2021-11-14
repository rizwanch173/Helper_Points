import 'package:http/http.dart' as http;
import '../../../exports.dart';

class DepositRepository {
  Future<List<Deposit?>?> getDeposits(String token) async {
    DepositController _depositController = Get.find<DepositController>();
    LoginController _loginController = Get.find<LoginController>();

    if (_depositController.hasMore == false) {
      return null;
    }

    try {
      var resp = await http
          .post(_depositController.endpoint, headers: <String, String>{
        //'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      });
      if (resp.statusCode == 200) {
        List<Deposit> deposits = [];
        var jsonData = jsonDecode(resp.body);
        for (var deposit in jsonData['data']) {
          deposits.add(Deposit(
            deposit['id'].toString(),
            deposit['user_id'].toString(),
            deposit['transaction_state_id'].toString(),
            deposit['deposit_method_id'].toString(),
            deposit['gross'].toString(),
            deposit['fee'].toString(),
            deposit['net'].toString(),
            deposit['transaction_receipt'].toString(),
            deposit['message'].toString(),
            deposit['created_at'].toString(),
            deposit['updated_at'].toString(),
            Currency(
              deposit['currency']['id'].toString(),
              deposit['currency']['name'].toString(),
              null,
              deposit['currency']['is_crypto'].toString(),
              null,
              deposit['currency']['code'].toString(),
            ),
            TransferMethod(
              deposit['transfer_method']['id'].toString(),
              deposit['transfer_method']['name'].toString(),
              deposit['transfer_method']['thumbnail'].toString(),
              deposit['transfer_method']['accont_identifier_mechanism']
                  .toString(),
            ),
            TransactionStatus(
              deposit['status']['id'].toString(),
              deposit['status']['name'].toString(),
            ),
          ));
        }

        if (jsonData['next_page_url'] != null) {
          _depositController.endpoint = Uri.parse(jsonData['next_page_url']);
        } else {
          _depositController.hasMore = false;
        }
        return deposits;
      } else if (resp.statusCode == 401) {
        _loginController.logout();
        return null;
      } else {
        print('unknown response code');
        print(resp.statusCode);
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        Get.to(NotConnectedScreen());
      }
    }
    return null;
  }
}
