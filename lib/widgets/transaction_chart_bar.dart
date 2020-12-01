import 'package:flutter/material.dart';

class TransactionChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentangeOfTotal;

  TransactionChartBar(this.label, this.amount, this.percentangeOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            buildAmount(constraints),
            SizedBox(height: constraints.maxHeight * 0.05),
            buildBar(constraints, context),
            SizedBox(height: constraints.maxHeight * 0.05),
            buildDateText(constraints),
          ],
        );
      },
    );
  }

  Container buildAmount(BoxConstraints constraints) {
    return Container(
      height: constraints.maxHeight * 0.15,
      child: FittedBox(child: Text("${amount.toStringAsFixed(0)}₺")),
    );
  }

  Container buildBar(BoxConstraints constraints, BuildContext context) {
    return Container(
      height: constraints.maxHeight * 0.6,
      width: 10,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
          ),
          FractionallySizedBox(
            heightFactor: percentangeOfTotal,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDateText(BoxConstraints constraints) {
    return Container(
      height: constraints.maxHeight * 0.15,
      child: FittedBox(child: Text("${label.substring(0, 1)}")),
    );
  }
}
