import '../../../exports.dart';
import 'dart:io';

class UploadDepositScreen extends StatefulWidget {
  @override
  _UploadDepositScreenState createState() => _UploadDepositScreenState();
}

class _UploadDepositScreenState extends State<UploadDepositScreen> {
  File? _image;
  final picker = ImagePicker();
  DepositController _depositController = Get.put(DepositController());
  DepositMethodController _depositMethodController =
      Get.put(DepositMethodController());
  WalletsController _walletsController = Get.find<WalletsController>();

  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();

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
    if (_depositController.isLoading == true) return;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<DepositController>(builder: (_deposit) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            _walletsController.currentWallet?.transferMethod?.name ?? '',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0), // here the desired height
            child: _deposit.isLoading == true
                ? LinearProgressIndicator()
                : PreferredSize(
                    preferredSize:
                        Size.fromHeight(0.1), // here the desired height
                    child: SizedBox(),
                  ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Stack(children: [
                    Draggable(
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _image == null
                                ? MemoryImage(kTransparentImage)
                                : FileImage((_image)!) as ImageProvider,
                          ),
                        ),
                      ),
                      feedback: _image == null
                          ? Image.memory(kTransparentImage)
                          : Image.file((_image!)),
                    ),
                    Center(
                      child: _deposit.isLoading == false
                          ? ElevatedButton(
                              child: Icon(Icons.photo_library),
                              onPressed: () {
                                getImage();
                              })
                          : SizedBox(child: RefreshProgressIndicator()),
                    ),
                  ]),
                ),
                FormBuilder(
                  key: _fbkey,
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        name: 'transaction_id',
                        maxLines: 1,
                        obscureText: false,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            border: InputBorder.none,
                            labelText: 'transaction id',
                            prefixIcon: Icon(Icons.edit)),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      FormBuilderTextField(
                        name: 'message',
                        maxLines: 20,
                        obscureText: false,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            border: InputBorder.none,
                            labelText: 'Message to Reviewer',
                            prefixIcon: Icon(Icons.mail)),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                    ],
                  ),
                )
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
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xff3160d6),
          elevation: 4.0,
          icon: Icon(Icons.add),
          label: Text('Upload deposit'),
          onPressed: () async {
            if (_image == null) return;
            if (_depositMethodController.isLoading == true) return;
            if (_fbkey.currentState!.saveAndValidate()) {
              _depositController.submitDeposit(
                (_image)!,
                _fbkey.currentState!.value['message'],
                _walletsController.currentWallet?.id ?? '0',
                _fbkey.currentState!.value['transaction_id'],
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }));
  }
}
