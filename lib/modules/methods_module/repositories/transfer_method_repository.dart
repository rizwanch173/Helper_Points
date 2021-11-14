import 'package:http/http.dart' as http;
import '../../../exports.dart';

class TransferMethodRepository {
  Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/transfermethods/all');

  Future<List<TransferMethod?>?> getTransferMethods(String token) async {
    //  var resp = await http
    //       .post(_depositMethodController.endpoint, headers: <String, String>{
    //     //'Content-Type': 'application/json; charset=UTF-8',
    //     'Authorization': 'Bearer ' + token
    //   });
    try {
      var resp = await http.post(this.endpoint, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      });

      if (resp.statusCode == 200) {
        List<TransferMethod> methods = [];
        var jsonData = jsonDecode(resp.body);
        for (var method in jsonData['data']) {
          TransferMethod _m = TransferMethod(
            method['id'].toString(),
            method['name'].toString(),
            method['thumbnail'].toString(),
            method['accont_identifier_mechanism'].toString(),
            method['how_to_deposit'].toString(),
            method['how_to_withdraw'].toString(),
            method['days_to_process_transfer'].toString(),
            method['is_active'].toString(),
            method['deposit_percentage_fee'].toString(),
            method['deposit_fixed_fee'].toString(),
            method['withdraw_percentage_fee'].toString(),
            method['withdraw_fixed_fee'].toString(),
          );
          methods.add(_m);
        }
        // if (jsonData['next_page_url'] != null) {
        //   _depositMethodController.endpoint = jsonData['next_page_url'];
        // } else {
        //   _depositMethodController.hasMore = false;
        // }
        return methods;
      } else if (resp.statusCode == 401) {
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
