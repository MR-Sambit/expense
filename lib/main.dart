import './widget/chart.dart';
import 'package:flutter/material.dart';
import './widget/transaction_list.dart';
import './widget/new_transaction.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.tealAccent,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(fontFamily: 'Opensans', fontSize: 25)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String titleInput;
  // final titleController = TextEditingController();
  // final amountController = TextEditingController();

  final List<Transaction> _userTransactions = [
    //*****DEMO Transactions****
    // Transaction(
    //   id: 'Demo_1',
    //   tittle: 'Demo_1',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'Demo_2',
    //   tittle: 'Demo_2',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosendate) {
    final newTx = Transaction(
      tittle: txTitle,
      amount: txAmount,
      date: chosendate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void StartAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Manager'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                StartAddNewTransaction(context);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Chart(_recentTransactions)),
          TransactionList(_userTransactions, _deleteTransaction)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          StartAddNewTransaction(context);
        },
      ),
    );
  }
}

// // sdk: ">=2.11.0 <3.0.0"
