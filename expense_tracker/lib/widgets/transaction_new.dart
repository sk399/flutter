
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            onSubmitted: (context) => submitData(context),
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
            onSubmitted: (context) => submitData(context),
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: FlatButton(
              color: Theme.of(context).primaryColorDark,
              child: Text('Add transaction'),
              onPressed: () => submitData(context),
            ),
          )
        ],
      ),
    );
  }

  void submitData(context) {
    print(
        'Title ${this.titleController.text}:Amount ${this.amountController.text}');
    if (this.titleController.text.isEmpty ||
        this.amountController.text.isEmpty) {
      return;
    }
    widget.addTransaction(this.titleController.text, this.amountController.text);
    Navigator.of(context).pop();
  }
}
