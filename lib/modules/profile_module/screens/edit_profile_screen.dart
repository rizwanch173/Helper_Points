import '../../../exports.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ProfileController _profileController = Get.find<ProfileController>();
  //File _image;
  final picker = ImagePicker();
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
            'Edit Profile',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero),
                  ),
                ),
                elevation: MaterialStateProperty.all(0),
              ),
              onPressed: () {
                Get.to(IdentityVerificationScreen());
              },
              child: Text('Identity verification'),
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          GetBuilder<ProfileController>(builder: (_profile) {
                            return Container(
                              width: 260.0,
                              height: 260.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: (Colors.grey[400])!),
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      (_profile.loggedUser?.avatar ?? '_')),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GetBuilder<ProfileController>(
                                builder: (_profile) {
                              return ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    shape: MaterialStateProperty.all(
                                      CircleBorder(),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        _profile.isLoading == true
                                            ? Colors.white
                                            : Color(0xFF305fd6)),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(28.0),
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        child: _profile.isLoading == true
                                            ? CircularProgressIndicator()
                                            : Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                      )),
                                  onPressed: () {
                                    getImage();
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
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Personal info',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF305fd6),
                    ),
                  ),
                ),
                Divider(),
                const SizedBox(
                  height: 20,
                ),
                PersonalInfoForm(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Change password',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF305fd6),
                    ),
                  ),
                ),
                Divider(),
                const SizedBox(
                  height: 20,
                ),
                ChangePasswordForm(),
                const SizedBox(
                  height: 50,
                ),
              ],
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
    if (_profileController.isLoading == true) return;
    try {
      var pickedFile = await picker.getImage(source: ImageSource.gallery);

      File image = File((pickedFile?.path ?? 'path'));
      String fileName = image.path.split('/').last;
      String filePath = image.path.replaceAll("/$fileName", '');
      String newFileName =
          DateTime.now().millisecondsSinceEpoch.toString() + fileName;
      String newFilePath = filePath + newFileName + '.jpg';

      File _compressedImage = await testCompressAndGetFile(image, newFilePath);
      if (pickedFile != null) {
        await _profileController.updateAvatar(_compressedImage);
        //Call controller to upload the image to server
      } else {
        Get.snackbar('Error', 'No Image Selected',
            margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900]);
      }
    } catch (err) {
      print(err);
    }
  }
}
