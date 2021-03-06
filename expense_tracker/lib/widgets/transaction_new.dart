import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import './adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction) {
    //print('Constructor : NewTransaction');
  }

  @override
  _NewTransactionState createState() {
    //print('State : Create State');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    //print('Constructor : TransactionState');
  }

  @override
  void initState() {
    //print('Init State()');
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
   // print('didUpdateWidget()');
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
   // print('dispose()');
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   // print('build()');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            onSubmitted: (_) => submitData(context),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})'))
            ],
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
            onSubmitted: (_) {
              submitData(context);
            },
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No date selected'
                      : 'Selected Date:${DateFormat.yMd().format(_selectedDate)}'),
                ),
                AdpativeFlatButton('Select date', _showDatePicker)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Theme.of(context).buttonTheme.colorScheme.primary),
              child: Text('Add transaction'),
              onPressed: () {
                submitData(context);
              },
            ),
          )
        ],
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 7)),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget child) {
          return FittedBox(
            child: child,
          );
        }).then((value) {
      if (value == null) {
        return;
      }
      FocusScope.of(context).requestFocus(new FocusNode());
      setState(() {
        _selectedDate = value;
      });
    });
  }

  void submitData(context) {
    if (this.titleController.text.isEmpty ||
        this.amountController.text.isEmpty ||
        _selectedDate == null) {
      return;
    }
    widget.addTransaction(
        this.titleController.text, this.amountController.text, _selectedDate);
    Navigator.of(context).pop();
  }
}
