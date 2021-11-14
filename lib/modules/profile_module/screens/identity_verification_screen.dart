import '../../../exports.dart';
import 'dart:io';

class IdentityVerificationScreen extends StatefulWidget {
  @override
  _IdentityVerificationScreenState createState() =>
      _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState
    extends State<IdentityVerificationScreen> {
  ProfileController _profileController = Get.find<ProfileController>();
  //File _image;
  final picker = ImagePicker();
  Future? _future;
  @override
  void initState() {
    super.initState();
    _future = _profileController.getVerification();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Account verification',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          actions: [
            GetBuilder<ProfileController>(builder: (_prof) {
              return Flexible(
                child: _prof.loggedUser?.identityVerified == '1'
                    ? ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                            ),
                          ),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        onPressed: () {},
                        child: Text('Verifyed !'),
                      )
                    : _prof.loggedUser?.identityVerification?.isDone == '1'
                        ? ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.zero),
                                ),
                              ),
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey),
                            ),
                            onPressed: () {},
                            child: Text('Being processed.'),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.zero),
                                ),
                              ),
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            onPressed: () {},
                            child: Text('Not Verified !'),
                          ),
              );
            })
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData == true ||
                  _profileController.loggedUser?.identityVerification != null) {
                if (_profileController
                        .loggedUser?.identityVerification?.isAproved ==
                    '0') {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'Upload Front Side',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF305fd6),
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  GetBuilder<ProfileController>(
                                      builder: (_profile) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      height: 260.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.5,
                                            color: (Colors.grey[400])!),
                                        color: Colors.grey[400],
                                        image: DecorationImage(
                                          image: _profileController
                                                      .loggedUser
                                                      ?.identityVerification
                                                      ?.front ==
                                                  null
                                              ? MemoryImage(kTransparentImage)
                                              : NetworkImage((_profile
                                                      .loggedUser
                                                      ?.identityVerification
                                                      ?.front ??
                                                  '_')) as ImageProvider,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  }),
                                  Positioned(
                                    bottom: 0,
                                    width: 50,
                                    height: 50,
                                    right: 0,
                                    child: GetBuilder<ProfileController>(
                                        builder: (_profile) {
                                      return ElevatedButton(
                                          style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    _profile.isLoading == true
                                                        ? Colors.white
                                                        : Color(0xFF305fd6)),
                                          ),
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            child: _profile.isLoading == true
                                                ? CircularProgressIndicator()
                                                : Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                  ),
                                          ),
                                          onPressed: () {
                                            getImageForFront();
                                          });
                                    }),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'Upload Back Side',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF305fd6),
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  GetBuilder<ProfileController>(
                                      builder: (_profile) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      height: 260.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.5,
                                            color: (Colors.grey[400])!),
                                        color: Colors.grey[400],
                                        image: DecorationImage(
                                          image: _profileController
                                                      .loggedUser
                                                      ?.identityVerification
                                                      ?.back ==
                                                  null
                                              ? MemoryImage(kTransparentImage)
                                              : NetworkImage((_profile
                                                      .loggedUser
                                                      ?.identityVerification
                                                      ?.back ??
                                                  '_')) as ImageProvider,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  }),
                                  Positioned(
                                    bottom: 0,
                                    width: 50,
                                    height: 50,
                                    right: 0,
                                    child: GetBuilder<ProfileController>(
                                        builder: (_profile) {
                                      return ElevatedButton(
                                          style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    _profile.isLoading == true
                                                        ? Colors.white
                                                        : Color(0xFF305fd6)),
                                          ),
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            child: _profile.isLoading == true
                                                ? CircularProgressIndicator()
                                                : Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                  ),
                                          ),
                                          onPressed: () {
                                            getImageForBack();
                                          });
                                    }),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  );
                }
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
                return SizedBox();
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Future getImageForFront() async {
    if (_profileController.loggedUser?.identityVerification?.isDone == '1') {
      Get.snackbar('Error', 'your verification is waiting to be processed',
          margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.grey[900]);
      return;
    }
    if (_profileController.isLoading == true) return;
    try {
      var pickedFile = await picker.getImage(source: ImageSource.gallery);

      File image = await compressFile(File((pickedFile?.path ?? '_')));

      if (pickedFile != null) {
        setState(() {
          // _image = File(pickedFile.path)
          //_image = image;
          // print(pickedFile.path);
          // print(_image.absolute.path);
        });
        await _profileController.frontId(image);
        //Call controller to upload the image to server
      } else {
        Get.snackbar('Error', 'No Image Selected',
            margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900]);
        return;
      }
    } catch (err) {
      print(err);
    }
  }

  Future getImageForBack() async {
    if (_profileController.loggedUser?.identityVerification?.isDone == '1') {
      Get.snackbar('Error', 'your verification is waiting to be processed',
          margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.grey[900]);
      return;
    }
    if (_profileController.isLoading == true) return;
    try {
      var pickedFile = await picker.getImage(source: ImageSource.gallery);

      File image = await compressFile(File((pickedFile?.path ?? 'path')));

      if (pickedFile != null) {
        setState(() {
          // _image = File(pickedFile.path)
          //_image = image;
          // print(pickedFile.path);
          // print(_image.absolute.path);
        });
        await _profileController.backId(image);
        //Call controller to upload the image to server
      } else {
        Get.snackbar('Error', 'No Image Selected',
            margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900]);
        return;
      }
    } catch (err) {
      print(err);
    }
  }

  Future<File> compressFile(File file) async {
    final filePath = file.absolute.path;

    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath =
        "$splitted${DateTime.now().millisecondsSinceEpoch}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 60,
    );

    // print(file.lengthSync());
    // print(result.lengthSync());
    if (result != null) return result;

    throw ('file not found');
  }
}
