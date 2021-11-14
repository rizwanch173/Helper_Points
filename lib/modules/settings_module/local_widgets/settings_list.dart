import '../../../exports.dart';

class SettingsList extends StatefulWidget {
  @override
  _SettingsListState createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  LoginController _loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: GetBuilder<ProfileController>(builder: (_profile) {
                      if (_profile.loggedUser == null)
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ],
                        );
                      if (_profile.loggedUser != null)
                        return Container(
                          width: 60.0,
                          height: 60.0,
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

                      return SizedBox();
                    }),
                    title: GetBuilder<ProfileController>(builder: (_profile) {
                      if (_profile.loggedUser == null)
                        return SizedBox(
                          width: 10,
                        );
                      if (_profile.loggedUser != null)
                        return Text(
                          _profile.loggedUser?.name ?? '',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        );
                      return SizedBox();
                    }),
                    subtitle:
                        GetBuilder<ProfileController>(builder: (_profile) {
                      if (_profile.loggedUser == null)
                        return SizedBox(
                          width: 10,
                        );
                      if (_profile.loggedUser != null)
                        return Text(_profile.loggedUser?.email ?? '');
                      return SizedBox();
                    }),
                    trailing:
                        GetBuilder<ProfileController>(builder: (_profile) {
                      if (_profile.loggedUser == null)
                        return SizedBox(
                          width: 10,
                        );
                      if (_profile.loggedUser != null)
                        return IconButton(
                          icon: Icon(Icons.settings, color: Color(0xFF1B3A4E)),
                          onPressed: () {
                            Get.to(EditProfileScreen());
                          },
                        );
                      return SizedBox();
                    }),
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
                    leading: Icon(Icons.add, color: Color(0xFF1B3A4E)),
                    title: Text(
                      'Deposit',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text('Add credit to your wallets'),
                  ),
                  onTap: () {
                    Get.to(DepositMethodsScreen());
                  },
                ),

                Divider(
                  height: 0,
                  indent: 75,
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.remove, color: Color(0xFF1B3A4E)),
                    title: Text(
                      'Withdraw',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text('Spend your wallets money'),
                  ),
                  onTap: () {
                    Get.to(WithdrwaMethodsScreen());
                  },
                ),

                Divider(
                  height: 0,
                  indent: 75,
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.send, color: Color(0xFF1B3A4E)),
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
                    leading: Icon(Icons.storefront, color: Color(0xFF1B3A4E)),
                    title: Text(
                      'Catalogue',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text('Your products and services catalogue'),
                  ),
                  onTap: () {
                    Get.to(CatalogueScreen());
                  },
                ),
                Divider(
                  height: 0,
                  indent: 75,
                ),

                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.help, color: Color(0xFF1B3A4E)),
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
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Divider(
                  height: 0,
                  indent: 75,
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Color(0xFF1B3A4E),
                    ),
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
