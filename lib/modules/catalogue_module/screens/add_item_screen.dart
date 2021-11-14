import '../../../exports.dart';
import 'dart:io';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  File? _image;
  final picker = ImagePicker();
  final GlobalKey<FormBuilderState> _itemkey = GlobalKey<FormBuilderState>();

  WalletsController _walletsController = Get.find<WalletsController>();
  CatalogueController _catalogueController = Get.find<CatalogueController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          actions: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text('SAVE'),
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              onTap: () async {
                if (_image == null) return;
                if (_catalogueController.isLoading == true) return;
                if (_itemkey.currentState!.saveAndValidate()) {
                  if (double.parse(
                          _itemkey.currentState!.value['price_field']) ==
                      0) {
                    Get.snackbar('Error', 'The amount must be greater than 0',
                        margin: EdgeInsets.only(
                            bottom: 50.0, left: 20.0, right: 20.0),
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        backgroundColor: Colors.grey[900]);
                    return;
                  }
                  await _catalogueController.create(
                    _image!,
                    _walletsController.currentWallet?.currency?.id ?? '0',
                    _itemkey.currentState!.value['name_field'],
                    _itemkey.currentState!.value['price_field'],
                    _itemkey.currentState!.value['description_field'],
                  );
                }
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: FormBuilder(
            key: _itemkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      'Image',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _image == null
                              ? MemoryImage(kTransparentImage)
                              : FileImage((_image)!) as ImageProvider,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GetBuilder<CatalogueController>(
                              builder: (_catalogue) {
                            if (_catalogue.isLoading == false)
                              return Container(
                                color: Colors.white,
                                height: 50,
                                width: 50,
                                child: Icon(Icons.camera_alt_outlined),
                              );
                            if (_catalogue.isLoading == true)
                              return RefreshProgressIndicator();

                            return Text('Loading ...');
                          }),
                        ],
                      ),
                    ),
                    onTap: () {
                      getImage();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Item currency',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SimpleCurrencyList(),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    name: 'name_field',
                    maxLines: 1,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: ' Item name',
                      //focusedBorder: InputBorder.none,
                      // prefixIcon: Icon(
                      //   Icons.attach_money,
                      // )
                    ),
                    validator: FormBuilderValidators.compose([
                      //FormBuilderValidators.minLength(1),

                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    name: 'price_field',
                    maxLines: 1,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      //focusedBorder: InputBorder.none,
                      // prefixIcon: Icon(
                      //   Icons.attach_money,
                      // )
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    name: 'description_field',
                    maxLines: 5,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: ' Description ',
                      //focusedBorder: InputBorder.none,
                      // prefixIcon: Icon(
                      //   Icons.attach_money,
                      // )
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 60,
    );

    print(file.lengthSync());
    print(result?.lengthSync());
    if (result != null) return result;

    throw ('compression error');
  }

  Future getImage() async {
    if (_catalogueController.isLoading == true) return;
    try {
      var pickedFile = await picker.getImage(source: ImageSource.gallery);

      File image = File((pickedFile?.path ?? 'path'));
      String fileName = image.path.split('/').last;
      String filePath = image.path.replaceAll("/$fileName", '');
      String newFileName =
          DateTime.now().millisecondsSinceEpoch.toString() + fileName;
      String newFilePath = filePath + newFileName + '.jpg';

      File _compressedImage = await testCompressAndGetFile(image, newFilePath);
      setState(() {
        _image = _compressedImage;
      });
    } catch (err) {
      print(err);
    }
  }
}
