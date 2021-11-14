import '../../../exports.dart';
import 'package:intl/intl.dart';

class DepositsList extends StatefulWidget {
  @override
  _DepositsListState createState() => _DepositsListState();
}

class _DepositsListState extends State<DepositsList> {
  DepositController _depositController = Get.put(DepositController());

  Future? _future;

  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    _future = _depositController.getDeposits();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositController>(
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
                        (controller.depositList?.length ?? 0) > 0) {
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
                          Get.to(DepositMethodsScreen());
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
                                  'Make your first deposit !',
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
            if (controller.depositList != null)
              for (Deposit? deposit in (controller.depositList)!)
                Container(
                  width: double.infinity,
                  height: 200,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          'Deposit to',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        deposit?.currency?.name ??
                                            '' + ' wallet',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          'Upload on',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        deposit?.createdAt ?? '',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      deposit?.currency?.isCrypto == '1'
                                          ? Text(
                                              double.parse(deposit?.net ?? '0')
                                                      .toString() +
                                                  ' ' +
                                                  (deposit?.currency?.code ??
                                                      '0'),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              oCcy.format(double.parse(
                                                      deposit?.net ?? '0')) +
                                                  ' ' +
                                                  (deposit?.currency?.code ??
                                                      ''),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        deposit?.transactionStatus?.name ?? '',
                                        style: TextStyle(
                                            color: deposit?.transactionStatus
                                                        ?.name ==
                                                    'Pending'
                                                ? Colors.black
                                                : (deposit?.transactionStatus
                                                                ?.name ??
                                                            '') ==
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
            (controller.depositList?.length ?? 0) > 0 &&
                    controller.hasMore == true
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
                                'Load more deposits',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_depositController.isLoading == false)
                                controller.getDeposits();
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
