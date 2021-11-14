import '../../../exports.dart';
import 'package:intl/intl.dart';

final oCcy = new NumberFormat("#,##0.00", "en_US");

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  // WalletsController _walletsController = Get.find<WalletsController>();
  ProfileController _profileController = Get.find<ProfileController>();
  SendController _sendController = Get.find<SendController>();

  //TransactionsController _transactionsController =
  //Get.find<TransactionsController>();
  //HomeController _homeController = Get.find<HomeController>();

  LoginController _loginController = Get.find<LoginController>();

  final List<Widget> _currentWidget = [
    OverviewScreen(),
    ScanScreen(),
    TransactionsScreen(),
  ];

  void _taped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getLoggedUser() async {
    if (_profileController.loggedUser == null) {
      await _profileController.getMe();
    }
    _sendController.setSendTo(_profileController.loggedUser!);
  }

  @override
  void initState() {
    super.initState();
    getLoggedUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: MainDrawer(),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Constants.appName,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          elevation: 0,
          // actions: [
          //   PopupMenuButton<String>(
          //     padding: EdgeInsets.only(top: 8.0),
          //     onSelected: handleClick,
          //     itemBuilder: (BuildContext context) {
          //       return {'Send money', 'Logout'}.map((String choice) {
          //         return PopupMenuItem<String>(
          //           value: choice,
          //           child: Text(choice),
          //         );
          //       }).toList();
          //     },
          //   ),
          // ],

          // bottom: PreferredSize(
          //   preferredSize: Size.fromHeight(4.0), // here the desired height
          //   child: Obx(
          //     () => _loadingController.isLoading.value == 1
          //         ? LinearProgressIndicator()
          //         : PreferredSize(
          //             preferredSize:
          //                 Size.fromHeight(0.1), // here the desired height
          //             child: SizedBox(),
          //           ),
          //   ),
          // ),
        ),
        // drawer: Drawer(
        //   child: MainDrawer(),
        // ),
        //BottomNavigation(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: _currentWidget[_selectedIndex],
            )
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Color(0xFF305fd6),
        //   child: Icon(
        //     Icons.bolt,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     Get.bottomSheet(Container(
        //       color: Colors.white,
        //       child: SettingsList(),
        //     ));
        //   },
        // ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _taped,
          currentIndex: _selectedIndex,
          selectedFontSize: 14,
          backgroundColor: Colors.white, // Color(0xff0b1c26),
          iconSize: 34,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedFontSize: 14,
          selectedItemColor:
              Theme.of(context).primaryColor, //Color(0xfff5a623),
          unselectedItemColor: Color(0xFF1B3A4E), //Color(0xff58778b),
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.track_changes),
              label: 'Overview',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'Transactions',
            ),
          ],
        ),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        {
          _loginController.logout();
        }
        break;

      case 'Send money':
        {
          Get.bottomSheet(SendAmountForm());
        }
        break;

      default:
        break;
    }
  }
}
