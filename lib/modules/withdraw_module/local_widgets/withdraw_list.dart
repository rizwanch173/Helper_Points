import '../../../exports.dart';
import 'package:intl/intl.dart';

class WithdrawalList extends StatefulWidget {
  @override
  _WithdrawalListState createState() => _WithdrawalListState();
}

class _WithdrawalListState extends State<WithdrawalList> {
  WithdrawController _withdrawaController = Get.put(WithdrawController());

  Future? _future;

  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    _future = _withdrawaController.getWithdrawals();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawController>(
      builder: (controller) {
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              child: FutureBuilder(
                  future: _future,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData == true ||
                        controller.withdrawsList.length > 0) {
                      return SizedBox(
                        width: 1,
                      );
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
                      return GestureDetector(
                        onTap: () {
                          Get.to(WithdrwaMethodsScreen());
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3,
                          padding: EdgeInsets.symmetric(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Icon(
                                  Icons.tab_unselected,
                                  color: Colors.grey,
                                  size: 46,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Make your first withdraw !',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Text('Something Went Wrong');
                    }

                    return Container();
                  }),
            ),
            for (Withdraw withdraw in controller.withdrawsList)
              Container(
                width: double.infinity,
                height: 250,
                margin: EdgeInsets.only(bottom: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'Withdraw to',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        withdraw.wallet.transferMethod
                                                ?.accontIdentifierMechanism ??
                                            '',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        withdraw.platformId,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'Request date',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      withdraw.createdAt,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'Amount',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      withdraw.currency.isCrypto == '1'
                                          ? double.parse(withdraw.net)
                                                  .toString() +
                                              ' ' +
                                              (withdraw.currency.code ?? '')
                                          : oCcy.format(
                                                double.parse(withdraw.net),
                                              ) +
                                              ' ' +
                                              (withdraw.currency.code ?? ''),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'Status',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      withdraw.transactionStatus.name ?? '',
                                      style: TextStyle(
                                          color:
                                              withdraw.transactionStatus.name ==
                                                      'Pending'
                                                  ? Colors.black
                                                  : withdraw.transactionStatus
                                                              .name ==
                                                          'Completed'
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 40,
            ),
            controller.withdrawsList.length > 0 && controller.hasMore == true
                ? SizedBox(
                    width: double.infinity,
                    child: controller.isLoading == true
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                controller.hasMore
                                    ? Color(0xfff5a623)
                                    : Colors.grey,
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Load more withdraws',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_withdrawaController.isLoading == false)
                                controller.getWithdrawals();
                            },
                          ),
                  )
                : SizedBox(
                    height: 20,
                  ),
            controller.hasMore == false
                ? Column(
                    children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                        size: 46,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'You\'re All Caught Up !',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 20,
                  ),
          ],
        );
      },
    );
  }
}
