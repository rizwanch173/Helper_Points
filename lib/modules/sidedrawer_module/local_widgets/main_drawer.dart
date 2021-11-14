import '../../../exports.dart';

class MainDrawer extends StatefulWidget {
  MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  //ProfileController _profileController = Get.put(ProfileController());
  LoginController _loginController = Get.put(LoginController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: GetBuilder<ProfileController>(builder: (controller) {
              return Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                      ),
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(
                            (controller.loggedUser?.avatar ?? '_')),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        controller.loggedUser?.name ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        controller.loggedUser?.email ?? '',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          ListTile(
            leading: Icon(Icons.add, color: Color(0xFF1B3A4E)),
            title: Text('Deposit'),
            onTap: () => Get.to(DepositMethodsScreen()),
          ),
          ListTile(
            leading: Icon(Icons.remove, color: Color(0xFF1B3A4E)),
            title: Text('Withdraw'),
            onTap: () => Get.to(WithdrwaMethodsScreen()),
          ),
          ListTile(
            leading: Icon(Icons.send, color: Color(0xFF1B3A4E)),
            title: Text('Send'),
            onTap: () => Get.bottomSheet(SendAmountForm()),
          ),
          ListTile(
            leading: Icon(Icons.storefront, color: Color(0xFF1B3A4E)),
            title: Text('Catalogue'),
            onTap: () => Get.to(CatalogueScreen()),
          ),
          ListTile(
            leading: Icon(
              Icons.quickreply,
              color: Color(0xFF1B3A4E),
            ),
            title: Text('Quick support'),
            onTap: () async {
              String url = Constants.whatsAppChatlink;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Color(0xFF1B3A4E)),
            title: Text('Settings'),
            onTap: () => Get.to(EditProfileScreen()),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Color(0xFF1B3A4E),
            ),
            title: Text('Logout'),
            onTap: () => _loginController.logout(),
          ),
        ],
      ),
    );
  }
}
