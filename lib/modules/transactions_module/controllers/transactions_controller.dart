import '../../../exports.dart';
import 'package:http/http.dart' as http;

class TransactionsController extends GetxController {
  List<Transaction> transactionsList = [];
  bool hasMore = true;
  bool isLoading = false;
  Uri endpoint =
      Uri.parse(Constants.restApiBaseUrl + '/transaction/transactions');

  TransactionsController();

  Future<List<Transaction?>?> getTransactions() async {
    LoginController _loginController = Get.find<LoginController>();
    if (this.hasMore == false) {
      return null;
    }
    try {
      this.isLoading = true;
      var data = await http.post(endpoint,
          headers: {'Authorization': 'Bearer' + _loginController.token!});
      if (data.statusCode == 200) {
        var jsonData = jsonDecode(data.body);
        List<Transaction> newTransactions = [];
        for (var trns in jsonData['data']) {
          Transaction transaction = new Transaction(
              trns['id'].toString(),
              trns['user_id'].toString(),
              trns['request_id'].toString(),
              trns['transactionable_id'].toString(),
              trns['transactionable_type'].toString(),
              trns['entity_id'].toString(),
              trns['entity_name'].toString(),
              trns['transaction_state_id'].toString(),
              trns['activity_title'].toString(),
              trns['money_flow'].toString(),
              trns['gross'].toString(),
              trns['fee'].toString(),
              trns['net'].toString(),
              trns['balance'].toString(),
              trns['json_data'].toString(),
              trns['currency_symbol'].toString(),
              trns['thumb'].toString(),
              trns['currency_id'].toString(),
              trns['created_at'].toString(),
              trns['updated_at'].toString(),
              Currency(
                trns['currencie']['id'].toString(),
                trns['currencie']['name'].toString(),
                null,
                trns['currencie']['is_crypto'].toString(),
                null,
                trns['currencie']['code'].toString(),
              ));
          newTransactions.add(transaction);
        }
        if (jsonData['next_page_url'] != null) {
          endpoint = Uri.parse(jsonData['next_page_url']);
        } else {
          hasMore = false;
        }

        await addNewTransactions(newTransactions);

        return newTransactions;
      } else {
        print('server response status code : ' + data.statusCode.toString());
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        Get.to(NotConnectedScreen());
      }
    }
  }

  addNewTransactions(List<Transaction> transactions) async {
    //itemList.insert(0,item);
    for (var transaction in transactions) {
      this.transactionsList.add(transaction);
    }

    update();
    await Future.delayed(const Duration(seconds: 2), () {
      this.isLoading = false;
    });
  }

  Future<void> reset() async {
    this.endpoint =
        Uri.parse(Constants.restApiBaseUrl + '/transaction/transactions');
    this.transactionsList = [];
    this.hasMore = true;
    this.isLoading = false;
    update();

    //Timer(Duration(seconds: 5), () {});

    await Future.delayed(Duration(seconds: 2), () {
      // 5s over, navigate to a new page
    });
  }
}
