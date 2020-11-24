import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          height: 300,
          child: transactions.isEmpty
              ? Column(
                  children: [
                    Text('No Transactions added yet!'),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 200,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ))
                  ],
                )
              : ListView.builder(
                  itemBuilder: (buildContext, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                          child: ListTile(
                        leading: CircleAvatar(
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                                          child: Text(
                                    '\$${(transactions[index].amount.toString())}'),
                              ),
                            )),
                        title: Text(transactions[index].title),
                        subtitle: Text(
                            DateFormat.yMMMd().format(transactions[index].date)),
                      ),
                    );
                  },
                  itemCount: transactions.length,
                )),
    );
  }
}
