import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/API.dart';
import 'package:moneymanager/NewExpense.dart';
import 'Menu.dart';

class ListExpenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        leading: Icon(Icons.swap_horiz),
      ),
      endDrawer: Menu(),
      body: ListExpensesSF(),
    );
  }
}

class ListExpensesSF extends StatefulWidget {
  @override
  ListExpensesState createState() => ListExpensesState();
}

class ListExpensesState extends State<ListExpensesSF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: ExpenseList.numExpenses * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final expense = ExpenseList.expenses[i ~/ 2];
          DateTime date = expense['date'];
          return ListTile(
            trailing: Text(
              '\$' + expense['amount'].toStringAsFixed(2),
              style: Theme.of(context).textTheme.subhead,
            ),
            title: Text("${date.year} / ${date.month} / ${date.day}"),
            subtitle: Text(expense['account']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, NewExpense.routeName);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
