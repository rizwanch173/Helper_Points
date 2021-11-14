import '../../../exports.dart';

class AddWalletScreen extends StatefulWidget {
  @override
  _AddWalletScreenState createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
  TransferMethodController _tmc = Get.find<TransferMethodController>();
  final GlobalKey<FormBuilderState> _itemkey = GlobalKey<FormBuilderState>();
  WalletsController _walletsController = Get.find<WalletsController>();
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
            'Add a new ' + (_tmc.currentMethod?.name ?? '') + ' wallet',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text('SAVE'),
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              onTap: () async {
                if (_tmc.isLoading == true) return;
                if (_itemkey.currentState!.saveAndValidate()) {
                  await _walletsController
                      .create(_itemkey.currentState!.value['account_number']);
                }
              },
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: FormBuilder(
                key: _itemkey,
                child: FormBuilderTextField(
                  name: 'account_number',
                  maxLines: 1,
                  obscureText: false,
                  decoration: InputDecoration(
                      labelText: _tmc.currentMethod?.accontIdentifierMechanism,
                      //focusedBorder: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.edit,
                      )),
                  validator: FormBuilderValidators.compose([
                    //FormBuilderValidators.minLength(1),

                    FormBuilderValidators.required(context),
                  ]),
                ),
              ),
            ),
            GetBuilder<WalletsController>(builder: (controller) {
              if (controller.isLoading == true) {
                return Center(child: CircularProgressIndicator());
              } else {
                return SizedBox(height: 10);
              }
            })
          ],
        ),
      ),
    );
  }
}
