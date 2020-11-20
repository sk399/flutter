import 'widgets/transaction_new.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Transaction> transactions = [
    // Transaction(
    //     id: null, title: 'New Transaction', amount: 12.3, date: DateTime.now())
  ];

  void _startTransaction(BuildContext ctxt) {
    print('start Transaction');
    showModalBottomSheet(
        context: ctxt,
        builder: (_) {
          return GestureDetector(
            onTap: () => {},
            child: NewTransaction(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _addTransaction(String title, String amount) {
    Transaction tx = Transaction(
        id: null,
        title: title,
        amount: double.parse(amount),
        date: DateTime.now());

    setState(() {
      transactions.add(tx);
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
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
            color: Colors.cyanAccent,
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(fontFamily: 'OpenSans', fontSize: 20))),
        textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Personal Expense Tracker'),
            actions: <Widget>[
              Builder(
                  builder: (context) => IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => _startTransaction(context),
                      )),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Chart(_recentTransactions),
                TransactionList(transactions)
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startTransaction(context),
            ),
          )),
    );
  }
}
