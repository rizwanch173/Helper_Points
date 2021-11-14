import '../../../exports.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';

class CatalogueRepository {
  Uri createEndpoint = Uri.parse(Constants.restApiBaseUrl + '/item/create');
  Uri itemEndpoint = Uri.parse(Constants.restApiBaseUrl + '/item/get');
  Uri paymentEndpoint = Uri.parse(Constants.restApiBaseUrl + '/payment/create');

  Future<Item?> create(
    File file,
    String filename,
    String price,
    String description,
    String name,
    String currencyid,
  ) async {
    LoginController _loginController = Get.find<LoginController>();
    var request = http.MultipartRequest(
      'POST',
      //Uri.parse('{$f.createEndpoint}'
      this.createEndpoint,
    );
    Map<String, String> headers = {
      "Authorization": "Bearer ${_loginController.token}",
      "Content-type": "multipart/form-data"
    };
    request.files.add(
      http.MultipartFile(
        'thumbnail',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      "name": name,
      "price": price,
      "description": description,
      "currency_id": currencyid,
    });

    final res = await request.send();
    final respStr = await res.stream.bytesToString();
    final data = jsonDecode(respStr);
    if (res.statusCode == 200) {
      if (data['error'] == true) {
        Get.snackbar(
          'Error',
          data['message'],
          margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.grey[900],
        );
        return null;
      }
      final itemData = data['data'];
      Item item = Item(
        itemData['id'].toString(),
        itemData['user_id'].toString(),
        itemData['name'].toString(),
        itemData['code'].toString(),
        itemData['price'].toString(),
        itemData['description'].toString(),
        itemData['thumbnail'].toString(),
        itemData['created_at'].toString(),
        Currency(
          itemData['currency']['id'].toString(),
          itemData['currency']['name'].toString(),
          null,
          itemData['currency']['is_crypto'].toString(),
          null,
          itemData['currency']['code'].toString(),
        ),
        User(
          itemData['user']['id'].toString(),
          itemData['user']['email'].toString(),
          itemData['user']['name'].toString(),
          itemData['user']['first_name'].toString(),
          itemData['user']['last_name'].toString(),
          itemData['user']['avatar'].toString(),
          itemData['user']['verified'].toString(),
          itemData['user']['identity_verified'].toString(),
        ),
      );
      Get.snackbar('Success ', 'New item added to catalogue!',
          duration: Duration(seconds: 10),
          margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.grey[900]);
      return item;
    }

    if (res.statusCode == 401) {
      _loginController.logout();
    }
    Get.snackbar('Error ' + res.statusCode.toString(),
        'Somethinh went wrong, try again later.',
        margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.grey[900]);

    return null;
  }

  Future<List<Item?>?> geItems() async {
    CatalogueController _catalogueController = Get.find<CatalogueController>();
    LoginController _loginController = Get.find<LoginController>();

    if (_catalogueController.hasMore == false) {
      return null;
    }

    try {
      var resp = await http
          .post(_catalogueController.endpoint, headers: <String, String>{
        //'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + _loginController.token!
      });

      if (resp.statusCode == 200) {
        List<Item> items = [];
        var jsonData = jsonDecode(resp.body);
        if (jsonData['error'].toString() == 'true') {
          Get.snackbar('Error', jsonData['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
          return null;
        }
        for (var item in jsonData['data']) {
          items.add(
            Item(
              item['id'].toString(),
              item['user_id'].toString(),
              item['name'].toString(),
              item['code'].toString(),
              item['price'].toString(),
              item['description'].toString(),
              item['thumbnail'].toString(),
              item['created_at'].toString(),
              Currency(
                item['currency']['id'].toString(),
                item['currency']['name'].toString(),
                null,
                item['currency']['is_crypto'].toString(),
                null,
                item['currency']['code'].toString(),
              ),
              User(
                item['user']['id'].toString(),
                item['user']['email'].toString(),
                item['user']['name'].toString(),
                item['user']['first_name'].toString(),
                item['user']['last_name'].toString(),
                item['user']['avatar'].toString(),
                item['user']['verified'].toString(),
                item['user']['identity_verified'].toString(),
              ),
            ),
          );
        }

        if (jsonData['next_page_url'] != null) {
          _catalogueController.endpoint = Uri.parse(jsonData['next_page_url']);
        } else {
          _catalogueController.hasMore = false;
        }
        return items;
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

  Future<Item?> getItem(String id) async {
    LoginController _loginController = Get.find<LoginController>();

    try {
      var resp = await http.post(this.itemEndpoint, body: {
        'item_id': id,
      }, headers: <String, String>{
        //'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + _loginController.token!
      });
      if (resp.statusCode == 200) {
        var jsonData = jsonDecode(resp.body);
        if (jsonData['error'].toString() == 'true') {
          Get.snackbar('Error', jsonData['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
          return null;
        }
        var data = jsonData['data'];
        Item item = Item(
          data['id'].toString(),
          data['user_id'].toString(),
          data['name'].toString(),
          data['code'].toString(),
          data['price'].toString(),
          data['description'].toString(),
          data['thumbnail'].toString(),
          data['created_at'].toString(),
          Currency(
            data['currency']['id'].toString(),
            data['currency']['name'].toString(),
            null,
            data['currency']['is_crypto'].toString(),
            null,
            data['currency']['code'].toString(),
          ),
          User(
            data['user']['id'].toString(),
            data['user']['email'].toString(),
            data['user']['name'].toString(),
            data['user']['first_name'].toString(),
            data['user']['last_name'].toString(),
            data['user']['avatar'].toString(),
            data['user']['verified'].toString(),
            data['user']['identity_verified'].toString(),
          ),
        );

        return item;
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

  Future<bool?> makePayment(String id) async {
    LoginController _loginController = Get.find<LoginController>();

    try {
      var resp = await http.post(paymentEndpoint, body: {
        'item_id': id,
      }, headers: <String, String>{
        'Authorization': 'Bearer ' + _loginController.token!
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
        print(response['data']);
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
