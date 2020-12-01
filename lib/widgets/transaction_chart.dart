import './transaction_chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TransactionChart extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionChart(this.transactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double sum = 0;

      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          sum += transactions[i].amount;
        }
      }

      return {"day": DateFormat.E().format(weekDay), "amount": sum};
    }).reversed.toList();
  }

  double get totalAmount {
    return groupedTransactionValues.fold(
        0, (sum, item) => sum + item["amount"]);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: groupedTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: TransactionChartBar(
                e["day"],
                e["amount"],
                totalAmount == 0 ? 0 : (e["amount"] as double) / totalAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
