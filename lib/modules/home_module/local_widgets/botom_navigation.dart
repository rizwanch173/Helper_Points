import '../../../exports.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  ProfileController _profileController = Get.put(ProfileController());
  HomeController _homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _homeController.currentTab == 'Overview'
              ? OverviewScreen()
              : _homeController.currentTab == 'Transactions'
                  ? TransactionsScreen()
                  : _homeController.currentTab == 'Scan to pay'
                      ? ScanScreen()
                      : _homeController.currentTab == 'Catalogue'
                          ? CatalogueScreen()
                          : SettingsScreen(),
        ),
        //Tab bar
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: (Colors.grey[200])!,
              ),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 10,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tabBarButton(context, Icon(Icons.track_changes), 'Overview'),
                tabBarButton(context, Icon(Icons.receipt_long), 'Transactions'),
                tabBarButton(context, Icon(Icons.qr_code), 'Scan to pay'),
                tabBarButton(context, Icon(Icons.storefront), 'Catalogue'),
                tabBarButton(context, Icon(Icons.admin_panel_settings), ''),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget tabBarButton(BuildContext context, Icon icon, String title) {
    return Container(
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              title == ''
                  ? Container(
                      width: 34.0,
                      height: 34.0,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.5, color: (Colors.grey[400])!),
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                        image: DecorationImage(
                          image: _profileController.loggedUser?.avatar == null
                              ? MemoryImage(kTransparentImage)
                              : NetworkImage(
                                  (_profileController.loggedUser?.avatar ??
                                      '_profileController.loggedUser?.avatar is null'),
                                ) as ImageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : Icon(
                      icon.icon,
                      size: 34,
                      color: _homeController.currentTab == title
                          ? Theme.of(context).primaryColor
                          : Color(0xFF1B3A4E),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  _homeController.currentTab == title ? title : "",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _homeController.currentTab == title
                        ? Theme.of(context).primaryColor
                        : Color(0xFF1B3A4E),
                  ),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          setState(() {
            _homeController.updateTab(title);
          });
        },
      ),
    );
  }
}
