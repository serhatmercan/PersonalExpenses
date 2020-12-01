import './widgets/transaction_add.dart';
import './widgets/transaction_chart.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: buildTheme(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final appBar = AppBar(title: Text("Personal Expenses"));
  bool _showChart = false;

  final List<Transaction> _transactions = [
    Transaction(
      id: DateTime.now().toString(),
      title: "Shopping",
      amount: 125.75,
      date: DateTime.now(),
    )
  ];

  void _addTransaction(String txTitle, double txAmount, DateTime txDate) {
    final tx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );

    setState(() {
      _transactions.add(tx);
    });
  }

  void _updateTransaction(
      String txId, String txTitle, double txAmount, DateTime txDate) {
    final tx = Transaction(
      id: txId,
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );

    setState(() {
      var index = _transactions.indexWhere((item) => item.id == txId);

      _transactions.replaceRange(index, index + 1, [tx]);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _showTransactionAdd(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: TransactionAdd(_addTransaction),
          onTap: () {},
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: appBar,
      body: buildBody(isLandscape),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: buildFloatingActionButtonLocation(),
    );
  }

  SingleChildScrollView buildBody(isLandscape) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildShowChart(),
          _showChart
              ? buildLandscapeContent(isLandscape)
              : buildPortraitContent(),
        ],
      ),
    );
  }

  Row buildShowChart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Show Chart"),
        Switch.adaptive(
          activeColor: Theme.of(context).accentColor,
          value: _showChart,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          },
        )
      ],
    );
  }

  Container buildLandscapeContent(isLandscape) {
    return Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          (isLandscape ? 0.7 : 0.3),
      child: TransactionChart(_recentTransactions),
    );
  }

  Container buildPortraitContent() {
    return Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(
        _transactions,
        _deleteTransaction,
        _updateTransaction,
      ),
    );
  }

  Builder buildFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showTransactionAdd(context),
      ),
    );
  }

  FloatingActionButtonLocation buildFloatingActionButtonLocation() =>
      FloatingActionButtonLocation.centerFloat;
}

ThemeData buildTheme() {
  return ThemeData(
    primarySwatch: Colors.red,
  );
}
