import '../../../exports.dart';
import 'package:http/http.dart' as http;

class DepositMethodRepository {
  Future<List<DepositMethod?>?> getMethods(String token) async {
    DepositMethodController _depositMethodController =
        Get.find<DepositMethodController>();

    if (_depositMethodController.hasMore == false) {
      return null;
    }

    try {
      var resp = await http
          .post(_depositMethodController.endpoint, headers: <String, String>{
        //'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      });

      if (resp.statusCode == 200) {
        List<DepositMethod> methods = [];
        var jsonData = jsonDecode(resp.body);
        for (var method in jsonData['data']) {
          DepositMethod _m = DepositMethod(
            method['id'].toString(),
            method['name'].toString(),
            method['thumb'].toString(),
            method['method_identifier_field__name'].toString(),
            method['how_to_api'].toString(),
            Currency(
              method['currencies'][0]['id'].toString(),
              method['currencies'][0]['name'].toString(),
              method['currencies'][0]['symbol'].toString(),
              method['currencies'][0]['is_crypto'].toString(),
              method['currencies'][0]['thumb'].toString(),
              method['currencies'][0]['code'].toString(),
            ),
          );
          methods.add(_m);
        }
        if (jsonData['next_page_url'] != null) {
          _depositMethodController.endpoint = jsonData['next_page_url'];
        } else {
          _depositMethodController.hasMore = false;
        }
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
