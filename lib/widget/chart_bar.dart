import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spending, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(
            fit: BoxFit.contain,
            child: Text('\$${spending.toStringAsFixed(0)}')),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromARGB(255, 99, 173, 237),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10))),
              ),
            ],
          ),
        ),
        SizedBox()
      ],
    );
  }
}
