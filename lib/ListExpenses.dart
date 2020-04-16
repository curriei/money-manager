import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/AppLibrary.dart';
import 'package:moneymanager/NewExpense.dart';
import 'package:moneymanager/main.dart';

import 'Reimbursements.dart';

class ListExpenses extends StatelessWidget {
  static String routeName = 'listexpenses';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        leading: Icon(Icons.swap_horiz),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Accounts", style: Theme.of(context).textTheme.title),
              onTap: () {
                Navigator.pushReplacementNamed(context, MyHomePage.routeName);
              },
            ),
            ListTile(
              title: Text("Expenses", style: Theme.of(context).textTheme.title),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                "Reimbursements",
                style: Theme.of(context).textTheme.title,
              ),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, Reimbursements.routeName);
              },
            )
          ],
        ),
      ),
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
