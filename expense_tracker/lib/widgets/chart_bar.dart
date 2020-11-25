import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double spendingAmount;
  final double percentageOfTotalAmount;
  final String label;
  ChartBar(this.spendingAmount, this.percentageOfTotalAmount, this.label);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (buildContext, constraint) {
        return Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                height: constraint.maxHeight * .1,  //20,
                child: FittedBox(child: Text('\$${this.spendingAmount}'))),
            SizedBox(
              height: constraint.maxHeight * .05,
            ),
            Container(
              height: constraint.maxHeight * .6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          color: Color.fromRGBO(220, 220, 220, 1),
                          borderRadius: BorderRadius.circular(10))),
                  FractionallySizedBox(
                    heightFactor: percentageOfTotalAmount,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * .05
            ),
            Container(height: constraint.maxHeight *.1, child: FittedBox(child: Text(label)))
          ],
        );
      },
    );
  }
}
