import 'dart:math';

import 'package:flutter/material.dart';

import 'AppLibrary.dart';
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
      initialRoute: MyHomePage.routeName,
      routes: {
        MyHomePage.routeName: (context) => MyHomePage(title: "Finance Tracker"),
        NewExpense.routeName: (context) => NewExpense(),
        ListExpenses.routeName: (context) => ListExpenses(),
        Reimbursements.routeName: (context) => Reimbursements(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = '/';

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
      endDrawer: Drawer(
          child: ListView(
        padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
        children: <Widget>[
          ListTile(
            title: Text(
              'Accounts',
              style: Theme.of(context).textTheme.title,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
              title: Text('Expenses', style: Theme.of(context).textTheme.title),
              onTap: () {
                Navigator.pushReplacementNamed(context, ListExpenses.routeName);
              }),
          ListTile(
            title: Text(
              "Reimbursements",
              style: Theme.of(context).textTheme.title,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, Reimbursements.routeName);
            },
          ),
        ],
      )),
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
                '\$' + ExpenseList.grandTotal.toStringAsFixed(2),
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
        itemCount: max(ExpenseList.accounts.length * 2, 1),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;

          if (ExpenseList.accounts.length == 0)
            return ListTile(title: Text("No Expenses Added"));
          return _buildRow(ExpenseList.accounts[index]);
        });
  }

  Widget _buildRow(String account) {
    return ListTile(
      title: Text(account),
      subtitle: Text('\$' + ExpenseList.total[account].toStringAsFixed(2)),
    );
  }

  void _awaitReturnValue(BuildContext context) async {
    await Navigator.pushNamed(context, NewExpense.routeName);
    setState(() {});
  }
}
