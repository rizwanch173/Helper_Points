import '../../../exports.dart';
import 'package:intl/intl.dart';

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  CatalogueController _catalogueController = Get.find<CatalogueController>();
  ProfileController _profileController = Get.find<ProfileController>();
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(
        //   color: Colors.black, //change your color here
        // ),
        backgroundColor: Colors.black12,
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(_catalogueController.currentItem?.currency?.code ?? ''),
            SizedBox(
              width: 10,
            ),
            Text(_catalogueController.currentItem?.currency?.isCrypto == '1'
                ? double.parse(_catalogueController.currentItem?.price ?? '')
                    .toString()
                : oCcy.format(
                    double.parse(_catalogueController.currentItem?.price ?? ''),
                  )),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 320,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: _catalogueController.currentItem?.thumbnail == null
                        ? MemoryImage(kTransparentImage)
                        : NetworkImage(
                            (_catalogueController.currentItem?.thumbnail ??
                                '')) as ImageProvider,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    // Positioned(
                    //   right: 0,
                    //   bottom: 0,
                    //   child: Container(
                    //     width: 50,
                    //     height: 50,
                    //     color: Colors.black45,
                    //     child: InkWell(
                    //         child: Icon(
                    //           Icons.open_in_new,
                    //           color: Colors.white,
                    //         ),
                    //         onTap: () {
                    //           //Get.to(ItemImage());
                    //         }),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  _catalogueController.currentItem?.name ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0),
                child: Text(
                  _catalogueController.currentItem?.description ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 70,
            )
          ],
        ),
      ),
      floatingActionButton: GetBuilder<CatalogueController>(
          builder: (_catalogue) => _catalogue.isLoading == false
              ? FloatingActionButton.extended(
                  backgroundColor: _profileController.loggedUser?.id ==
                          _catalogueController.currentItem?.user?.id
                      ? Color(0xff3160d6)
                      : Colors.teal[800],
                  elevation: 4.0,
                  icon: _profileController.loggedUser?.id ==
                          _catalogueController.currentItem?.user?.id
                      ? Icon(Icons.qr_code)
                      : Icon(Icons.payment),
                  label: _profileController.loggedUser?.id ==
                          _catalogueController.currentItem?.user?.id
                      ? Text('Qr Code')
                      : Text('Pay for Item'),
                  onPressed: () async {
                    _profileController.loggedUser?.id ==
                            _catalogueController.currentItem?.user?.id
                        ? Get.bottomSheet(qrCode())
                        : await _catalogueController.makePayment(
                            _catalogueController.currentItem?.id ?? '0');
                  },
                )
              : FloatingActionButton.extended(
                  backgroundColor: _profileController.loggedUser?.id ==
                          _catalogueController.currentItem?.user?.id
                      ? Color(0xff3160d6)
                      : Colors.teal[800],
                  elevation: 4.0,
                  icon: _profileController.loggedUser?.id ==
                          _catalogueController.currentItem?.user?.id
                      ? Icon(Icons.qr_code)
                      : Icon(Icons.payment),
                  label: _profileController.loggedUser?.id ==
                          _catalogueController.currentItem?.user?.id
                      ? Text('Qr Code')
                      : Text(' Loading'),
                  onPressed: () async {
                    _profileController.loggedUser?.id ==
                            _catalogueController.currentItem?.user?.id
                        ? Get.bottomSheet(qrCode())
                        : await _catalogueController.makePayment(
                            _catalogueController.currentItem?.id ?? '0');
                  },
                )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ));
  }

  Widget qrCode() {
    String data =
        '{"res_type":"item","QrCode_generation":"${this._catalogueController.currentItem?.id}","res_act":"payment"}';
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(data); // dXNlcm5hbWU6cGFzc3dvcmQ=
    //String decoded = stringToBase64.decode(encoded);

    return Container(
      height: 440,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 50, bottom: 50),
            color: Colors.white,
            child: QrImage(
              data: encoded,
              version: QrVersions.auto,
              // embeddedImage: NetworkImage(_profileController.loggedUser.avatar),
              // embeddedImageStyle: QrEmbeddedImageStyle(
              //   size: Size(80, 80),
              // ),
              size: 300.0,
            ),
          ),
        ],
      ),
    );
  }
}
