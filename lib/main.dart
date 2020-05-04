import 'dart:math';

import 'package:flutter/material.dart';

import 'API.dart';
import 'Menu.dart';
import 'NewExpense.dart';
import 'ListExpenses.dart';
import 'Reimbursements.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Manager',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        Menu.homeRouteName: (context) => MyHomePage(title: "Finance Tracker"),
        NewExpense.routeName: (context) => NewExpense(),
        Menu.listExpensesRouteName: (context) => ListExpenses(),
        Menu.reimbursementsRouteName: (context) => Reimbursements(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return null;
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Icon(Icons.swap_horiz),
      ),
      endDrawer: Menu(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Account Breakdown',
                style: Theme.of(context).textTheme.title,
              ),
              Divider(
                color: Colors.grey,
              ),
              Expanded(
                child: _buildAccountOverview(),
              ),
              Divider(
                color: Colors.grey,
              ),
              Text(
                'Total Amount:',
                style: Theme.of(context).textTheme.title,
              ),
              Text(
                '\$' + ExpenseList.getGrandTotal(),
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _awaitReturnValue(context);
        },
        tooltip: 'Add Expense',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildAccountOverview() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: max(ExpenseList.getNumAccounts() * 2, 1),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;

          if (ExpenseList.getNumAccounts() == 0)
            return ListTile(title: Text("No Expenses Added"));
          return _buildRow(ExpenseList.getAccountName(index));
        });
  }

  Widget _buildRow(String account) {
    return ListTile(
      title: Text(account),
      subtitle: Text('\$' + ExpenseList.getAccountTotal(account)),
    );
  }

  void _awaitReturnValue(BuildContext context) async {
    await Navigator.pushNamed(context, NewExpense.routeName);
    setState(() {});
  }
}
