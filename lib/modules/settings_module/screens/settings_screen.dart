import '../../../exports.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ProfileController _profileController = Get.put(ProfileController());
  LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.5, color: (Colors.grey[400])!),
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                        image: DecorationImage(
                          image: NetworkImage(
                              (_profileController.loggedUser?.avatar ?? '_')),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    title: Text(
                      _profileController.loggedUser?.name ?? '',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(_profileController.loggedUser?.email ?? ''),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  // thickness: 1,
                  // color: Colors.grey,
                  // indent: 20,
                  // endIndent: 20,
                ),
                // Container(
                //   padding: EdgeInsets.all(20),
                //   margin: EdgeInsets.all(20),
                //   color: Colors.white,
                //   child: QrImage(
                //     data:
                //         '{"res_type":"user_profile","QrCode_generation":"${_profileController.loggedUser.id}","res_act":"send"}',
                //     version: QrVersions.auto,
                //     // embeddedImage: NetworkImage(_profileController.loggedUser.avatar),
                //     // embeddedImageStyle: QrEmbeddedImageStyle(
                //     //   size: Size(80, 80),
                //     // ),
                //     size: 300.0,
                //   ),
                // ),
                Divider(
                  height: 0,
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.send),
                    title: Text(
                      'Send',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text('Tranasfer money to friends and family'),
                  ),
                  onTap: () {
                    Get.bottomSheet(SendAmountForm());
                  },
                ),
                Divider(
                  height: 0,
                  indent: 75,
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.help),
                    title: Text(
                      'Help',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text('FAQ, contact us'),
                  ),
                  onTap: () async {
                    String url = Constants.whatsAppChatlink;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ],
            ),
            Column(
              children: [
                Divider(
                  height: 0,
                  indent: 75,
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      'Logout',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: () {
                    _loginController.logout();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
