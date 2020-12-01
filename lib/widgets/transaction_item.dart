import './transaction_update.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
    @required this.updateTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;
  final Function updateTx;

  void _showTransactionUpdate(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: TransactionUpdate(transaction, updateTx),
          onTap: () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: buildAmountCircle(),
        title: buildTitleText(),
        subtitle: buildDateText(),
        trailing: buildDeleteButton(),
        onTap: () => _showTransactionUpdate(context),
      ),
    );
  }

  CircleAvatar buildAmountCircle() {
    return CircleAvatar(
      radius: 30,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: FittedBox(
          child: Text("${transaction.amount} ₺"),
        ),
      ),
    );
  }

  Text buildTitleText() => Text(transaction.title);

  Text buildDateText() => Text(DateFormat.yMMMd().format(transaction.date));

  IconButton buildDeleteButton() {
    return IconButton(
      color: Colors.red,
      icon: Icon(Icons.delete),
      onPressed: () => {
        deleteTx(transaction.id),
      },
    );
  }
}
