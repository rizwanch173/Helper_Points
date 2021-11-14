import '../../../exports.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  ProfileController _profileController = Get.find<ProfileController>();
  SendController _sendController = Get.find<SendController>();
  ScanController _scanController = Get.find<ScanController>();
  CatalogueController _catalogueController = Get.find<CatalogueController>();
  String? scanResult;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(),
                child: Center(
                  child: SizedBox(
                    width: 10.0,
                    height: 10.0,
                  ),
                ),
              ),
              IconButton(
                color: Color(0xFF1B3A4E),
                iconSize: 276.0,
                icon: Icon(Icons.qr_code_scanner),
                onPressed: () {
                  scanQRCode();
                },
              ),
              GetBuilder<ScanController>(
                  builder: (_scan) => _scan.isLoading == true
                      ? RefreshProgressIndicator()
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF1B3A4E)),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Click to scan',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () {
                            scanQRCode();
                          },
                        )),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#2196f3', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      this.scanResult = qrCode;
      //base64 constructor
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      var data =
          jsonDecode(stringToBase64.decode((this.scanResult ?? 'base64')));

      switch (data['res_type']) {
        case 'user_profile':
          {
            _scanController.waiting();
            Get.bottomSheet(SendAmountForm());
            User? user =
                await _profileController.getProfile(data['QrCode_generation']);
            _sendController.setSendTo(user!);
            _scanController.finished();
          }
          break;

        case 'item':
          {
            scanItem(data['QrCode_generation']);
          }
          break;

        case 'merchant_item':
          {
            Get.bottomSheet(SendAmountForm());
          }
          break;

        case 'request_link':
          {
            Get.bottomSheet(SendAmountForm());
          }
          break;

        default:
          break;
      }
    } catch (e) {
      print('exxxxxceptio  ' + e.toString());
      Get.snackbar('Error', 'Failed to get platform versioin',
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          colorText: Colors.white,
          backgroundColor: Colors.red[700]);
    }
  }

  Future<void> scanItem(item) async {
    _scanController.waiting();
    await _catalogueController.getItem(item);
    _scanController.finished();
    Get.to(ItemScreen());
  }
}
