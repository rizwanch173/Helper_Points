import '../../../exports.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatefulWidget {
  @override
  _TransactionsListState createState() => _TransactionsListState();
}

// leading: CachedNetworkImage(
//     imageUrl:
//         'http://via.placeholder.com/200x150',
//     placeholder: (context, url) =>
//         CircularProgressIndicator(),
//     errorWidget: (context, url, error) {
//       return Icon(Icons.error);
// }),

class _TransactionsListState extends State<TransactionsList> {
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  bool headerIsSet = false;
  Future? _future;
  // ScrollController _controller = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  ScrollController _controller = ScrollController();
  TransactionsController _transactionsController =
      Get.put(TransactionsController());
  //Constructor
  _TransactionsListState() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        print('hasMore_' + _transactionsController.hasMore.toString());

        Future.delayed(const Duration(seconds: 5), () {
          if (_transactionsController.hasMore == false) return;
          if (_transactionsController.isLoading == true) return;

          print('isLoading _' +
              _transactionsController.isLoading.toString() +
              '|' 'hasMore_' +
              _transactionsController.hasMore.toString());
          _future = _transactionsController.getTransactions();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _future = _transactionsController.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GetBuilder<TransactionsController>(builder: (controller) {
        return FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData == true ||
                  _transactionsController.transactionsList.length > 0) {
                return ListView.builder(
                    itemCount: controller.transactionsList.length + 1,
                    controller: _controller,
                    itemBuilder: (context, index) {
                      if (index < controller.transactionsList.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading:
                                controller.transactionsList[index].moneyFlow ==
                                        '-'
                                    ? Icon(
                                        Icons.remove,
                                        color: Colors.grey,
                                      )
                                    : Icon(Icons.add,
                                        color: Theme.of(context).primaryColor),
                            trailing: controller.transactionsList[index]
                                        .currency?.isCrypto ==
                                    '1'
                                ? Text((controller.transactionsList[index]
                                            .moneyFlow ??
                                        '') +
                                    ' ' +
                                    double.parse(controller.transactionsList[index].net ?? '0')
                                        .toString() +
                                    ' ' +
                                    (controller.transactionsList[index].currency
                                            ?.code ??
                                        ''))
                                : Text(
                                    (controller.transactionsList[index].moneyFlow ??
                                            '') +
                                        ' ' +
                                        oCcy.format(
                                            double.parse(controller.transactionsList[index].net ?? '0')) +
                                        ' ' +
                                        (controller.transactionsList[index].currency?.code ?? ''),
                                    style: TextStyle(fontWeight: FontWeight.normal)),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  (controller.transactionsList[index]
                                          .activityTitle ??
                                      ''),
                                  style: TextStyle(
                                    color: controller.transactionsList[index]
                                                .moneyFlow ==
                                            '-'
                                        ? Colors.grey
                                        : Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    (controller.transactionsList[index]
                                            .entityName ??
                                        ''),
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                controller.transactionsList[index].createdAt ??
                                    '',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            onTap: () {},
                          ),
                        );
                      } else if (controller.hasMore) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Column(
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
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        );
                    });
              }
              if (snapshot.hasData == false &&
                  snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                );
              }

              if (snapshot.hasData == false &&
                  snapshot.connectionState == ConnectionState.done) {
                return Column(
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
                      child: Center(
                        child: Text(
                          'You have not done transactions so far !',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (snapshot.hasError) {
                return Text('Something Went Wrong');
              }
              return Text('Something Went Wrong');
            });
      }),
    );
  }
}
