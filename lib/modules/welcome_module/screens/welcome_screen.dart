import '../../../exports.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentPage = 0;
  PageController? _pageViewController;

  List<Widget> _slidingItems = [
    FirstItem(),
    SecondItem(),
    TirdItem(),
    ForthItem(),
  ];

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white, //Color(0xFF102839),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 1.03,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: 50),
                              child: Image.asset('assets/logo.png'),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(20),
                            //   child: Text(
                            //     Constants.appName,
                            //     style: TextStyle(
                            //       // color: Colors.grey,
                            //       fontSize: 38,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              child: PageView(
                                children: _slidingItems,
                                controller: _pageViewController,
                                onPageChanged: (int index) {
                                  setState(() {
                                    _currentPage = index;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < _slidingItems.length; i++)
                                Container(
                                  margin: EdgeInsets.all(5),
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: i == _currentPage
                                        ? Color(0xFF305fd6)
                                        : Theme.of(context).primaryColor,
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 40, right: 40),
                  child: Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xFF305fd6),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                ),
                              ),
                            ),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text('Login'),
                          ),
                          onPressed: () {
                            Get.to(LoginScreen());
                          },
                        ),
                      ),
                    ),
                    // Container(
                    //   height: 50,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Container(
                    //         height: 1,
                    //         color: Colors.white,
                    //         width: 150,
                    //       ),
                    //       Text(
                    //         'or',
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.normal),
                    //       ),
                    //       Container(
                    //         height: 1,
                    //         color: Colors.white,
                    //         width: 150,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xFF305fd6), //Color(0xFFf5a623),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                              ),
                            ),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text('Sign Up'),
                          ),
                          onPressed: () {
                            Get.to(RegisterScreen());
                          },
                        ),
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
