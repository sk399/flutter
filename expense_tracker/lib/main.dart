import 'widgets/transaction_new.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
            color: Colors.purple,
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20))),
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.purple,
          textTheme: ButtonTextTheme.primary,
          colorScheme:
              Theme.of(context).colorScheme.copyWith(secondary: Colors.purple),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  var uuid = Uuid();
  List<Transaction> transactions = [];
  void _startTransaction(BuildContext ctxt) {
    print('start Transaction');
    showModalBottomSheet(
        isScrollControlled: true,
        // enableDrag: true,
        context: ctxt,
        builder: (buildContext) {
          return GestureDetector(
            onTap: () => {},
            child: Wrap(
              children: [Padding(
                padding:  EdgeInsets.only(bottom: MediaQuery.of(buildContext).viewInsets.bottom),
                child: NewTransaction(_addTransaction),
              )],
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _addTransaction(String title, String amount, DateTime txDate) {
    Transaction tx = Transaction(
        id: uuid.v1(),
        title: title,
        amount: double.parse(amount),
        date: txDate);
    setState(() {
      transactions.add(tx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return transactions
        .where(
            (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Personal Expense Tracker'),
      actions: <Widget>[
        Builder(
            builder: (context) => IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startTransaction(context),
                )),
      ],
    );

    final txListWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            .7,
        child: TransactionList(transactions, _deleteTransaction));

    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('show Chart'),
                    Switch(
                      value: _showChart,
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      },
                    ),
                  ],
                ),
              if (!isLandscape)
                Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        .3,
                    child: Chart(_recentTransactions)),
              if (!isLandscape) txListWidget,
              if (isLandscape)
                _showChart
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            .7,
                        child: Chart(_recentTransactions))
                    : txListWidget,
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startTransaction(context),
          ),
        ));
  }
}
