import '../../../exports.dart';
import 'package:http/http.dart' as http;

class WalletRepository {
  Future<List<Wallet?>?> getWallets(token) async {
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/auth/wallets');

    var resp = await http.post(endpoint, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token
    });

    if (resp.statusCode == 200) {
      print("fggggggggggggggggggggggggg");
      List<Wallet> wallets = [];
      var jsonData = json.decode(resp.body);
      print(jsonData['data'].length);

      for (var data in jsonData['data']) {
        print(data);
      }

      for (var wallet in jsonData['data']) {
        print('passed from for loop');

        wallets.add(
          Wallet(
            wallet['user_id'].toString(),
            wallet['is_crypto'].toString(),
            wallet['id'].toString(),
            wallet['amount'].toString(),
            wallet['accont_identifier_mechanism_value'].toString(),
            Currency(
              wallet['currency']['id'].toString(),
              wallet['currency']['name'].toString(),
              wallet['currency']['symbol'].toString(),
              wallet['currency']['is_crypto'].toString(),
              wallet['currency']['thumb'].toString(),
              wallet['currency']['code'].toString(),
            ),
            TransferMethod(
              wallet['transfer_method']['id'].toString(),
              wallet['transfer_method']['name'].toString(),
              wallet['transfer_method']['thumbnail'].toString(),
              wallet['transfer_method']['accont_identifier_mechanism']
                  .toString(),
              wallet['transfer_method']['how_to_deposit'].toString(),
              wallet['transfer_method']['how_to_withdraw'].toString(),
              wallet['transfer_method']['days_to_process_transfer'].toString(),
              wallet['transfer_method']['is_active'].toString(),
              wallet['transfer_method']['deposit_percentage_fee'].toString(),
              wallet['transfer_method']['deposit_fixed_fee'].toString(),
              wallet['transfer_method']['withdraw_percentage_fee'].toString(),
              wallet['transfer_method']['withdraw_fixed_fee'].toString(),
            ),
          ),
        );
      }
      print("wallets.length");

      return wallets;
    } else if (resp.statusCode == 401) {
      return null;
    } else {
      print('unknown response code');
      print(resp.statusCode);
    }
    // } catch (e) {
    //   String errorType = e.runtimeType.toString();
    //   print(errorType);
    //   if (errorType == 'SocketException') {
    //     Get.to(NotConnectedScreen());
    //   }
    // }

    return null;
  }

  Future<Wallet?> create(
      String token, String accountNumber, transferMethodId) async {
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/wallet/create');
    try {
      var resp = await http.post(endpoint, body: {
        'accont_identifier_mechanism_id': accountNumber,
        'transfer_method_id': transferMethodId,
      }, headers: <String, String>{
        'Authorization': 'Bearer ' + token
      });

      print(resp.body);

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
        final _wlt = response['data'];

        Currency currency = Currency(
          _wlt['currency']['id'].toString(),
          _wlt['currency']['name'].toString(),
          _wlt['currency']['symbol'].toString(),
          _wlt['currency']['is_crypto'].toString(),
          _wlt['currency']['thumb'].toString(),
          _wlt['currency']['code'].toString(),
        );

        TransferMethod transfermethod = new TransferMethod(
          _wlt['TransferMethod']['id'].toString(),
          _wlt['TransferMethod']['name'].toString(),
          _wlt['TransferMethod']['thumbnail'].toString(),
          _wlt['TransferMethod']['accont_identifier_mechanism'].toString(),
        );

        Wallet wallet = new Wallet(
            _wlt['user_id'].toString(),
            _wlt['is_crypto'].toString(),
            _wlt['id'].toString(),
            _wlt['amount'].toString(),
            _wlt['accont_identifier_mechanism_value'].toString(),
            currency,
            transfermethod);
        return wallet;
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
