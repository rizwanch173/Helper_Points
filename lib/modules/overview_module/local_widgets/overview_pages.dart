import '../../../exports.dart';

class OverviewPages extends StatefulWidget {
  @override
  _OverviewPagesState createState() => _OverviewPagesState();
}

class _OverviewPagesState extends State<OverviewPages> {
  int _selectedPage = 0;
  PageController? _pageController;

  void _changePage(int pageNumber) {
    setState(() {
      _selectedPage = pageNumber;

      // _pageController.animateToPage(
      //   pageNumber,
      //   duration: const Duration(
      //     milliseconds: 500,
      //   ),
      //   curve: Curves.easeInOut,
      // );
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TabButton(
                  text: 'Deposits',
                  pageNumber: 0,
                  selectedPage: _selectedPage,
                  onPressed: () {
                    _changePage(0);
                  },
                ),
                TabButton(
                  text: 'Withdrawals',
                  pageNumber: 1,
                  selectedPage: _selectedPage,
                  onPressed: () {
                    _changePage(1);
                  },
                ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     // controller: _pageController,
          //     // onPageChanged: (int page) {
          //     //   setState(() {
          //     //     _selectedPage = page;
          //     //   });
          //     // },
          //     Container(
          //       width: MediaQuery.of(context).size.width,
          //       child: Center(child: Text('page 1')),
          //     ),
          //     Container(
          //       width: MediaQuery.of(context).size.width,
          //       child: Center(child: Text('Page 2')),
          //     )
          //   ],
          // ),
          TabContent(
            selectedPage: _selectedPage,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: DepositsList(),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: WithdrawalList(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final int? selectedPage;
  final List<Widget?>? children;
  TabContent({this.selectedPage, this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: children?[selectedPage!],
    );
  }
}

class TabButton extends StatelessWidget {
  final String? text;
  final int? selectedPage;
  final int? pageNumber;
  final Function()? onPressed;
  TabButton({this.text, this.selectedPage, this.pageNumber, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.width / 2.5,
        duration: Duration(
          milliseconds: 500,
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: selectedPage == pageNumber
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 12.0 : 0,
          horizontal: selectedPage == pageNumber ? 12.0 : 0,
        ),
        margin: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 0 : 12.0,
          horizontal: selectedPage == pageNumber ? 0 : 12.0,
        ),
        child: Center(
          child: Text(
            text ?? 'TabButton',
            style: TextStyle(
              color: selectedPage == pageNumber ? Colors.white : Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
