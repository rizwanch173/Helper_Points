import '../../../exports.dart';
import 'package:intl/intl.dart';

class TransferMethodsScreen extends StatefulWidget {
  @override
  _TransferMethodsScreenState createState() => _TransferMethodsScreenState();
}

class _TransferMethodsScreenState extends State<TransferMethodsScreen> {
  TransferMethodController _tmc = Get.find<TransferMethodController>();
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  @override
  void initState() {
    _tmc.getMethods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Add a new wallet',
            style: TextStyle(fontSize: 14),
          ),
        ),
        body: Container(
          child: GetBuilder<TransferMethodController>(builder: (controller) {
            if (controller.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  for (TransferMethod method in controller.methodList)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        leading: Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: (Colors.grey[400])!),
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                            image: DecorationImage(
                              image: NetworkImage((method.thumbnail ?? '_')),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        title: Text(method.name ?? ''),
                        onTap: () {
                          controller.setCurrentMethod(method);
                          Get.to(AddWalletScreen());
                        },
                      ),
                    ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
