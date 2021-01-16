import 'package:flutter/material.dart';

import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (context, constraint) {
                return Column(
                  children: [
                    Text('No Transactions added yet!'),
                    SizedBox(
                      height: constraint.maxHeight * .05,
                    ),
                    Container(
                        height: constraint.maxHeight * .7, //200,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ))
                  ],
                );
              })
            : ListView.builder(
                itemBuilder: (buildContext, index) {
                  return TransactionItem(
                      transaction: transactions[index], deleteTx: deleteTx);
                },
                itemCount: transactions.length,
              ));
  }
}
