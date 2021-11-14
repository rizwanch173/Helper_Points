// import '../../../exports.dart';
// import 'package:http/http.dart' as http;

class TransactionRepository {
  //   Future<void> GetTransactions() async {
  //   this.isLoading = true;

  //   String endpoint = Constants.apiBaseUrl + 'transaction/transactions';

  //   var data = await http.get(endpoint);
  //   var jsonData = json.decode(data.body);
  //   print(jsonData);
  //   List<Transaction> newTransactions = [];
  //   for (var usr in jsonData['data']) {
  //     Transaction transaction = new Transaction(usr['id'], usr['name'], usr['last_name'],
  //         usr['avatar'], usr['email']);
  //     newTransactions.add(transaction);
  //   }
  //   if (jsonData['next_page_url'] != null) {
  //     endpoint = jsonData['next_page_url'];
  //   } else {
  //     hasMore = false;
  //   }

  //   await addNewTransactions(newTransactions);

  //   return newTransactions;
  // }

}
