import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionUpdate extends StatefulWidget {
  final Transaction transaction;
  final Function updateTx;

  TransactionUpdate(this.transaction, this.updateTx);

  @override
  _TransactionUpdateState createState() => _TransactionUpdateState();
}

class _TransactionUpdateState extends State<TransactionUpdate> {
  final _amountController = TextEditingController();

  void _submitData() {
    final enteredAmount = double.parse(_amountController.text);

    if (enteredAmount <= 0) {
      return;
    }

    widget.updateTx(
      widget.transaction.id,
      widget.transaction.title,
      enteredAmount,
      widget.transaction.date,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildTitleInput(),
              buildAmountInput(),
              buildDateText(),
              buildUpdateButton(context),
            ],
          ),
        ),
      ),
    );
  }

  TextField buildTitleInput() {
    return TextField(
      decoration: InputDecoration(
        enabled: false,
        labelText: "${widget.transaction.title}",
      ),
    );
  }

  TextField buildAmountInput() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Amount",
        hintText: "${widget.transaction.amount}",
      ),
      controller: _amountController,
      onSubmitted: (_) => _submitData(),
    );
  }

  Text buildDateText() {
    return Text(
      "Picked Date: ${DateFormat.yMd().format(widget.transaction.date)}",
    );
  }

  RaisedButton buildUpdateButton(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: _submitData,
      child: Text("Update"),
    );
  }
}
