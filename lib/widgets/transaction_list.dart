import '../models/transaction.dart';
import './transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  final Function updateTx;

  TransactionList(
    this.transactions,
    this.deleteTx,
    this.updateTx,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return TransactionItem(
            transaction: transactions[index],
            deleteTx: deleteTx,
            updateTx: updateTx,
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
