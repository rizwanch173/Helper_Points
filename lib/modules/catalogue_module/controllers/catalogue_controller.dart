import '../../../exports.dart';
import 'dart:io';

class CatalogueController extends GetxController {
  List<Item?> itemList = [];
  CatalogueRepository? _repo;
  Item? currentItem;
  bool hasMore = true;
  bool isLoading = false;
  Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/items/get');

  CatalogueController() {
    this._repo = CatalogueRepository();
  }

  Future<void> create(File file, String currencyId, String name, String price,
      String description) async {
    HomeController _homeController = Get.find<HomeController>();
    waiting(); // 1 for loading 0 for completed
    String fileName = basename(file.path);

    Item? item = await _repo?.create(
        file, fileName, price, description, name, currencyId);
    if (item != null) {
      //this.resetController();
      this.itemList.insert(0, item);
      finished();
      update();
      _homeController.updateTab('Catalogue');
      Get.offAll(HomeScreen());
    } else {
      print('repository error');
    }
    finished();
  }

  Future<void> getItems() async {
    waiting(); // 1 for loading 0 for completed
    List<Item?>? items = await this._repo?.geItems();
    if (items != null) {
      for (Item? item in items) {
        itemList.add(item);
      }
    }
    finished();
    update();
  }

  Future<void> getItem(String id) async {
    Item? item = await this._repo?.getItem(id);
    if (item != null) {
      setCurrentItem(item);
      update();
    } else {}
  }

  Future<void> resetController() async {
    this.endpoint = Uri.parse(Constants.restApiBaseUrl + '/items/get');
    this.itemList = [];
    this.hasMore = true;
    //await this.getDeposits();
  }

  void setCurrentItem(Item item) {
    this.currentItem = item;
    update();
  }

  void waiting() {
    this.isLoading = true;
    update();
  }

  void finished() {
    this.isLoading = false;
    update();
  }

  Future<void> makePayment(String id) async {
    TransactionsController _transactionsController =
        Get.find<TransactionsController>();

    waiting();
    var payment = await this._repo?.makePayment(id);
    if (payment != null) {
      _transactionsController.reset();
      update();
      finished();
      Get.offAll(HomeScreen());
    } else {}
  }
}
