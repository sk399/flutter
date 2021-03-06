import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'widgets/transaction_new.dart';

import 'models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final currScaleFactor = MediaQuery.textScaleFactorOf(context);
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
                headline6: TextStyle(
                    fontFamily: 'OpenSans', fontSize: 20 * currScaleFactor))),
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20 * currScaleFactor,
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // print(state);
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  var uuid = Uuid();
  List<Transaction> transactions = [];
  void _startTransaction(BuildContext ctxt) {
    print('start Transaction');
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        context: ctxt,
        builder: (buildContext) {
          return GestureDetector(
            onTap: () => {},
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(buildContext).viewInsets.bottom),
                    child: NewTransaction(_addTransaction),
                  )
                ],
              ),
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

  List<Widget> _createLandscapeContent(MediaQueryData mediaQuery,
      PreferredSizeWidget appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'show Chart',
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
            value: _showChart,
            onChanged: (value) {
              setState(() {
                _showChart = value;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  .7,
              child: Chart(_recentTransactions))
          : txListWidget
    ];
  }

  List<Widget> _createPortraitContent(MediaQueryData mediaQuery,
      PreferredSizeWidget appBar, Widget txListWidget) {
    return [
      Container(
          constraints: BoxConstraints(minHeight: 0.0),
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              .3,
          child: Chart(_recentTransactions)),
      txListWidget
    ];
  }

  PreferredSizeWidget _createAdaptiveAppBar(BuildContext context) {
    final appTitleWidget = const Text('Personal Expense Tracker');
    // ignore: dead_code
    if (kIsWeb) {
      return AppBar(
        title: appTitleWidget,
        actions: <Widget>[
          Builder(
              builder: (context) => IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => _startTransaction(context),
                  )),
        ],
      );
    }
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: appTitleWidget,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => _startTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: appTitleWidget,
            actions: <Widget>[
              Builder(
                  builder: (context) => IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => _startTransaction(context),
                      )),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _createAdaptiveAppBar(context);
    final txListWidget = Container(
        constraints: BoxConstraints(minHeight: 0.0),
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            .7,
        child: TransactionList(transactions, _deleteTransaction));
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              ..._createLandscapeContent(mediaQuery, appBar, txListWidget),
            if (!isLandscape)
              ..._createPortraitContent(mediaQuery, appBar, txListWidget),
          ],
        ),
      ),
    );
    if (kIsWeb) {
      return Scaffold(
          appBar: appBar,
          body: pageBody,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container());
    }
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : Builder(
                    builder: (context) => FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () => _startTransaction(context),
                    ),
                  ));
  }
}
