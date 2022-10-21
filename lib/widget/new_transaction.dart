import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction_list.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final tittleInputController = TextEditingController();
  final VInputController = TextEditingController();

  DateTime _SelectedDate;

  void SubmitData() {
    if (VInputController.text.isEmpty) {
      return;
    }
    final enteredTitle = tittleInputController.text;
    final enteredAmount = double.parse(VInputController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _SelectedDate == null) {
      return;
    }

    widget.addtx(enteredTitle, enteredAmount,_SelectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
              2020,
            ),
            lastDate: DateTime.now())
        .then((pickedate) {
      if (pickedate == null) {
        return;
      }
      setState(() {
        _SelectedDate = pickedate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // ignore: prefer_const_constructors
              TextField(
                decoration: InputDecoration(labelText: 'Tittle'),
                controller: tittleInputController,
                keyboardType: TextInputType.text,
                // onChanged: (val) {
                //   tittleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: VInputController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => SubmitData(),

                // onChanged: (val) {
                //   valueInput = val;
                // }
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _SelectedDate == null
                            ? 'No Date Chosen'
                            : 'Picked Date: ${DateFormat.yMd().format(_SelectedDate)}',
                        style:
                            TextStyle(color: Color.fromARGB(255, 208, 1, 245)),
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        'Add Date',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        _presentDatePicker();
                      },
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  SubmitData();
                },
                color: Color.fromARGB(252, 36, 185, 116),
              )
            ],
          ),
        ));
  }
}
