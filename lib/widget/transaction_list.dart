// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delete;

  TransactionList(this.transactions, this.delete);

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height * 0.4,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text('No Transaction created till now',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: MediaQuery.maybeOf(context).size.height * 0.5,
                    child: Image.asset(
                      'assets/image/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: FittedBox(
                            child: Text(
                                '\₹${transactions[index].amount.toStringAsFixed(2)}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].tittle,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Text(
                          DateFormat('yMMMd').format(transactions[index].date),
                          style: TextStyle(
                              color: Color.fromARGB(255, 122, 107, 162))),
                      trailing: MediaQuery.of(context).size.height > 460
                          ? FlatButton.icon(
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                              textColor: Theme.of(context).errorColor,
                              onPressed: () => delete(transactions[index].id),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () => delete(transactions[index].id),
                            ),
                    ),
                  );
                  // Card(
                  //     child: Row(
                  //       children: <Widget>[
                  //         Container(
                  //           margin: EdgeInsets.symmetric(
                  //               vertical: 10, horizontal: 15),
                  //           decoration: BoxDecoration(
                  //               border: Border.all(
                  //                   color: Theme.of(context).primaryColorLight,
                  //                   width: 2)),
                  //           padding: EdgeInsets.all(5),
                  //           child: Text(
                  //             '\₹${transactions[index].amount.toStringAsFixed(2)}',
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Theme.of(context).primaryColorDark),
                  //           ),
                  //         ),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: <Widget>[
                  //             Text(
                  //               transactions[index].tittle,
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Theme.of(context).primaryColor),
                  //             ),
                  //             Text(
                  //               DateFormat('yMMMd')
                  //                   .format(transactions[index].date),
                  //               style: TextStyle(
                  //                   color: Color.fromARGB(255, 122, 107, 162)),
                  //             )
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   );
                },
                itemCount: transactions.length,
              ));
  }
}
