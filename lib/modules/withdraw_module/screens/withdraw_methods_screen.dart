import '../../../exports.dart';
import 'package:intl/intl.dart';

class WithdrwaMethodsScreen extends StatefulWidget {
  @override
  _WithdrwaMethodsScreenState createState() => _WithdrwaMethodsScreenState();
}

class _WithdrwaMethodsScreenState extends State<WithdrwaMethodsScreen> {
  WalletsController _wlc = Get.find<WalletsController>();
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Add credit to your wallets',
            style: TextStyle(fontSize: 14),
          ),
        ),
        body: Container(
          child: GetBuilder<DepositMethodController>(builder: (controller) {
            return ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                for (Wallet? wallet in _wlc.userWallets)
                  ListTile(
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
                              (wallet?.transferMethod?.thumbnail ?? '_')),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    title: Text(wallet?.transferMethod?.name ?? ''),
                    subtitle: Text(oCcy
                            .format(double.parse(wallet?.amount ?? '0'))
                            .toString() +
                        ' ' +
                        (wallet?.currency?.code ?? '').toString()),
                    onTap: () {
                      Get.bottomSheet(WithdrawalAmountForm());
                    },
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
