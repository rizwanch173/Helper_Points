import '../../../exports.dart';
import 'package:intl/intl.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  CatalogueController _catalogueController = Get.find<CatalogueController>();

  Future? _future;

  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    _future = _catalogueController.getItems();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CatalogueController>(
      builder: (controller) {
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              child: FutureBuilder(
                  future: _future,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData == true ||
                        controller.itemList.length > 0) {
                      return SizedBox(
                        width: 1,
                      );
                    }

                    if (snapshot.hasData == false &&
                        snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      );
                    }

                    if (snapshot.hasData == false &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 3,
                        padding: EdgeInsets.symmetric(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Icon(
                                Icons.storefront,
                                color: Colors.grey,
                                size: 46,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, left: 20.0, right: 20.0),
                              child: Text(
                                'Create the first item for your products and',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Text(
                              'services catalogue .',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Text('Something Went Wrong');
                    }
                    return Text('Something Went Wrong');
                  }),
            ),
            for (Item? item in controller.itemList)
              Container(
                child: Card(
                  margin: EdgeInsets.only(bottom: 20),
                  child: InkWell(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, right: 20),
                                    child: Text(
                                      item?.name ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 40.0, bottom: 8.0),
                                    child: Text(
                                      item?.description ?? '',
                                      style: TextStyle(color: Colors.grey[900]),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      //softWrap: true,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, right: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          item?.currency?.code ?? '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        item?.currency?.isCrypto == '1'
                                            ? Text(
                                                double.parse(item?.price ?? '0')
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            : Text(
                                                oCcy.format(double.parse(
                                                    item?.price ?? '0')),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      item?.createdAt ?? '',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.only(
                                //   topRight: Radius.circular(10.0),
                                //   bottomRight: Radius.circular(10.0),
                                //   topLeft: Radius.circular(10.0),
                                //   bottomLeft: Radius.circular(10.0),
                                // ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                color: Colors.grey,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: item?.thumbnail == null
                                      ? MemoryImage(kTransparentImage)
                                      : NetworkImage((item?.thumbnail ?? '_'))
                                          as ImageProvider,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        _catalogueController.setCurrentItem(item!);
                        Get.to(ItemScreen());
                      }),
                ),
              ),
            SizedBox(
              height: 40,
            ),
            controller.itemList.length > 0 && controller.hasMore == true
                ? SizedBox(
                    width: double.infinity,
                    child: controller.isLoading == true
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                controller.hasMore
                                    ? Color(0xfff5a623)
                                    : Colors.grey,
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Load more items',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_catalogueController.isLoading == false)
                                controller.getItems();
                            },
                          ),
                  )
                : SizedBox(
                    height: 20,
                  ),
            controller.hasMore == false
                ? Column(
                    children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                        size: 46,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'You\'re All Caught Up !',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 20,
                  ),
          ],
        );
      },
    );
  }
}
