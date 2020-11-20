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
                  SizedBox(height: 10,),
                  Container(
                    height: 200,
                    child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover,))
                ],
              )
              : ListView.builder(
                  itemBuilder: (buildContext, index) {
                    return Card(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor)),
                                child: Text(
                                  '\$${transactions[index].amount.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transactions[index].title,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                DateFormat.yMMMd()
                                    .format(transactions[index].date),
                                style: TextStyle(
                                    fontSize: 10, color: Colors.blueGrey),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: transactions.length,
                )),
    );
  }
}
