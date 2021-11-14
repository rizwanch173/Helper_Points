import '../../../exports.dart';
import 'package:http/http.dart' as http;

class WithdrawalRepository {
  Uri withdrawMethodsEndpoint =
      Uri.parse(Constants.restApiBaseUrl + '/withdrawal/withdrawal_methods');
  Uri submitWithdrawalEndpoint =
      Uri.parse(Constants.restApiBaseUrl + '/withdrawal/make_request');

  WithdrawController? _withdrawController;

  Future<Withdraw?> submitWithdraw(
    String token,
    String walletId,
    String amount,
  ) async {
    try {
      var resp = await http.post(submitWithdrawalEndpoint, body: {
        'wallet_id': walletId,
        'amount': amount,
      }, headers: <String, String>{
        'Authorization': 'Bearer ' + token
      });

      if (resp.statusCode == 200) {
        var response = jsonDecode(resp.body);
        if (response['error'].toString() == 'true') {
          Get.snackbar('Error', response['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
          return null;
        }
        //print(response['data']['access_token']);
        final withdraw = response['data'];

        Currency currency = Currency(
          withdraw['currency']['id'].toString(),
          withdraw['currency']['name'].toString(),
          withdraw['currency']['symbol'].toString(),
          withdraw['currency']['is_crypto'].toString(),
          withdraw['currency']['thumb'].toString(),
          withdraw['currency']['code'].toString(),
        );

        Wallet wallet = Wallet(
          withdraw['wallet']['user_id'].toString(),
          withdraw['wallet']['is_crypto'].toString(),
          withdraw['wallet']['id'].toString(),
          withdraw['wallet']['amount'].toString(),
          withdraw['wallet']['accont_identifier_mechanism_value'].toString(),
          currency,
          TransferMethod(
            withdraw['TransferMethod']['id'].toString(),
            withdraw['TransferMethod']['name'].toString(),
            withdraw['TransferMethod']['thumbnail'].toString(),
            withdraw['TransferMethod']['accont_identifier_mechanism']
                .toString(),
          ),
        );

        TransactionStatus transactionStatus = TransactionStatus(
            withdraw['status']['id'].toString(),
            withdraw['status']['name'].toString());

        Withdraw wthdrw = Withdraw(
          withdraw['id'].toString(),
          withdraw['user_id'].toString(),
          currency,
          wallet,
          transactionStatus,
          withdraw['send_to_platform_name'].toString(),
          withdraw['platform_id'].toString(),
          withdraw['fee'].toString(),
          withdraw['gross'].toString(),
          withdraw['net'].toString(),
          withdraw['created_at'].toString(),
        );
        print('here');
        return wthdrw;
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

  Future<List<Withdraw?>?> getWithdrawals() async {
    _withdrawController = Get.find<WithdrawController>();
    LoginController _loginController = Get.find<LoginController>();

    if (_withdrawController?.hasMore == false) {
      return null;
    }

    try {
      var resp = await http.post((_withdrawController?.endpoint ?? Uri()),
          headers: <String, String>{
            //'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + _loginController.token!
          });

      if (resp.statusCode == 200) {
        var jsonData = jsonDecode(resp.body);
        if (jsonData['error'].toString() == 'true' &&
            !(jsonData['message']
                .toString()
                .contains("request your first withdrawal"))) {
          Get.snackbar('Error', jsonData['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
          return null;
        }
        List<Withdraw> withdraws = [];
        for (var withdraw in jsonData['data']) {
          Currency currency = Currency(
            withdraw['currency']['id'].toString(),
            withdraw['currency']['name'].toString(),
            withdraw['currency']['symbol'].toString(),
            withdraw['currency']['is_crypto'].toString(),
            withdraw['currency']['thumb'].toString(),
            withdraw['currency']['code'].toString(),
          );
          Wallet wallet = Wallet(
            withdraw['wallet']['user_id'].toString(),
            withdraw['wallet']['is_crypto'].toString(),
            withdraw['wallet']['id'].toString(),
            withdraw['wallet']['amount'].toString(),
            withdraw['wallet']['accont_identifier_mechanism_value'].toString(),
            currency,
            TransferMethod(
              withdraw['transfer_method']['id'].toString(),
              withdraw['transfer_method']['name'].toString(),
              withdraw['transfer_method']['thumbnail'].toString(),
              withdraw['transfer_method']['accont_identifier_mechanism']
                  .toString(),
            ),
          );
          TransactionStatus transactionStatus = TransactionStatus(
              withdraw['status']['id'].toString(),
              withdraw['status']['name'].toString());
          Withdraw wdrw = Withdraw(
            withdraw['id'].toString(),
            withdraw['user_id'].toString(),
            currency,
            wallet,
            transactionStatus,
            withdraw['send_to_platform_name'].toString(),
            withdraw['platform_id'].toString(),
            withdraw['fee'].toString(),
            withdraw['gross'].toString(),
            withdraw['net'].toString(),
            withdraw['created_at'].toString(),
          );
          withdraws.add(wdrw);
        }

        if (jsonData['next_page_url'] != null) {
          _withdrawController?.endpoint = Uri.parse(jsonData['next_page_url']);
        } else {
          _withdrawController?.hasMore = false;
        }

        return withdraws;
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
